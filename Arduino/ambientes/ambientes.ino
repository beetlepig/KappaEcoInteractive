int led_IROne = 8;
int led_IRTwo = 9;
int led_IRThree = 10;
int receptorOne = A0; 
int receptorTwo = A1; 
int receptorThree = A2; 
long sensorValueOne = 0; 
long sensorValueTwo = 0; 
long sensorValueThree = 0; 

unsigned long previousMillis = 0;        // will store last time LED was updated

// constants won't change:
const long interval = 20;           // interval at which to blink (milliseconds)

unsigned long currentMillis;

void setup() {
  pinMode(led_IROne, OUTPUT); 
  pinMode(led_IRTwo, OUTPUT); 
  pinMode(led_IRThree, OUTPUT); 
  pinMode(receptorOne, INPUT); 
  pinMode(receptorTwo, INPUT);
  pinMode(receptorThree, INPUT);
  digitalWrite(led_IROne, HIGH);
  digitalWrite(led_IRTwo, HIGH);
  digitalWrite(led_IRThree, HIGH);
  Serial.begin(9600);
 
}

void loop() { 
currentMillis = millis();
sensorValueOne = analogRead(receptorOne);
sensorValueTwo = analogRead(receptorTwo);
sensorValueThree = analogRead(receptorThree);


  if (currentMillis - previousMillis >= interval) {
    // Serial.println(sensorValueTwo);
     previousMillis = currentMillis;
    if(sensorValueOne > 1000) {    
      Serial.print("obstaculoOne.");
    }
     if(sensorValueTwo > 1000) {    
      Serial.print("obstaculoTwo.");
    }
         if(sensorValueThree > 1020) {    
      Serial.print("obstaculoThree.");
    }
  }
  

  }
 

