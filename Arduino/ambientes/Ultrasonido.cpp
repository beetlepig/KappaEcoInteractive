#include "Arduino.h"
#include "Ultrasonido.h"


NewPing *Ultrasonido::sonar;
unsigned long Ultrasonido::pingTimer[ITERATIONS];
uint8_t Ultrasonido::currentIteration;
unsigned int Ultrasonido::cm[ITERATIONS];

Ultrasonido::Ultrasonido()
{
   sonar = new NewPing(PING_PIN, PING_PIN, MAX_DISTANCE);
   pingTimer[0] = millis() + 75; 
   for (uint8_t i = 1; i < ITERATIONS; i++) {
     pingTimer[i] = pingTimer[i - 1] + PING_INTERVAL;
   }
}

void Ultrasonido::draw()
{
  for (uint8_t i = 0; i < ITERATIONS; i++) { // Loop through all the iterations.
    if (millis() >= pingTimer[i]) {          // Is it this iteration's time to ping?
      pingTimer[i] += PING_INTERVAL * ITERATIONS; // Set next time this sensor will be pinged.
        if (i == 0 && currentIteration == ITERATIONS - 1){ 
          oneSensorCycle(); 
        } // Sensor ping cycle complete, do something with the results.
      sonar->timer_stop();          // Make sure previous timer is canceled before starting a new ping (insurance).
      currentIteration = i;        // Sensor being accessed.
      cm[currentIteration] = 0;    // Make distance zero in case there's no ping echo for this iteration.
      sonar->ping_timer(echoCheck); // Do the ping (processing continues, interrupt will call echoCheck to look for echo).
    }
  }
  // Other code that *DOESN'T* analyze ping results can go here.
}

void Ultrasonido::echoCheck() { 
  if (sonar->check_timer()) {
    cm[currentIteration] = sonar->ping_result / US_ROUNDTRIP_CM;
  }
}

void Ultrasonido::oneSensorCycle() { // All iterations complete, calculate the median.
  unsigned int uS[ITERATIONS];
  uint8_t j, it = ITERATIONS;
  uS[0] = NO_ECHO;
  for (uint8_t i = 0; i < it; i++) { // Loop through iteration results.
      if (i > 0) {          // Don't start sort till second ping.
        for (j = i; j > 0 && uS[j - 1] < cm[i]; j--) // Insertion sort loop.
          uS[j] = uS[j - 1];                         // Shift ping array to correct position for sort insertion.
      } else j = 0;         // First ping is sort starting point.
      uS[j] = cm[i];        // Add last ping to array in sorted position.
  }
  mediana = uS[it >> 1];
    if((mediana > 100 && mediana < 130) && !paradoEnviado){
     paradoEnviado = true;
     Serial.print("plataformaIn.");
    } else if (mediana < 100 && paradoEnviado) {
      paradoEnviado = false;
      Serial.print("plataformaOut.");
    }
//  Serial.print(mediana);
// Serial.println(" cm");
}

