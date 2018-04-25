public class AnimationArray {
    PImage[] imageArray;
    boolean vivo = true;
    short count;
    byte direccion = 0;
  
  public AnimationArray(String animacionName) {
  switch (animacionName) {
    case "Arrow":
    imageArray = new PImage[7];
    for (int i = 0; i < imageArray.length; i++) {
          imageArray[i] = loadImage("Images/Arrow Animation/"+ i +".png");
          imageArray[i].resize(200, 0);
    }
    break;
    
    case "ArrowTwo":
        imageArray = new PImage[9];
        for (int i = 0; i < imageArray.length; i++) {
          imageArray[i] = loadImage("Images/Arrow AnimationTwo/0"+ i +".png");
    }
    
    break;
  }
  animationTimer();
    
  
  }
  
  
  void animationTimer() {
    new Thread(new Runnable() {
      public void run(){
        while(vivo) {
          if(count > imageArray.length - 2) {
            direccion = 1;
          } else if (count < 1) {
            direccion = 0;
          }
          if (direccion == 0) {
          count++;
          } else {
          count--;
          }
         
          try {
          Thread.sleep(100);
          } catch (Exception e) {
            e.printStackTrace();
          }
        }
      }
    }).start();
    
  }


  void display(int x, int y){
    image(imageArray[count] ,x, y);
  }

}