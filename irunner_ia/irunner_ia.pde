import gifAnimation.*;
import processing.video.*;

PImage bg, ground, ground2, principal, textCapture, repetir, posicion, volver;
PImage pjWalk, options, about, num1, num2, num3, reiniciar, submit;
int i=0, j=0;
float x=100, y=140, jump; //140 para la pava
int n=415, contador=0;

boolean primeraVez, starting = true;
boolean yVoice, yCamera, sonido;
String namePlayer = "";
int speed = 1;

int passedTimeJump;

int savedTime, savedTimeObs, savedTimeJump, savedTimeDead;
int totalTime = 50;
int totalTimeDead = 1000;
int jumpTime = 1000;
int obsTime = 2500;
int esquinaPlayX, esquinaExitX, esquinaOptionsX, esquinaScreenX, esquinaAboutX;
int esquinaPlayY, esquinaOptionsY, esquinaScreenY, esquinaAboutY, anchoBotones, altoBotones;

float big, normal, litle;

boolean dead = false;
boolean bajando = false;
boolean keyup = false;
boolean keyright = false;
boolean keyleft = false;
boolean keydown = false;
boolean keyuplook = false;
boolean keyfast = false;
Gif walkr, background, muestra;
boolean[] suelo;

boolean clickEscribir = false;
PFont f;

String typing = "";
int velocidad = 16;
int pantalla = 0; // 0 = principal, 1 = jugar, 2 = camara, 3 = foto capturada, 4 = opciones, 5 = about, 6 = cuenta atras, 7 = name

String mejorPlayer;
int mejorPuntuacion;
boolean pScore = true;
int pjShow = 0;
int yCreeper = 152;
int yGorrino = 140;

void setup()
{
  size(600,240);
  f = createFont("Arial",24,true);
   setupImagenes();
   walkr = new Gif(this, "img/p1.gif");
   walkr.play();
   
   muestra = new Gif(this, "img/p1.gif");
   muestra.play();
   
   background = new Gif(this, "img/background.gif");
   background.play();
   
   suelo = new boolean[44];
   initializeGround();
   background(250);
   
    savedTime = millis();
   
   
   setupVariables();
}

void setupVariables()
{
  esquinaPlayX = 218;
  esquinaPlayY = 280;
  esquinaExitX = 484;
  esquinaOptionsX = 45;
  esquinaOptionsY = 280;
  esquinaScreenX = 66;
  esquinaScreenY = 157;
  esquinaAboutX = 8;
  esquinaAboutY = 7;
   
  anchoBotones = 148;
  altoBotones = 52;
  
  big = 15;
  normal = 10;
  litle = 5;
   
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
  case 3:
    printCaptura();
    break;
  case 4:
    printOptions();
    break;
  case 5:
    printAbout();
    break;
  case 6:
    printAtras();
    break;
  case 7:
    printRankear();
    break;
  case 8:
    printPosicion();
    break;
  }
}

void printPosicion()
{
  
  if(pScore)
  {
    if(contador == mejorPuntuacion && mejorPlayer.equals(namePlayer))
       posicion = loadImage("img/mejorscore.png");
    else
        posicion = loadImage("img/mejorar.png");
    pScore = false;
  }
  background(0);
  scale(0.6);
  image(loadImage("img/captura-1.png"), 200, 0);
  scale(1.6);
  image(posicion, 0, 250);
  image(volver, 500,0);
}

void setupImagenes()
{
  ground = loadImage("img/groundL.jpg");
   ground2 = loadImage("img/ground2.png");
   principal = loadImage("img/principal.png");
   textCapture = loadImage("img/captura.png");
   repetir = loadImage("img/repetir.png");
   options = loadImage("img/options.png");
   about = loadImage("img/about.png");
   num1 = loadImage("img/cuentaAtras1.png");
   num2 = loadImage("img/cuentaAtras2.png");
   num3 = loadImage("img/cuentaAtras3.png");
   reiniciar = loadImage("img/restart.png");
   submit = loadImage("img/score.png");
   volver = loadImage("img/volver.png");
}

void printRankear()
{
  image(submit, 0, 0);
  textSize(30);
  text(contador, 300, 90);
  color(255,255,0);
 
  textFont(f);
  text(typing.toUpperCase(), 318, 150);
}

void crearObstaculoAleatorio()
{
  if(contador < 1000)
  {
    suelo[40]= false;
    suelo[41]= false;
    suelo[42]= false;
    suelo[43]= false;
  }
  else if(contador > 1000 && contador < 1500)
  {
    suelo[39]= false;
    suelo[40]= false;
    suelo[41]= false;
    suelo[42]= false;
    suelo[43]= false;
  }
  else if(contador > 1500 && contador < 2500)
  {
    suelo[38]= false;
    suelo[39]= false;
    suelo[40]= false;
    suelo[41]= false;
    suelo[42]= false;
    suelo[43]= false;
  }
  else if (contador > 2500 && contador < 5000)
  {
    suelo[37]= false;
    suelo[39]= false;
    suelo[40]= false;
    suelo[41]= false;
    suelo[42]= false;
    suelo[43]= false;
  }
  else
  {
     suelo[36]= false;
    suelo[39]= false;
    suelo[40]= false;
    suelo[41]= false;
    suelo[42]= false;
    suelo[43]= false;
  }
}

void printAtras()
{
  clear();
    image(background,0,0);
    image(num1, 0,0);
    pantalla = 1;
    
}

void printOptions()
{
  image(options, 0 , 0);
  if(pjShow == 1)
    image(muestra, 330, 105);
  else
    image(muestra, 320, 95);
}

void printAbout()
{
  image(about, 0 , 0);
}

void printCaptura()
{
  
  PImage face = loadImage("captura-1.png");
  image(face, 0,0);
  image(repetir, 50, 300);
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
    crearObstaculoAleatorio();
    acelerarTiempo();
    savedTimeObs = millis();
  }
  if(!dead)
    drawGround();
  
  
}

void acelerarTiempo()
{
  if(contador > 500 && contador < 1500)
    obsTime = 2000;
  else if(contador < 3000)
    obsTime = 1500;
}


void moveGround()
{
  boolean[] aux = suelo;
  i = 0;
  while(i < suelo.length)
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
    i++;
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
  
  for(i=0;i<700;i+=velocidad)
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
   passedTimeJump = millis() - savedTimeJump;
  if(keyup == true)
  {
    saltarJu(false);
    image(walkr, x, y);
  }
  else if(/*(suelo[7] == true && dead == false)*/true)
  {
    image(walkr, x, y);
  }
  else
  {
    dead = true;
    y= y+3;
    image(walkr, x, y);
    if(y > 250)
    {
     image(reiniciar, 0, 0);
    }
  }
  if(!dead){
    textSize(30);
    text(contador++, width - (width/6), height/8);
    color(255,255,0);
  }
  else
  {
    text(contador, width - (width/6), height/8);
  }
}
 
 void saltarJu(boolean audio)
 {
   if(passedTimeJump < jumpTime && !bajando)
    {
      y= y-1;
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
   
   if(audio)
    image(walkr, x, y);

 }
 
 void keyPressed() {
   if(pantalla == 3){
     if(key == 'r')
       pantalla = 2;
     else{
       changeWindow("normal");
       pantalla = 0;     
     }
   }
   else if(pantalla == 7)
   {
     if(clickEscribir){
       if(key != '\n')
       typing = typing + key;
       else{
         clickEscribir = false;
         namePlayer = typing;
       }
     }
   }
   if (key == 'a') keyup = true; 
   if (key == 's') keyfast = true; 
   if(key == 'g') 
   {
     if(pantalla == 2){
       saveFrame("captura-1.png");
       pantalla = 3;
       pararEjecucion();
     }
   }
  if (key == CODED) {
    if (keyCode == UP) keyup = true; 
    if (keyCode == DOWN) keydown = true;

  }
 }
  
  void mouseClicked() {
    println(mouseX, mouseY);
  if(pantalla == 0)
  {
    if(contiene(mouseX, mouseY, "play"))
    {
      println("Entramos en play");
     
      pantalla = 6;
      walkr = muestra;
      if(pjShow == 0)
        y = yGorrino;
      else
        y = yCreeper;
      if(yVoice){
         setupCapturarSonido();
        thread("jumpSize");
      }
    }
    else if(contiene(mouseX, mouseY, "exit"))
      exit();
    else if(contiene(mouseX, mouseY, "options")){
      println("Entramos en opciones");
      pantalla = 4;
    }
    else if(contiene(mouseX, mouseY, "about")){
      println("Entramos en about");
      pantalla = 5;
    }
  }
  else if(pantalla == 4)
  {
    if(contiene(mouseX, mouseY, "Screenshoot")){
      println("Entramos en camara");
      pantalla = 2;
      changeWindow("cam");
      background(0);
      image(textCapture, 20, 330);
    }
    else if(contiene(mouseX, mouseY, "sonidoY"))
    {
      sonido = true;
      println(sonido);
    }
    else if(contiene(mouseX, mouseY, "sonidoN"))
    {
      sonido = false;
      println(sonido);
    }
    else if(contiene(mouseX, mouseY, "voiceSi"))
    {
      yVoice = true;
      println(yVoice);
    }
    else if(contiene(mouseX, mouseY, "voiceNo"))
    {
      yVoice = false;
      println(yVoice);
    }
    else if(contiene(mouseX, mouseY, "pjmenos") || contiene(mouseX, mouseY, "pjmas"))
    {
      if(pjShow == 0)
      {
        muestra = new Gif(this, "img/p2.gif");
        pjShow = 1;
      }
      else{
        muestra = new Gif(this, "img/p1.gif");
        pjShow = 0;
      }
      muestra.play();
    }
    else if(contiene(mouseX, mouseY, "exit"))
    {
      pantalla = 0;
    }
    
  }
  else if(pantalla == 5)
  {
    if(contiene(mouseX, mouseY, "aboutY"))
    {
      println("Acepto las condiciones");
      yVoice = true;
      yCamera = true;
      pantalla = 0;
    }
    else if(contiene(mouseX, mouseY, "aboutN"))
    {
      println("No acepto las condiciones");
      yVoice = false;
      yCamera = false;
      pantalla = 0;
    }
  }
  else if(pantalla == 7)
  {
    if(contiene(mouseX, mouseY, "name"))
      clickEscribir = true;
    else if(contador > mejorPuntuacion)
    {
      changeWindow("cam");
      mejorPlayer = namePlayer;
      mejorPuntuacion = contador;
      pantalla = 8;   
    }
  }
  else if(pantalla == 1 && dead == true)
  {
    if(contiene(mouseX, mouseY, "restart"))
    {
      pantalla = 1;
      dead = false;
      contador = 0;
      x = 100;
      y = 140;
    }
    else if(contiene(mouseX, mouseY, "chicken"))
    {
      pantalla = 7;
    }
  }
  else if(pantalla == 8 && contiene(mouseX, mouseY, "volver"))
  {
    clear();
    changeWindow("normal");
    pantalla = 0;
    pScore = true;
    
  }
}

void changeWindow(String type)
{
  if(type.equals("normal"))
  {
    width = 612;
    height = 278;
    frame.setSize(width, height); 
  }
  else
  {
    frame.setResizable(true);
    frame.setSize(640, 440);
  }
  
  println(width, height);
}

public boolean contiene(int x, int y, String boton) {
  
  boolean pinchado = false;
  if(boton.equals("play") && pantalla == 0){
     pinchado = (esquinaPlayX <= x && x <= esquinaPlayX + anchoBotones) && 
      (esquinaPlayY >= y && y <= esquinaPlayY + altoBotones);
  }
  else if(boton.equals("exit") && (pantalla == 0 || pantalla == 4)){
     pinchado = (esquinaExitX <= x && x <= esquinaExitX + anchoBotones) && 
      (esquinaPlayY >= y && y <= esquinaPlayY + altoBotones);
  }
  else if(boton.equals("options") && pantalla == 0){
     pinchado = (esquinaOptionsX <= x && x <= esquinaOptionsX + anchoBotones + 60) && 
      (esquinaOptionsY >= y && y <= esquinaOptionsY + altoBotones);
  }
  else if(boton.equals("about") && pantalla == 0){
     pinchado = (esquinaAboutX <= x && x <= esquinaAboutX + anchoBotones - 40) && 
      (esquinaAboutY <= y && y <= (esquinaAboutY + altoBotones - 10));
  }
  else if(boton.equals("aboutY") && pantalla == 5){
      pinchado = (121 <= x && x <= 121 + anchoBotones/2) && 
      (207 <= y && y <= 207 + altoBotones);
  }
  else if(boton.equals("aboutN") && pantalla == 5){
     pinchado = (400 <= x && x <= 400 + anchoBotones/2) && 
      (207 <= y && y <= 207 + altoBotones);
  }
  else if(boton.equals("sonidoY") && pantalla == 4){
     pinchado = (278 <= x && x <= 278 + anchoBotones/2) && 
      (70 <= y && y <= 70 + altoBotones);
  }
  else if(boton.equals("sonidoN") && pantalla == 4){
     pinchado = (364 <= x && x <= 364 + anchoBotones/2) && 
      (70 <= y && y <= 70 + altoBotones);
  }
  else if(boton.equals("Screenshoot") && pantalla == 4){
     pinchado = (66 <= x && x <= 66 + anchoBotones) && 
      (158 <= y && y <= 158 + altoBotones);
  }
  else if(boton.equals("restart") && pantalla == 1){
     pinchado = (151 <= x && x <= 151 + anchoBotones/2) && 
      (140 <= y && y <= 140 + altoBotones);
  }
  else if(boton.equals("chicken") && pantalla == 1){
     pinchado = (375 <= x && x <= 375 + anchoBotones) && 
      (140 <= y && y <= 140 + altoBotones);
  }
  else if(boton.equals("name") && pantalla == 7){
     pinchado = (306 <= x && x <= 306 + anchoBotones) && 
      (125 <= y && y <= 126 + altoBotones);
  }
  else if(boton.equals("ranking") && pantalla == 7){
     pinchado = (374 <= x && x <= 374 + anchoBotones) && 
      (194 <= y && y <= 194 + altoBotones);
  }
  else if(boton.equals("volver") && pantalla == 8){
     pinchado = (475 <= x && x <= 475 + anchoBotones) && 
      (10 <= y && y <= 10 + altoBotones);
  }
  else if(boton.equals("pjmas") && pantalla == 4){
     pinchado = (255 <= x && x <= 255 + anchoBotones/2) && 
      (116 <= y && y <= 116 + (altoBotones-10));
  }
 else if(boton.equals("pjmenos") && pantalla == 4){
     pinchado = (402 <= x && x <= 402 + anchoBotones/2) && 
      (116 <= y && y <= 116 + (altoBotones-10));
  }
  else if(boton.equals("exit") && pantalla == 4){
     pinchado = (506 <= x && x <= 506 + anchoBotones) && 
      (204 <= y && y <= 204 + altoBotones);
  }
  else if(boton.equals("voiceNo") && pantalla == 4){
     pinchado = (364 <= x && x <= 364 + anchoBotones/2) && 
      (195 <= y && y <= 195 + (altoBotones-10));
  }
 else if(boton.equals("voiceSi") && pantalla == 4){
     pinchado = (280 <= x && x <= 280 + anchoBotones/2) && 
      (195 <= y && y <= 195 + (altoBotones-10));
  }
    return pinchado;
  }


