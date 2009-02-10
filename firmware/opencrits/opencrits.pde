int statusLEDPin = 13;
long statusBlinkInterval = 250;
int lastStatusLEDValue = LOW;
long previousStatusBlinkMillis = 0;

boolean raceStarted = false;
boolean raceStarting = false;
boolean mockMode = false;
unsigned long raceStartMillis;
unsigned long currentTimeMillis;

int val = 0;

int sensorPins[8] = {2,3,4,5,6,7,8,9};
int previoussensorValues[8] = {HIGH, HIGH, HIGH, HIGH, HIGH, HIGH, HIGH, HIGH};
int values[8] = {0,0,0,0,0,0,0,0};
unsigned long racerTicks[8] = {0,0,0,0,0,0,0,0};
unsigned long racerFinishTimeMillis[8];

int updateInterval = 250;
unsigned long lastUpdateMillis = 0;

void setup() {
  Serial.begin(115200); 
  pinMode(statusLEDPin, OUTPUT);
  for(int i=0; i<=7; i++)
  {
    pinMode(sensorPins[i], INPUT);
  }
  for(int i=0; i<=7; i++)
  {
    digitalWrite(sensorPins[i], HIGH);
  }
}

void blinkLED() {
  if (millis() - previousStatusBlinkMillis > statusBlinkInterval) {
    previousStatusBlinkMillis = millis();

    if (lastStatusLEDValue == LOW)
      lastStatusLEDValue = HIGH;
    else
      lastStatusLEDValue = LOW;
  

    digitalWrite(statusLEDPin, lastStatusLEDValue);
  }

}

void raceStart() {
  raceStartMillis = millis();
}


void checkSerial(){
  if(Serial.available()) {
    val = Serial.read();
    if(val == 'g') {
      for(int i=0; i<=7; i++)
      {
        racerTicks[i] = 0;
        racerFinishTimeMillis[i] = 0;          
      }
      raceStarted = true;
    }
    if(val == 's') {
      raceStarted = false;
      mockMode = false;
    }
  }
}

void printStatusUpdate() {
  if(currentTimeMillis - lastUpdateMillis > updateInterval) {
    lastUpdateMillis = currentTimeMillis;
    for(int i=0; i<=7; i++)
    {
      Serial.print(i);
      Serial.print(": ");
      Serial.println(racerTicks[i], DEC);
    }
    Serial.print("t: ");
    Serial.println(currentTimeMillis, DEC);
  }
}

void loop() {
  blinkLED();
  
  checkSerial();

  if (raceStarted) {
    currentTimeMillis = millis() - raceStartMillis;

    for(int i=0; i<=7; i++)
    {
      values[i] = digitalRead(sensorPins[i]);
      if(values[i] == HIGH && previoussensorValues[i] == LOW){
        racerTicks[i]++;
      }
      previoussensorValues[i] = values[i];
    }
  }

  printStatusUpdate();
}
