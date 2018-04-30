import processing.sound.*;

import processing.serial.*;



//import processing.io.*;


Logica log;

Serial myPort; 
String val;    






void setup() {
//  GPIO.pinMode(17, GPIO.INPUT);
//  GPIO.attachInterrupt(17, this, "pinEvent", GPIO.RISING);



   try {
      // myPort = new Serial(this, "/dev/ttyAMA0", 9600);
      myPort = new Serial(this, "/dev/ttyACM0", 9600);
  } catch(Exception e) {
    println(e);
              try {
                String portName = Serial.list()[1];
                myPort = new Serial(this, portName, 9600);
              } catch(Exception x) {
                  println(x);
                  try {
                   String portName = Serial.list()[0];
                   myPort = new Serial(this, portName, 9600);
                  } catch (Exception t){
                    println(t);
                  }

              }
  }


 // size(1280, 720);
  fullScreen(P2D);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
    



  


  log = new Logica(this);


}

void draw() {
  background(150);
  log.display();
}




void serialEvent(Serial p) {
      if ( p.available() > 0) { 
      val = p.readStringUntil('.');  
      if(val != null) {
      println(val);
        switch(val){
          case "obstaculoOne.":

          log.interrupcionEvento(20);
          break;
          
          case "obstaculoTwo.":
          
          log.interrupcionEvento(40);
          
          break;
          
          case "obstaculoThree.":
          
          log.interrupcionEvento(50);
          
          break;
          
          case "obstaculoFour.":
          
          log.interrupcionEvento(30);
          
          break;
          
          case "obstaculoFive.":
          
          log.interrupcionEvento(10);
          
          break;
          
          case "plataformaIn.":
             if(log.estadoPantalla == 0 && !log.hiloIniciado ) {
                 log.plataformaIn();

            } else {
             log.plataformaIn();
            }
          break;
          
          case "plataformaOut.":
                     log.plataformaOut();
          
          break;
        }
        
      }
    } 
}
 
/*
// this function will be called whenever GPIO is brought from LOW to HIGH
void pinEvent(int pin) {
  println("Received interrupt, pin: " + pin);
  switch(pin){
    case 17:
      log.interrupcionEvento(40);
    break;
  }

}
*/
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      log.interrupcionEvento(10);
    } else if (keyCode == RIGHT){
      log.interrupcionEvento(20);
    } else if (keyCode == DOWN) {
      log.interrupcionEvento(30);
    } else if (keyCode == LEFT) {
      log.interrupcionEvento(40);
    }
    
    if (keyCode == SHIFT) {
      if(log.estadoPantalla == 0 && !log.hiloIniciado) {
                  println("iniciado");
          log.plataformaIn();
          new Thread(log.conteoParaIniciar()).start();

      } else {
          log.plataformaIn();
      }

    }
}
}

void keyReleased() {
    if (key == CODED) {
          if (keyCode == SHIFT) {
          log.plataformaOut();
          }
    }
  
}
