#ifndef Ultrasonido_h

#define Ultrasonido_h

#include <Arduino.h>
#include "NewPing.h"



#define PING_PIN       2 
#define MAX_DISTANCE   130
#define ITERATIONS     9 
#define PING_INTERVAL  33

class Ultrasonido
  {
      public:
        Ultrasonido();
        void draw();

      private:
        static NewPing *sonar;
        static void echoCheck();
        void oneSensorCycle();
        static unsigned long pingTimer[ITERATIONS]; 
        static unsigned int cm[ITERATIONS];       
        static uint8_t currentIteration;
        uint8_t mediana; 

        bool paradoEnviado;
        
 };

#endif
