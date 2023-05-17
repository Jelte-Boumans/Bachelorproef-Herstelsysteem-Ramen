/*
  This is the firmware for the datalogger needed in the new window replacement system for the MR08 trains.

  IMPORTANT:
    - Select Board: "Arduino Nano" and Processor: "ATmega328p (old bootloader)".
    - If you're going to use the Serial monitor to send the password, make sure the Serial monitor is set to "No Line Ending".

  Written by: Jelte Boumans 3ITIOT
  Bachelorproef AP Hogeschool
*/


#include <Adafruit_BME680.h>
#include <Adafruit_SSD1306.h>
#include <avr/sleep.h>

#define OLED_ADDR 0x3C // OLED display address
#define OLED_WIDTH 96 // OLED display width, in pixels
#define OLED_HEIGHT 16 // OLED display height, in pixels

#define MEASURED_COUNT 10  // The ammount of times the temp and humidity will be measured, change this value if needed

#define PASSWORD "json" // Password the master must send to the datalogger in order for it to send the data, change this value if needed
// If you change this value dont forget to also change the value in the website code

Adafruit_SSD1306 display(OLED_WIDTH, OLED_HEIGHT, &Wire, OLED_ADDR);

Adafruit_BME680 bme;

/* This enum represents all the different states the software can be in (based on state diagram) */
enum States {
  waiting,              /* In this state the AtMega will be in sleep mode waiting for an incoming UART request from the master. */
  readingSensor,        /* In this state the AtMega will send requests to the BME680 for the temp and humidity via I2C, this will be repeated 10 times. */
  calculateSensor,      /* In this state the average of the previously measured temp en humidity will be calculated. */
  calculateParameters,  /* In this state the needed extra parameters will be calculated (dewpoint, possibly more in future), also the JSON string is formed. */
  updateOLED,           /* In this state the OLED display will be updated to display the newly calculated data. */
  sendData              /* In this state the AtMega will send the data to the master via UART. */
};

/* VARIABLES */
States state = waiting; // Start off in the waiting state after setup

float array_temp[MEASURED_COUNT] = {}; // Arrays to store the temp/humidity measurments
float array_humidity[MEASURED_COUNT] = {};  // Length of these arrays is determend by the ammount of measurements the user wishes to do every request

float sum_temp = 0;  // The sum of all the temp/humidity measurments
float sum_humidity = 0;

float temp = 0;  // Final results after calculating the average
float humidity = 0;
float dew_point = 0;

String jsonData = ""; // The string formatted like a json string with the relevant data to send to the master

volatile bool asleep = false;  // Variable where the standby state is saved (true = in standby, false = not in standby)

void setup() {
  Serial.begin(9600); // Init Serial

  display.begin(SSD1306_SWITCHCAPVCC);  // Init OLED
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0, 0);
  display.setTextSize(1);
  display.clearDisplay();
  display.print("Setup...");
  display.display();

  if(!bme.begin()) { // Check if BME680 is working, if not print error on OLED
    display.clearDisplay();
    display.println("BME680 cannot start.");
    display.println("Press restart.");
    display.display();
    while (1);
  }

  // Turn off everything in BME680 to save power
  bme.setTemperatureOversampling(BME680_OS_NONE);
  bme.setHumidityOversampling(BME680_OS_NONE);
  bme.setPressureOversampling(BME680_OS_NONE);
  bme.setGasHeater(0, 0);
  bme.setIIRFilterSize(BME680_FILTER_SIZE_0);
  bme.setODR(BME68X_ODR_NONE);

  display.clearDisplay();
  display.print("Setup complete."); // Display current state to keep user up to date with what is happening
  display.display();
  delay(250);
}

void loop() {
  switch(state) {
    case waiting:
      f_waiting();
      break;

    case readingSensor:
      f_readingSensor();
      break;

    case calculateSensor:
      f_calculateSensor();
      break;

    case calculateParameters:
      f_calculateParameters();
      break;

    case updateOLED:
      f_updateOLED();
      break;

    case sendData:
      f_sendData();
      break;
  }
}

void f_waiting() {
  display.clearDisplay();
  display.print("Waiting for request..."); // Display current state to keep user up to date with what is happening
  display.display();

  if(Serial.available()) {
    String message = Serial.readString();
    if(message == PASSWORD) {
      state = readingSensor;
    }
    else {
      display.clearDisplay();
      display.print("Access denied");
      display.display();
      delay(1500);
    }
  }
}

void f_readingSensor() {
  display.clearDisplay();
  display.print("Reading..."); // Display current state to keep user up to date with what is happening
  display.display();

  bme.setTemperatureOversampling(BME680_OS_16X);  // Turn on necessary components for reading
  bme.setHumidityOversampling(BME680_OS_16X);
  bme.setODR(BME68X_ODR_1000_MS);

  for(int i = 0; i < MEASURED_COUNT; i++) {
    if (!bme.performReading()) {  // If the reading failed, repeat it
      i--;
    }
    else if(i > -1) {  // If the reading worked, store it in the corresponding array
      array_temp[i] = bme.temperature;
      array_humidity[i] = bme.humidity;
    }
  }

  bme.setTemperatureOversampling(BME680_OS_NONE); // Turn them back off to save power
  bme.setHumidityOversampling(BME680_OS_NONE);
  bme.setODR(BME68X_ODR_NONE);

  state = calculateSensor;
}

void f_calculateSensor() {
  display.clearDisplay();
  display.print("Calculating..."); // Display current state to keep user up to date with what is happening
  display.display();

  for(int i = 0; i < MEASURED_COUNT; i++) { // Calculate sum of every temp/humidity measurement
    sum_temp += array_temp[i];
    sum_humidity += array_humidity[i];
  }

  temp = sum_temp/MEASURED_COUNT; // Divide the sum by the ammount of measurements to get the average
  humidity = sum_humidity/MEASURED_COUNT;

  sum_temp = 0; // Reset variables
  sum_humidity = 0;

  state = calculateParameters;
}

void f_calculateParameters() {
  dew_point = temp-((100-humidity)/5);  // Calclate dew point
  jsonData = "{\"temp\": "+String(temp)+",\"temp_kast\": "+String(temp)+",\"humidity\": "+String(humidity)+",\"dew_point\": "+String(dew_point)+"}";  // Create JSON string

  state = updateOLED;
}

void f_updateOLED() {
  display.clearDisplay();
  display.print("Temperature: "); display.print(bme.temperature); display.println("°C");  // "Temperature: X°C"
  display.print("Humidity: "); display.print(bme.humidity); display.println("%");  // "Humidity: X%""
  display.display();

  state = sendData;
}

void f_sendData() {
  Serial.println(jsonData); // Send data to master

  delay(5000);  // Wait 5 seconds to prevent spamming
  state = waiting;
}