String jsonData = "{\"temp\": 28,\"humidity\": 75}";

void setup() {
  Serial.begin(9600); // initialize serial communication
  pinMode(A0, OUTPUT);
  digitalWrite(A0, LOW);
}

void loop() {
  if (Serial.available()) {
    String message = Serial.readString();

    if (message == "A0") {
      digitalWrite(A0, HIGH);
    }

    else if (message == "json") {
      Serial.println(jsonData);
    }

    else {
      digitalWrite(A0, LOW);      
    }
  }
}