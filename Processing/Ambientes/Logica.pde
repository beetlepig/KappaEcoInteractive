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
  
  //variables para registro
  String fechaInicio;
  String fechaFinalizacion;
  String puntosYfechaAcierto[][];
  // variable de conteo de aciertos, reinicia con cada juego
  short numeroAcierto;
  //-------------------------------
  
  AudioPlayer sounds[];

  
  
  
  public Logica(AudioPlayer sonidos[]){
    puntos = new int[4]; 
    puntosYfechaAcierto = new String[6][2];
    sounds = sonidos;
  }
  
  public void startSound(final int numero) {
    if(estadoPantalla == 3) {
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
    pantallaPuntaje();
    break;
  }
  
  }
  
  private void pararsePantalla() {
    fill(200,50,50);
    noStroke();
    rect(width/2,  height/2, width, height);
    fill(255);
    textSize (24);
    text("Parate en la plataforma CTM", width/2,  height/2);
  }
  
  private void pantallaIntroductora() {
    if(!mostrarMensajeIntroduccion) {
    fill(255);
    textSize (24);
    text("Pantalla Introduccion", width/2,  height/2);
    } else {
    fill(255);
    textSize (18);
    text("Smurfit Kappa es una de las empresas líderes a nivel mundial en la fabricación de empaques\na base de papel y cartón. Ya que ofrece soluciones de empaques 100% reciclables\npara la promoción y protección de productos y además genera papel\na partir de fibras vírgenes y recicladas. El proceso de reciclaje consiste en las\nsiguientes etapas, juega, acierta y conoce el proceso de reciclaje de Smurfit Kappa.", (width/15)*7.3,  (height/15) * 5);
    }
  }
  
  private void primeraPantalla() {
     fill(255);
    textSize(24);
    text("primera etapa", (width/15) * 3, (height/15) * 2);
    if(!showInfo) {
      if(puntajeActual != 0) {
        text("+"+puntajeActual , (width/15) * 3, (height/15) * 10);
      }

    } else {
    textSize(18);
    text("El proceso de reciclaje empieza con la recogida de\nempaques post consumo, principalmente del comercio minorista.", (width/15)*7.3,  (height/15) * 4);
    text("Todo empaque fabricado con papel es 100% reciclable, lo cual significa que ni\nuna de las cajas de ese material necesita acabar en un relleno sanitario.", (width/15)*7.3,  (height/15) * 6);
    }
  }
  
    private void segundaPantalla() {
      
    fill(255);
    textSize(24);
    text("segunda etapa", (width/15) * 3, (height/15) * 2);
    if(!showInfo) {
        if(puntajeActual != 0) {
        text("+"+puntajeActual , (width/15) * 3, (height/15) * 10);
      }
      
    } else {
    textSize(18);
    text("Luego de haber recolectado los empaques se procede a\nlimpiarlos para poder ser reprocesados.", (width/15)*7.3,  (height/15) * 4);
    text("A través de los proveedores de material reciclable tenemos presencia\nen 60 municipios de Colombia en la industria.", (width/15)*7.3,  (height/15) * 6);
      
    }
  }
  
    private void terceraPantalla() {
    fill(255);
    textSize(24);
    text("tercera etapa", (width/15) * 3, (height/15) * 2);
    if(!showInfo) {
        if(puntajeActual != 0) {
        text("+"+puntajeActual , (width/15) * 3, (height/15) * 10);
      }

    } else {
    textSize(18);
    text("Después de haber limpiado el material, se realiza un proceso para obtener\nlas fibras recicladas que luego serán un nuevo producto Smurfit Kappa.", (width/15)*7.3,  (height/15) * 4);
    text("A nivel mundial Smurfit Kappa recicla más de 5 millones de toneladas cada año", (width/15)*7.3,  (height/15) * 6);
    }
  }
  
    private void pantallaPuntaje() {
    if(!showInfo) {
    fill(255);
    textSize(24);
    text("puntaje", (width/15) * 3, (height/15) * 2);
    text("Puntaje Total: " + (puntos[0] + puntos[1] + puntos[2]), (width/15) * 6, (height/15) * 4);
    text("Puntaje primera etapa: " + puntos[0], (width/15) * 7, (height/15) * 6);
    text("Puntaje segunda etapa: " + puntos[1], (width/15) * 7, (height/15) * 7);
    text("Puntaje tercera etapa: " + puntos[2], (width/15) * 7, (height/15) * 8);
    }
  }
  
  public void interrupcionEvento(int puntosDesdePin) {
    if(estadoPantalla == 1 || estadoPantalla == 2 || estadoPantalla == 3) {
        if(!hiloIniciado && !showInfo && plataforma) {

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
    }

    try {
    Thread.sleep(2000);
    if(contadorAciertos==2){
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
  startSound(5);
  Runnable r = new Runnable() {

    public void run(){
      hiloIniciado = true; 
        try {
          Thread.sleep(sounds[5].length());
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
          json.setString("FechaFinalizacion", fechaFinalizacion);
          Thread.sleep(100);
          json.setInt("PuntajePrimerAcierto", Integer.parseInt(puntosYfechaAcierto[0][0]));
          json.setString("FechaPrimerAcierto", puntosYfechaAcierto[0][1]);
          Thread.sleep(100);
          json.setInt("PuntajeSegundoAcierto", Integer.parseInt(puntosYfechaAcierto[1][0]));
          json.setString("FechaSegundoAcierto", puntosYfechaAcierto[1][1]);
          Thread.sleep(100);
          json.setInt("PuntajeTercerAcierto", Integer.parseInt(puntosYfechaAcierto[2][0]));
          json.setString("FechaTercerAcierto", puntosYfechaAcierto[2][1]);
          Thread.sleep(100);
          json.setInt("PuntajeCuartoAcierto", Integer.parseInt(puntosYfechaAcierto[3][0]));
          json.setString("FechaCuartoAcierto", puntosYfechaAcierto[3][1]);
          Thread.sleep(100);
          json.setInt("PuntajeQuintoAcierto", Integer.parseInt(puntosYfechaAcierto[4][0]));
          json.setString("FechaQuintoAcierto", puntosYfechaAcierto[4][1]);
          Thread.sleep(100);
          json.setInt("PuntajeSextoAcierto", Integer.parseInt(puntosYfechaAcierto[5][0]));
          json.setString("FechaSextoAcierto", puntosYfechaAcierto[5][1]);
          Thread.sleep(100);
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
      try {
      Thread.sleep(timeSleep);
      showInfo = false;
      estadoPantalla += numero;
      if(estadoPantalla == 4) {
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

public void plataformaIn () {
  plataforma = true;
}

public void plataformaOut () {
  plataforma = false;
}
  
  
  
}