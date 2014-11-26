import gifAnimation.*;
import processing.video.*;


PImage bg2, coin, pipe, ground, ground2;
PImage bg, flyright, flyleft, fastleft, fastleft2;
PImage fastleft3, fastright, fastright2, fastright3;
PImage rightup, leftup, leftjump, rightjump, leftfall, rightfall;
PImage duckleft, duckright,marioleft, mariowalkleft;
PImage pjWalk;
PImage LtoR,RtoL;
int PointsCounter = 0,LR =0,once=1,jumpon=0,jumptime=0,onejump=0, stime=0, i=0, j=0;
float x=100, y=170, speed=0,slow = 0, jump, g=670;
int n=415, contador=0;


boolean keyup = false;
boolean keyright = false;
boolean keyleft = false;
boolean keydown = false;
boolean keyuplook = false;
boolean keyfast = false;
Gif walkr, background;


void setup()
{
  size(600,300);

   bg = loadImage("bg.png");
   ground = loadImage("ground.png");
   ground2 = loadImage("ground2.png");
   walkr = new Gif(this, "walkr.gif");
   walkr.play();
   background = new Gif(this, "background.gif");
   background.play();
   
   background(250);
   
}

void draw()
{
  //background(250);
  paint(); 
  drawGround();
  
}


void drawGround()
{
  for(i=0;i<700;i+=16)
    {
      image(ground,i,235);
    }
    for(i=0;i<700;i+=16)
    {
      for(j = 16; j<50; j+=16)
      {
        image(ground2,i,235+j);
      }
    } 
}
 
void paint()
{
  image(background,0,0);
  image(walkr, x, y);
  //text(contador++, width - (width/6), height/8);
  //color(255,255,0);
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

