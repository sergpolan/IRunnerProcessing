import ddf.minim.*;

Minim minim;
AudioInput in;

int actualTim;
int refreshTim = 1000;

void setupCapturarSonido()
{
  
  minim = new Minim(this);
  minim.debugOn();
  
  in = minim.getLineIn(Minim.STEREO, 512);
  actualTim = millis();  
  
}

void jumpSize()
{
  println("entroooo");
  int passedTim = 0;
  float maximo = 0;
  while(true)
  {
    for(int i = 0; i < in.bufferSize() - 1; i++)
    {
       passedTim = millis() - actualTim;
      float actual = in.left.get(i);
      if(actual > maximo){
        maximo = actual;
      }
      if(passedTim > refreshTim)
       {
         println(maximo);
         maximo = 0;
         actualTim = millis();
       }
    }
  }
}
