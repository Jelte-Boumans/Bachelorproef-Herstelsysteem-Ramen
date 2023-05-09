String jsonData = "";

void setup() {
  Serial.begin(9600); // initialize serial communication
  pinMode(A0, OUTPUT);
  digitalWrite(A0, LOW);
  pinMode(A1, INPUT);
  randomSeed(analogRead(A1));

  int temp = random(12,32);
  int temp_kast = random(12,32);
  int humidity = random(70,95);
  int dew_point = temp-((100-humidity)/5);

  jsonData = "{\"temp\": "+String(temp)+",\"temp_kast\": "+String(temp_kast)+",\"humidity\": "+String(humidity)+",\"dew_point\": "+String(dew_point)+"}";
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