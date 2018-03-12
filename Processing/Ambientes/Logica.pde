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
  
  
  
  public Logica(){
    puntos = new int[4];
    
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
      cambiarEstadoTest(1);
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
      hiloIniciado = true;
      mostrarMensajeIntroduccion = true;
      while (plataforma) {
          if (contador == 10){
                  estadoPantalla += 1;
          }
        
        try {
          Thread.sleep(500);
          contador++;
        } catch (Exception e) {
          
        }
      }
      hiloIniciado = false;
      mostrarMensajeIntroduccion = false;
    }
    
  };
  return r;
}

public Runnable conteoParaReiniciar () {

  Runnable r = new Runnable() {

    public void run(){
      hiloIniciado = true; 
        try {
          Thread.sleep(5000);
          estadoPantalla = 0;
        } catch (Exception e) {
          
        }
      hiloIniciado = false;
    }
  };
  return r;
}

public void cambiarEstadoTest(final int numero) {
  if(!showInfo) {
  new Thread(new Runnable(){
    public void run() {
      showInfo = true;
      println("Informacion");
      try {
      Thread.sleep(4000);
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