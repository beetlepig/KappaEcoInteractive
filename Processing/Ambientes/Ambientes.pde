import ddf.minim.*;

import processing.serial.*;



//import processing.io.*;


Logica log;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
Minim minim;
AudioPlayer sounds[];

void setup() {
//  GPIO.pinMode(17, GPIO.INPUT);
//  GPIO.attachInterrupt(17, this, "pinEvent", GPIO.RISING);


   try {
      myPort = new Serial(this, "/dev/ttyAMA0", 9600);
  } catch(Exception e) {
    println(e);
              try {
                String portName = Serial.list()[0];
                myPort = new Serial(this, portName, 9600);
              } catch(Exception x) {
                  println(x);
                  try {
                   String portName = Serial.list()[1];
                   myPort = new Serial(this, portName, 9600);
                  } catch (Exception t){
                    println(t);
                  }

              }
  }


  size(900,600);
  rectMode(CENTER);
  textAlign(CENTER);
    minim = new Minim(this);
  sounds = new AudioPlayer[6];
  sounds[0] = minim.loadFile("0_Inicio.mp3");
  sounds[1] = minim.loadFile("1_Etapa.mp3");
  sounds[2] = minim.loadFile("2_Etapa.mp3");
  sounds[3] = minim.loadFile("3_Etapa_0.mp3");
  sounds[4] = minim.loadFile("3_Etapa_1.mp3");
  sounds[5] = minim.loadFile("4_Final.mp3");
  log = new Logica(sounds);
  /*¿
  for(int i = 0 ; i < 6; i++) {
    sounds[i].close();
  }
  */
  sounds = null;
}

void draw() {
  background(150);
  log.display();
  
  


}

void serialEvent(Serial p) { 
      if ( p.available() > 0) {  // If data is available,
      val = p.readStringUntil('.');  
      if(val != null) {
      println(val);
        switch(val){
          case "obstaculoOne.":

          log.interrupcionEvento(20);
          break;
          
          case "obstaculoTwo.":
          
          log.interrupcionEvento(30);
          
          break;
          
          case "obstaculoThree.":
          
          log.interrupcionEvento(40);
          
          break;
          
          case "obstaculoFour.":
          
          log.interrupcionEvento(50);
          
          break;
          
          case "obstaculoFive.":
          
          log.interrupcionEvento(60);
          
          break;
          
          case "plataformaIn.":
             if(log.estadoPantalla == 0 && !log.hiloIniciado) {
                  println("iniciado");
                 log.plataformaIn();
                 new Thread(log.conteoParaIniciar()).start();
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
      log.interrupcionEvento(20);
    } else if (keyCode == RIGHT){
      log.interrupcionEvento(40);
    } else if (keyCode == DOWN) {
      log.interrupcionEvento(60);
    } else if (keyCode == LEFT) {
      log.interrupcionEvento(80);
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