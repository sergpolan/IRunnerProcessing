import processing.video.*;

Capture cam;
boolean firstTime = true;
int savedTim;
int totalTim = 4000;
PImage mascara;

void DoSetupCamera() {

  mascara = loadImage("img/mascara.png");
  String[] cameras = Capture.list();
 
  if (cameras.length == 0) {
    println("No hay camaras disponibles.");
    exit();
  }
    cam = new Capture(this, cameras[0]);
    cam.start();   
    savedTim = millis();        
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


