import gifAnimation.*;
import processing.video.*;

PImage bg, ground, ground2, principal, textCapture;
PImage pjWalk;
int PointsCounter = 0,LR =0,once=1,jumpon=0,jumptime=0,onejump=0, stime=0, i=0, j=0;
float x=100, y=140, speed=0,slow = 0, jump, g=670;
int n=415, contador=0;

int savedTime, savedTimeObs, savedTimeJump;
int totalTime = 50;
int jumpTime = 2000;
int obsTime = 1000;
int esquinaPlayX, esquinaExitX, esquinaOptionsX;
int esquinaPlayY, esquinaOptionsY, anchoBotones, altoBotones;

boolean dead = false;
boolean bajando = false;
boolean keyup = false;
boolean keyright = false;
boolean keyleft = false;
boolean keydown = false;
boolean keyuplook = false;
boolean keyfast = false;
Gif walkr, background;
boolean[] suelo;

int pantalla = 0;

void setup()
{
  size(600,240);

   bg = loadImage("bg.png");
   ground = loadImage("groundL.jpg");
   ground2 = loadImage("ground2.png");
   principal = loadImage("principal.png");
   textCapture = loadImage("captura.png");
   walkr = new Gif(this, "p1.gif");
   walkr.play();
   background = new Gif(this, "background.gif");
   background.play();
   
   suelo = new boolean[44];
   initializeGround();
   background(250);
   suelo[35]= false;
    suelo[36]= false;
    suelo[37]= false;
    suelo[38]= false;
    suelo[39]= false;
    suelo[40]= false;
    suelo[41]= false;
    suelo[42]= false;
    suelo[43]= false;
    savedTime = millis();
   
   esquinaPlayX = 218;
   esquinaPlayY = 280;
   esquinaExitX = 484;
   esquinaOptionsX = 45;
   esquinaOptionsY = 280;
   
   anchoBotones = 148;
   altoBotones = 52;
}

void draw()
{
  switch(pantalla) {
  case 0: 
    pantallaPrincipal();
    break;
  case 1: 
    paintGame();
    break;
  case 2:
    drawCamera();
    break;
  }
}


void pantallaPrincipal()
{
  image(principal, 0, 0);
}

void paintGame()
{
  paint();
  
  int passedTime = millis() - savedTime;
  int passedTimeObs = millis() - savedTimeObs;
  
  if (passedTime > totalTime) {
  moveGround();
  savedTime = millis();
  }
  if(passedTimeObs > obsTime)
  {
    generarObstGround();
    savedTimeObs = millis();
  }
  drawGround();
}

void moveGround()
{
  boolean[] aux = suelo;
  for(i = 0; i < suelo.length; i++)
  {
    if(i == 42)
    {
      suelo[i] = true;
    }
    else if(i == 43)
    {
      suelo[i] = aux[0];
    }
    else{
    suelo[i] = suelo[i+1];
    }
  }
  
}

void initializeGround()
{
  for(i=0; i< suelo.length; i++)
  {
    suelo[i] = true;
  }
}

void drawGround()
{
  int con = 0;
  for(i=0;i<700;i+=16)
  {
      if(suelo[con] == true)
      {
        image(ground,i, 205);
      }
      con++;
  }
}

void perder()
{
  stop();
}

void generarObstGround()
{
  /*
  suelo[35]= false;
  suelo[36]= false;
  suelo[37]= false;
  suelo[38]= false;
  suelo[39]= false;
  suelo[40]= false;
  suelo[41]= false;
  suelo[42]= false;
  suelo[43]= false;
*/
}
 
void paint()
{
  image(background,0,0);
  int passedTimeJump = millis() - savedTimeJump;
  if(keyup == true)
  {
    if(passedTimeJump < jumpTime && !bajando)
    {
      y= y-2;
    }
    if(passedTimeJump > jumpTime)
    {
      println("EMPIEZA BAJANDO");
      bajando = true;
    }
    if(bajando)
    {
     println("ENTRO EN BAJANDO");
      y+=2;
      if(y >= 145){
        println(y);
        y = 140;
        println(y);
        keyup = false;
        bajando = false;
        savedTimeJump = millis();
      }
    } 
    image(walkr, x, y);
  }
  else if((suelo[7] == true && dead == false))
  {
    println("camina");
    image(walkr, x, y);
  }
  else
  {
    println("MUERE");
    dead = true;
    y= y+3;
    image(walkr, x, y);
    if(y > 250)
     perder(); 
    //PARAR CRONOMETRO
    //PONER PANTALLA DE PUNTUACIONES
  }
    textSize(30);
  text(contador++, width - (width/6), height/8);
  color(255,255,0);
}
 
 
 void keyPressed() {
   if (key == 'a') keyup = true; 
   if (key == 's') keyfast = true; 
   if(key == 'g') 
   {
     if(pantalla == 2)
       saveFrame("captura-1.png");
   }
  if (key == CODED) {
    if (keyCode == UP) keyup = true; 
    if (keyCode == DOWN) keydown = true;

  }
 }
  
  void mouseClicked() {
  if(pantalla == 0)
  {
    println(mouseX, mouseY);
    if(contiene(mouseX, mouseY, "play"))
    {
      println("Entramos en play");
      pantalla = 1;
      changeWindow("normal");
    }
    if(contiene(mouseX, mouseY, "options")){
      println("Entramos en options");
      pantalla = 2;
      changeWindow("cam");
      background(0);
      image(textCapture, 20, 330);
    }
    if(contiene(mouseX, mouseY, "exit"))
      exit();
  }
}

void changeWindow(String type)
{
  if(type.equals("normal"))
  {
    frame.setSize(600, 240);
    frame.setResizable(false);
  }
  else
  {
    frame.setResizable(true);
    frame.setSize(640, 440);
  }
}

public boolean contiene(int x, int y, String boton) {
  
  boolean pinchado = false;
  if(boton.equals("play") && pantalla == 0){
     pinchado = (esquinaPlayX <= x && x <= esquinaPlayX + anchoBotones) && 
      (esquinaPlayY >= y && y <= esquinaPlayY + altoBotones);
  }
  else if(boton.equals("exit") && pantalla == 0){
     pinchado = (esquinaExitX <= x && x <= esquinaExitX + anchoBotones) && 
      (esquinaPlayY >= y && y <= esquinaPlayY + altoBotones);
  }
  else if(boton.equals("options") && pantalla == 0){
     pinchado = (esquinaOptionsX <= x && x <= esquinaOptionsX + anchoBotones + 60) && 
      (esquinaOptionsY >= y && y <= esquinaOptionsY + altoBotones);
  }
    return pinchado;
  }


