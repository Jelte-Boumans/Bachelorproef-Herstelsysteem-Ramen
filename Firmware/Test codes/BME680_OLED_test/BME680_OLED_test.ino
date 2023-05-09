#include <Wire.h>
#include <SPI.h>
#include <Adafruit_Sensor.h>
#include "Adafruit_BME680.h"
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

Adafruit_BME680 bme; // I2C
Adafruit_SSD1306 display = Adafruit_SSD1306();

void setup() {
  Serial.begin(9600);
  Serial.println(F("BME680 test"));

  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3C (for the 128x32)

  display.display();
  delay(100);
  display.clearDisplay();
  display.display();

  display.setTextSize(1);

  if (!bme.begin()) {
    Serial.println("Could not find a valid BME680 sensor, check wiring!");
    while (1);
  }

  // Set up oversampling and filter initialization
  bme.setTemperatureOversampling(BME680_OS_8X);
  bme.setHumidityOversampling(BME680_OS_2X);
  bme.setPressureOversampling(BME680_OS_4X);
  bme.setIIRFilterSize(BME680_FILTER_SIZE_3);
  bme.setGasHeater(320, 150); // 320°C for 150 ms
}

void loop() {
  display.setCursor(0,0);
  display.clearDisplay();

  if (! bme.performReading()) {
    Serial.println("Failed to perform reading :(");
    return;
  }

  Serial.print("Temperature = "); Serial.print(bme.temperature); Serial.println(" °C");
  Serial.print("Humidity = "); Serial.print(bme.humidity); Serial.println(" %");

  display.print("Temperature: "); display.print(bme.temperature); display.println(" °C");
  display.print("Humidity: "); display.print(bme.humidity); display.println(" %");

  Serial.println();
  display.display();
  delay(2000);
}