#define PIN 22

void setup() {
  Serial.begin(9600);
  pinMode(PIN, OUTPUT);
}

void loop() {
  Serial.println("Hello world");

  digitalWrite(PIN, HIGH);
  delay(500);
  digitalWrite(PIN, HIGH);
  delay(500);
}
