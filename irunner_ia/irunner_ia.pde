import gifAnimation.*;
import processing.video.*;


PImage bg, ground, ground2;
PImage pjWalk;
int PointsCounter = 0,LR =0,once=1,jumpon=0,jumptime=0,onejump=0, stime=0, i=0, j=0;
float x=100, y=140, speed=0,slow = 0, jump, g=670;
int n=415, contador=0;

int savedTime;
int totalTime = 50;

boolean dead = false;

boolean keyup = false;
boolean keyright = false;
boolean keyleft = false;
boolean keydown = false;
boolean keyuplook = false;
boolean keyfast = false;
Gif walkr, background;
boolean[] suelo;

void setup()
{
  size(600,240);

   bg = loadImage("bg.png");
   ground = loadImage("groundL.jpg");
   ground2 = loadImage("ground2.png");
   walkr = new Gif(this, "p2.gif");
   walkr.play();
   background = new Gif(this, "background.gif");
   background.play();
   
   suelo = new boolean[44];
   initializeGround();
   background(250);
   
   suelo[21] = false;
   suelo[22] = false;
   suelo[23] = false;
   suelo[24] = false;
   suelo[25] = false;
   suelo[26] = false;
   suelo[27] = false;
   suelo[28] = false;
   suelo[29] = false;
   suelo[30] = false;
  
  savedTime = millis();
   
}

void draw()
{
  paint(); 
   int passedTime = millis() - savedTime;
  if (passedTime > totalTime) {
  moveGround();
  savedTime = millis();
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
 
void paint()
{
  image(background,0,0);
  if(suelo[7] == true && dead == false)
  {
    image(walkr, x, y);
  }
  else
  {
    dead = true;
    y++;
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
  if (key == CODED) {
    if (keyCode == UP) keyuplook = true; 
    if (keyCode == DOWN) keydown = true;

  }
}
 
void keyReleased() {
  if (key == 'a') keyup = false;
  if (key == 's') keyfast = false;
  if (key == CODED) {
    if (keyCode == UP) keyuplook = false; 
    if (keyCode == DOWN) keydown = false; 
  }
}

