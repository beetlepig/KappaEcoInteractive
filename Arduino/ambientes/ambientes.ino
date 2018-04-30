#include "Ultrasonido.h"

// int led_IROne = 8;
// int led_IRTwo = 9;
// int led_IRThree = 10;

Ultrasonido sensorULTRA;

int receptorOne = A0; 
int receptorTwo = A1; 
int receptorThree = A2; 
int receptorFour = A3;
int receptorFive = A4;
int receptorPresion = A5;
long sensorValueOne = 0; 
long sensorValueTwo = 0; 
long sensorValueThree = 0; 
long sensorValueFour = 0;
long sensorValueFive = 0;
long sensorValuePresion = 0;

bool paradoEnviado;

unsigned long previousMillis = 0;       
unsigned long previousMillisTwo = 0;    

const long interval = 20;

unsigned long currentMillis;

void setup() {
//  pinMode(led_IROne, OUTPUT); 
//  pinMode(led_IRTwo, OUTPUT); 
//  pinMode(led_IRThree, OUTPUT); 
  pinMode(receptorOne, INPUT); 
  pinMode(receptorTwo, INPUT);
  pinMode(receptorThree, INPUT);
  pinMode(receptorFour, INPUT);
  pinMode(receptorFive, INPUT);
  pinMode(receptorPresion, INPUT);
//  digitalWrite(led_IROne, HIGH);
//  digitalWrite(led_IRTwo, HIGH);
//  digitalWrite(led_IRThree, HIGH);
  Serial.begin(9600);
 
}



void loop() { 
currentMillis = millis();



  if (currentMillis - previousMillis >= interval) {
    // Serial.println(sensorValueTwo);
     previousMillis = currentMillis;
     sensorValueOne = analogRead(receptorOne);
     sensorValueTwo = analogRead(receptorTwo);
     sensorValueThree = analogRead(receptorThree);
     sensorValueFour = analogRead(receptorFour);
     sensorValueFive = analogRead(receptorFive);
     sensorValuePresion = analogRead(receptorPresion);
     
     if(previousMillisTwo < 20) {
      previousMillisTwo++;
     }
   if(previousMillisTwo == 20) {
      
    if(sensorValueOne > 975) {    
      Serial.print("obstaculoOne.");
      previousMillisTwo = 0;
    }
     if(sensorValueTwo > 1000) {    
      Serial.print("obstaculoTwo.");
      previousMillisTwo = 0;
    }
         if(sensorValueThree > 975) {    
      Serial.print("obstaculoThree.");
      previousMillisTwo = 0;
    }  

    if(sensorValueFour > 1001){
     Serial.print("obstaculoFour.");
     previousMillisTwo = 0;
    }

     if(sensorValueFive > 975){
     Serial.print("obstaculoFive.");
     previousMillisTwo = 0;
    }
   }

    
     if(sensorValuePresion < 500 && !paradoEnviado){
     paradoEnviado = true;
     Serial.print("plataformaIn.");
    } else if (sensorValuePresion > 600 && paradoEnviado) {
      paradoEnviado = false;
      Serial.print("plataformaOut.");
    }

    }

    sensorULTRA.draw();
 
  }
  

  
 

