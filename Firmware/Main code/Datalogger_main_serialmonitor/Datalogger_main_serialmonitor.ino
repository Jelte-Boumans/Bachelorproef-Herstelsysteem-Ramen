/*
  This is the firmware for the datalogger needed in the new window replacement system for the MR08 trains.
  This is a test version of the main firmware not meant to be used with the website.
  In this version the functions of the website and OLED are simulated with the Serial monitor.

  IMPORTANT:
    - Select Board: "Arduino Nano" and Processor: "ATmega328p (old bootloader)".
    - If you're going to use the Serial monitor to send the password, make sure the Serial monitor is set to "No Line Ending".

  Written by: Jelte Boumans 3ITIOT
  Bachelorproef AP Hogeschool
*/

#include <Adafruit_BME680.h>
#include <avr/sleep.h>

#define MEASURED_COUNT 10  // The ammount of times the temp and humidity will be measured, change this value if needed

#define PASSWORD "json"  // Password the master must send to the datalogger in order for it to send the data, change this value if needed
// If you change this value dont forget to also change the value in the website code

Adafruit_BME680 bme;

/* This enum represents all the different states the software can be in (based on state diagram) */
enum States {
  waiting,             /* In this state the AtMega will be in sleep mode waiting for an incoming UART request from the master. */
  readingSensor,       /* In this state the AtMega will send requests to the BME680 for the temp and humidity via I2C, this will be repeated 10 times. */
  calculateSensor,     /* In this state the average of the previously measured temp en humidity will be calculated. */
  calculateParameters, /* In this state the needed extra parameters will be calculated (dewpoint, possibly more in future), also the JSON string is formed. */
  sendData             /* In this state the AtMega will send the data to the master via UART. */
};

/* VARIABLES */
States state = waiting;  // Start off in the waiting state after setup

float array_temp[MEASURED_COUNT] = {};      // Arrays to store the temp/humidity measurments
float array_humidity[MEASURED_COUNT] = {};  // Length of these arrays is determend by the ammount of measurements the user wishes to do every request

float sum_temp = 0;  // The sum of all the temp/humidity measurments
float sum_humidity = 0;

float temp = 0;  // Final results after calculating the average
float humidity = 0;
float dew_point = 0;

String jsonData = "";  // The string formatted like a json string with the relevant data to send to the master

volatile bool asleep = false;  // Variable where the standby state is saved (true = in standby, false = not in standby)

void setup() {
  Serial.begin(9600);  // Init Serial

  set_sleep_mode(SLEEP_MODE_STANDBY);  // Select standy mode
  sleep_enable();

  // Enable Pin Change Interrupt on RX pin, so when an incoming request is detected the AtMega will wake up
  PCICR |= (1 << PCIE2);     // Enable pin change mask 2
  PCMSK2 |= (1 << PCINT16);  // Enable pin change interrupt on PCINT16

  if (!bme.begin()) {  // Check if BME680 is working, if not print error on OLED
    Serial.println("BME680 cannot start.");
    Serial.println("Press restart.");
    while (1);
  }

  // Set up oversampling and init filter
  bme.setTemperatureOversampling(BME680_OS_8X);
  bme.setHumidityOversampling(BME680_OS_2X);
  bme.setIIRFilterSize(BME680_FILTER_SIZE_3);

  Serial.println("Setup complete.");  // Display current state to keep user up to date with what is happening
  delay(250);
}

void loop() {
  switch (state) {
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

    case sendData:
      f_sendData();
      break;
  }
}

void f_waiting() {
  Serial.println("Waiting for request...");  // Display current state to keep user up to date with what is happening
  delay(100);  // Wait untill data is printed before going into sleep mode

  PCMSK2 |= (1 << PCINT16);  // Enable pin change interrupt on PCINT16

  asleep = true;
  while (asleep) {  // While no interrupt has been called, stay in standby mode
    sleep_cpu();
  }
  delay(1);  // Wait until all data is recieved on RX

  if (Serial.available()) {
    String message = Serial.readString();
    if (message == PASSWORD) {
      state = readingSensor;
    } else {
      Serial.println("Access denied");
      delay(1500);
    }
  }
}

void f_readingSensor() {
  Serial.println("Reading...");  // Display current state to keep user up to date with what is happening

  for (int i = 0; i < MEASURED_COUNT; i++) {
    if (!bme.performReading()) {  // If the reading failed, repeat it
      i--;
    } 
    else if (i > -1) {  // If the reading worked, store it in the corresponding array
      array_temp[i] = bme.temperature;
      array_humidity[i] = bme.humidity;
    }
  }

  state = calculateSensor;
}

void f_calculateSensor() {
  Serial.println("Calculating...");  // Display current state to keep user up to date with what is happening

  for (int i = 0; i < MEASURED_COUNT; i++) {  // Calculate sum of every temp/humidity measurement
    sum_temp += array_temp[i];
    sum_humidity += array_humidity[i];
  }

  temp = sum_temp / MEASURED_COUNT;  // Divide the sum by the ammount of measurements to get the average
  humidity = sum_humidity / MEASURED_COUNT;

  sum_temp = 0;  // Reset variables
  sum_humidity = 0;

  state = calculateParameters;
}

void f_calculateParameters() {
  dew_point = temp - ((100 - humidity) / 5);  // Calclate dew point
  jsonData = "{\"temp\": " + String(temp) + ",\"temp_kast\": " + String(temp) + ",\"humidity\": " + String(humidity) + ",\"dew_point\": " + String(dew_point) + "}";  // Create JSON string

  state = sendData;
}

void f_sendData() {
  Serial.println(jsonData);  // Send data to master
  Serial.print("\n");

  delay(5000);  // Wait 5 seconds to prevent spamming
  state = waiting;
}

ISR(PCINT2_vect) {
  asleep = false;
  PCMSK2 &= ~(1 << PCINT16);  // Disable pin change interrupt on PCINT16
}