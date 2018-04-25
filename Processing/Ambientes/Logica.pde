public class Logica {
  boolean hiloIniciado;
  public int estadoPantalla;
  boolean showInfo;
  int[] puntos;
  int contadorAciertos;
  boolean plataforma;
  boolean mostrarMensajeIntroduccion;
 // boolean showPuntaje;
  short puntajeActual;
  boolean interEtapa;
  
  //variables para registro
  String fechaInicio;
  String fechaFinalizacion;
  String puntosYfechaAcierto[][];
  // variable de conteo de aciertos, reinicia con cada juego
  short numeroAcierto;
  
  byte countOffsetPlataforma;
  Thread offsetPlataformaHilo;
  //-------------------------------
  
  //sonidos - voces
  AudioPlayer sounds[];
  
  
  //Imagenes
  PImage introduccionPantalla;
  PImage introduccionInfoPantalla;
  PImage primeraEtapa;
  PImage primetaEtapaTwo;
  PImage segundaEtapa;
  PImage terceraEtapa;
  PImage cuartaEtapa;
  PImage cuartaEtapaTwo;
  PImage pantallaPuntaje;
  AnimationArray pararseAnimation;
  AnimationArray pararseAnimationTwo;
  
  
  
  public Logica(AudioPlayer sonidos[]){
    puntos = new int[4]; 
    puntosYfechaAcierto = new String[8][2];
    
    //sonidos
    sounds = sonidos;
    
    //animaciones imageArray
    pararseAnimation = new AnimationArray ("Arrow");
    pararseAnimationTwo = new AnimationArray ("ArrowTwo");
    
    //Imagenes
    introduccionPantalla = loadImage("Images/01.png");
    introduccionInfoPantalla = loadImage("Images/02.png");
    primeraEtapa = loadImage("Images/03.png");
    primetaEtapaTwo = loadImage("Images/04.png");
    segundaEtapa = loadImage("Images/05.png");
    terceraEtapa = loadImage("Images/06.png");
    cuartaEtapa = loadImage ("Images/07.png");
    cuartaEtapaTwo = loadImage ("Images/08.png");
    
    pantallaPuntaje =  loadImage("Images/09.png");
    
    offsetPlataformaHilo = new Thread (offsetPlataforma());
    
  }
  
  public void startSound(final int numero) {
    if(estadoPantalla == 3 && numero != 6) {
      sounds[numero].play();
      new Thread(new Runnable () {
      public void run() {
        while(sounds[numero].isPlaying()){
          try {
          Thread.sleep(100);
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
        sounds[numero+1].play();
      }
      }).start();

    } else {
    sounds[numero].play();
    }
  }
  
    
  public void stopSound(int numero) {
    sounds[numero].rewind();
    sounds[numero].pause();
  }
  
  
  
  public void display() {
  fill(100,20,20);
  switch(estadoPantalla) {
    case 0:
     pantallaIntroductora();
    break;
    case 1:
    primeraPantalla();
    if(!plataforma && !showInfo && !hiloIniciado) {
          pararsePantalla();
    }
    break;
    case 2:
    segundaPantalla();
     if(!plataforma && !showInfo && !hiloIniciado) {
          pararsePantalla();
    }
    break;
    case 3:
    terceraPantalla();
     if(!plataforma && !showInfo && !hiloIniciado) {
          pararsePantalla();
    }
    break;
    case 4:
     cuartaPantalla();
     if(!plataforma && !showInfo && !hiloIniciado) {
          pararsePantalla();
    }
    break;
    case 5:
    pantallaPuntaje();
    break;
  }
  
  }
  
  private void pararsePantalla() {
    fill(49,155,213);
    noStroke();
    rect(width/2,  height/2, width, height);
    fill(255);
    textSize (90);
    text("Sitúate en la plataforma", (width/20) * 10,  (height/20) * 8);
    pararseAnimation.display(((width/20) * 10), ((height/20) * 13));
  }
  
  private void pantallaIntroductora() {
    if(!mostrarMensajeIntroduccion) {
      image(introduccionPantalla, width/2, height/2);
      pararseAnimationTwo.display(((width/40) * 19), ((height/40) * 24));
  //    fill(255);
  //    textSize (24);
  //    text("¡Puedes salir de la plataforma para recoger las esferas!", (width/20) * 10,  (height/20) * 17);

  //  text("Pantalla Introduccion", width/2,  height/2);

    } else {
  //  fill(255);
  //  textSize (18);
  //  text("Smurfit Kappa es una de las empresas líderes a nivel mundial en la fabricación de empaques\na base de papel y cartón. Ya que ofrece soluciones de empaques 100% reciclables\npara la promoción y protección de productos y además genera papel\na partir de fibras vírgenes y recicladas. El proceso de reciclaje consiste en las\nsiguientes etapas, juega, acierta y conoce el proceso de reciclaje de Smurfit Kappa.", (width/15)*7.3,  (height/15) * 5);
     image(introduccionInfoPantalla, width/2, height/2);
    }
  }
  
  private void primeraPantalla() {
      fill(255);
      image(primeraEtapa, width/2, height/2);
    if(!showInfo) {
      if(puntajeActual != 0) {
        textSize(120);
        text("+"+puntajeActual , (width/30) * 7, (height/30) * 26);
      }

    } else {
    textSize(52);
 //   text("El proceso de reciclaje empieza con la recogida de\nempaques post consumo, principalmente del comercio minorista.", (width/15)*7.3,  (height/15) * 4);
 //   text("Todo empaque fabricado con papel es 100% reciclable, lo cual significa que ni\nuna de las cajas de ese material necesita acabar en un relleno sanitario.", (width/15)*7.3,  (height/15) * 6);
    if (interEtapa) {
     image(primetaEtapaTwo, width/2, height/2);
     text("Sigue lanzando\nen la siguiente\netapa", (width/30)*9,  (height/30) * 24.5);
    } else {
     text("Sigue lanzando\nen la siguiente\netapa", (width/30)*7.5,  (height/30) * 24.5);
    }


    }
  
    
  }
  
    private void segundaPantalla() {
      
    fill(255);
  //  textSize(24);
  //  text("segunda etapa", (width/15) * 3, (height/15) * 2);
    image(segundaEtapa, width/2, height/2);
    if(!showInfo) {
        if(puntajeActual != 0) {
        textSize(150);
        text("+"+puntajeActual , (width/30) * 8, (height/30) * 26);
      }
      
    } else {
    textSize(52);
//  text("Luego de haber recolectado los empaques se procede a\nlimpiarlos para poder ser reprocesados.", (width/15)*7.3,  (height/15) * 4);
//  text("A través de los proveedores de material reciclable tenemos presencia\nen 60 municipios de Colombia en la industria.", (width/15)*7.3,  (height/15) * 6);
    text("Sigue lanzando\nen la siguiente\netapa", (width/30)*8,  (height/30) * 24.5);
      
    }
  }
  
    private void terceraPantalla() {
    fill(255);
   // textSize(24);
   // text("tercera etapa", (width/15) * 3, (height/15) * 2);
    image(terceraEtapa, width/2, height/2);
    if(!showInfo) {
        if(puntajeActual != 0) {
        textSize(150);
        text("+"+puntajeActual , (width/30) * 7.5, (height/30) * 26);
      }

    } else {
    textSize(52);
 // text("Después de haber limpiado el material, se realiza un proceso para obtener\nlas fibras recicladas que luego serán un nuevo producto Smurfit Kappa.", (width/15)*7.3,  (height/15) * 4);
 // text("A nivel mundial Smurfit Kappa recicla más de 5 millones de toneladas cada año", (width/15)*7.3,  (height/15) * 6);
    text("Sigue lanzando\nen la siguiente\netapa", (width/30)*8,  (height/30) * 24.5);
    }
  }
  
  private void cuartaPantalla() {
        fill(255);
   // textSize(24);
   // text("tercera etapa", (width/15) * 3, (height/15) * 2);
    image(cuartaEtapa, width/2, height/2);
    if(!showInfo) {
        if(puntajeActual != 0) {
        textSize(150);
        text("+"+puntajeActual , (width/30) * 20, (height/30) * 27);
      }

    } else {
    textSize(52);
 // text("Después de haber limpiado el material, se realiza un proceso para obtener\nlas fibras recicladas que luego serán un nuevo producto Smurfit Kappa.", (width/15)*7.3,  (height/15) * 4);
 // text("A nivel mundial Smurfit Kappa recicla más de 5 millones de toneladas cada año", (width/15)*7.3,  (height/15) * 6);
 // text("Sigue lanzando\nen la siguiente\netapa", (width/30)*8,  (height/30) * 24.5);
     if(interEtapa) {
        image(cuartaEtapaTwo,  width/2, height/2);
     }
    }
  }
  
    private void pantallaPuntaje() {
    if(!showInfo) {
    image(pantallaPuntaje, width/2, height/2);
    fill(255);
    textSize(80);
 // text("puntaje", (width/15) * 3, (height/15) * 2);
    text((puntos[0] + puntos[1] + puntos[2]), (width/15) * 7, (height/15) * 7.5);
        textSize(54);
    text("1 etapa: " + puntos[0], (width/15) * 7, (height/15) * 8.4);
    text("2 etapa: " + puntos[1], (width/15) * 7, (height/15) * 9.4);
    text("3 etapa: " + puntos[2], (width/15) * 7, (height/15) * 10.4);
    text("4 etapa: " + puntos[3], (width/15) * 7, (height/15) * 11.4);
    }
  }
  
  public void interrupcionEvento(int puntosDesdePin) {
    if(estadoPantalla == 1 || estadoPantalla == 2 || estadoPantalla == 3 || estadoPantalla == 4) {
        if(!hiloIniciado && !showInfo && plataforma) {
          stopSound(6);
          startSound(6);
          new Thread(contar(puntosDesdePin)).start(); 
        }  
    }

  }
  
public Runnable contar(final int puntosAsumar) {
 Runnable r = new Runnable() {
  public void run() {
    hiloIniciado = true;
    contadorAciertos++;
    println("deshabilitado");
    println("Puntos: " + puntosAsumar);
    puntajeActual = (short)puntosAsumar;
    puntosYfechaAcierto[numeroAcierto][0] = String.valueOf(puntajeActual);
    puntosYfechaAcierto[numeroAcierto][1] = java.time.LocalDateTime.now().toString();
    numeroAcierto++;
    switch(estadoPantalla){
      case 1:
       puntos[0]+=puntosAsumar;
      break;
      case 2:
       puntos[1]+=puntosAsumar;
      break;
      case 3:
       puntos[2]+=puntosAsumar;
      break;
      case 4:
       puntos[3]+=puntosAsumar;
      break;
    }

    try {
    Thread.sleep(1000);
    if(contadorAciertos>=2){
      switch (estadoPantalla) {
        case 1:
          cambiarEstadoTest(1, sounds[1].length());
          startSound(1);
        break;
        
        case 2:
          cambiarEstadoTest(1, sounds[2].length());
          startSound(2);
        break;
        
        case 3:
          cambiarEstadoTest(1, sounds[3].length() + sounds[4].length() + 2000);
          startSound(3);
        break;
        case 4:
          cambiarEstadoTest(1, sounds[5].length());
          startSound(5);
        break;
      }

      contadorAciertos=0;
    }
    hiloIniciado = false;

    println("Habilitado");
       puntajeActual = 0;
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
};
return r;
}

public Runnable conteoParaIniciar () {

  Runnable r = new Runnable() {
    int contador = 0;
    public void run(){
         startSound(0);
      hiloIniciado = true;
      mostrarMensajeIntroduccion = true;
      while (plataforma && estadoPantalla == 0) {
          if (contador == (int)(((sounds[0].length() / 1000)+2) * 2)  ){
                  estadoPantalla += 1;
                  fechaInicio = java.time.LocalDateTime.now().toString();
          }
        
        try {
          Thread.sleep(500);
          contador++;
        } catch (Exception e) {
          
          
        }
      }
      hiloIniciado = false;
      mostrarMensajeIntroduccion = false;
      stopSound(0);
    }
    
  };
  return r;
}

public Runnable conteoParaReiniciar () {
  //startSound(5);
  Runnable r = new Runnable() {

    public void run(){
      hiloIniciado = true; 
        try {
          Thread.sleep(5000);
          estadoPantalla = 0;
          numeroAcierto = 0;

          
          java.time.LocalDateTime ldt = java.time.LocalDateTime.now(); 
          String iso8601 = ldt.toString();
          fechaFinalizacion = iso8601;
          iso8601 = iso8601.replace(".","_");
          iso8601 = iso8601.replace(":","_");
          String ubicacion = "data/"+ iso8601 +".json";
          
          JSONObject json = new JSONObject();
          json.setString("FechaInicio", fechaInicio);
          Thread.sleep(100);
          json.setString("FechaFinalizacion", fechaFinalizacion);
          Thread.sleep(200);
          json.setInt("PuntajePrimerAcierto", Integer.parseInt(puntosYfechaAcierto[0][0]));
          Thread.sleep(100);
          json.setString("FechaPrimerAcierto", puntosYfechaAcierto[0][1]);
          Thread.sleep(200);
          json.setInt("PuntajeSegundoAcierto", Integer.parseInt(puntosYfechaAcierto[1][0]));
          Thread.sleep(100);
          json.setString("FechaSegundoAcierto", puntosYfechaAcierto[1][1]);
          Thread.sleep(200);
          json.setInt("PuntajeTercerAcierto", Integer.parseInt(puntosYfechaAcierto[2][0]));
          json.setString("FechaTercerAcierto", puntosYfechaAcierto[2][1]);
          Thread.sleep(200);
          json.setInt("PuntajeCuartoAcierto", Integer.parseInt(puntosYfechaAcierto[3][0]));
          json.setString("FechaCuartoAcierto", puntosYfechaAcierto[3][1]);
          Thread.sleep(200);
          json.setInt("PuntajeQuintoAcierto", Integer.parseInt(puntosYfechaAcierto[4][0]));
          json.setString("FechaQuintoAcierto", puntosYfechaAcierto[4][1]);
          Thread.sleep(200);
          json.setInt("PuntajeSextoAcierto", Integer.parseInt(puntosYfechaAcierto[5][0]));
          json.setString("FechaSextoAcierto", puntosYfechaAcierto[5][1]);
          Thread.sleep(200);
          json.setInt("PuntajeSeptimoAcierto", Integer.parseInt(puntosYfechaAcierto[6][0]));
          json.setString("FechaSeptimoAcierto", puntosYfechaAcierto[7][1]);
          Thread.sleep(200);
          json.setInt("PuntajePrimeraEtapa", puntos[0]);
          json.setInt("PuntajeSegundaEtapa", puntos[1]);
          json.setInt("PuntajeTerceraEtapa", puntos[2]);
          json.setInt("PuntajeTotal", (puntos[0] + puntos[1] + puntos[2]));

           
         saveJSONObject(json, ubicacion);
          
          for (int i = 0; i < sounds.length; i++){
            stopSound(i);
          }
          for ( int i = 0; i < puntos.length; i++) {
            puntos[i] = 0; 
          }
          

        } catch (Exception e) {
          
        }
      hiloIniciado = false;
    }
  };
  return r;
}

public void cambiarEstadoTest(final int numero, final int timeSleep) {
  if(!showInfo) {
  new Thread(new Runnable(){
    public void run() {
      showInfo = true;
      println("Informacion");
       if(estadoPantalla == 1) {
        conteoInterEtapa(8000);
      } else if(estadoPantalla == 4) {
        conteoInterEtapa(20000);
      }
      try {
      Thread.sleep(timeSleep);
      showInfo = false;
       interEtapa = false;
      estadoPantalla += numero;

      if(estadoPantalla == 5) {
        new Thread(conteoParaReiniciar()).start();
      }
      println("Informacion end");
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }).start();
  }
}

public void conteoInterEtapa (final int time) {
  new Thread(new Runnable() {
  public void run(){
    
    try {
      Thread.sleep(time);
       interEtapa = true;
    } catch (Exception e){
      e.printStackTrace();
    }
  }
  }).start();
  
  
}

public void plataformaIn () {
  plataforma = true;
    if(offsetPlataformaHilo.isAlive()) {
  offsetPlataformaHilo.interrupt();
  } else {
      new Thread(conteoParaIniciar()).start();
  }




}

public void plataformaOut () {
   
   if(!offsetPlataformaHilo.isAlive()) {
   offsetPlataformaHilo = new Thread (offsetPlataforma());
   offsetPlataformaHilo.start();
   }
   
}

private Runnable offsetPlataforma() {
  return new Runnable(){
      public void run(){
        countOffsetPlataforma = 0;
        boolean interrumpido = false; 
        while(countOffsetPlataforma < 10) {
          countOffsetPlataforma++;
          try {
          Thread.sleep(100);
          } catch(Exception e) {
            println(e);
            interrumpido = true;
          }
        }
          if(!interrumpido) {
          plataforma = false;
          }
      }
    };
}

  
  
  
}