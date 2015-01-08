import processing.video.*;

Capture cam;
boolean firstTime = true;
int savedTim;
int totalTim = 4000;
PImage mascara;

void DoSetupCamera() {

  mascara = loadImage("mascara.png");
  String[] cameras = Capture.list();
 
  if (cameras.length == 0) {
    println("No hay camaras disponibles.");
    exit();
  } else {
    println("Camaras disponibles:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, cameras[0]);
    cam.start();   
    savedTim = millis();  
  }      
}

void drawCamera() {
  
  
  if(firstTime)
   {
     DoSetupCamera();
     firstTime = false;
   }
   else{
     
     int passedTim = millis() - savedTim;
     
      if (cam.available() == true) {
        cam.read();
      }
      //pruebaMask(cam);
      image(cam,0,0);
      image(mascara,0,0);
      if (passedTim < totalTim) {
        image(textCapture, 20, 330);
      }
   }
}

void pararEjecucion()
{
  cam.stop();
  background(0);
  firstTime = true;
}

void pruebaMask(PImage img)
{
  PGraphics mask;
  background(40);
  mask = createGraphics(img.width, img.height);
  mask.beginDraw();
  mask.smooth();
  mask.background(0);
  mask.fill(255);
  mask.ellipse(width/2, height/2, 250,250);
  mask.endDraw();
  img.mask(mask);
  image(img,0,0);
}

