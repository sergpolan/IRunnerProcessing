import processing.video.*;

Capture cam;
boolean firstTime = true;

void DoSetupCamera() {

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
  }      
}

void drawCamera() {
  if(firstTime)
   {
     DoSetupCamera();
     firstTime = false;
   }
   else{
      if (cam.available() == true) {
        cam.read();
      }
      image(cam, 0, 0);
   }
}

