import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TestPlayer extends PApplet {

//Tama\u00f1o del cuadrado a crear
int bs = 20;
//Controla la velocitat del joc
int speed = 15;
//Variables que controlan el personaje principal
int playerX;
int playerY;

public void setup(){
  //Tama\u00f1o de la ventana
  
  //Grueso del pinzel
  strokeWeight(0);
  playerX = width/2;
  playerY = height/2;
}

public void draw(){
  //Color de fondo a blanco
  background(255);

  //Rellena la elipse donde esta situado nuestro personaje de color verde
  fill(0,255,0);
  ellipse(playerX,playerY,bs,bs);
  //Si detecta una tecla presionada (w,a,s,d) mueve el
  //personaje hacia la direccion designada a cada letra
  if(keyPressed){
    if(key == 'w'){
      playerY-=10;
    }else if(key == 'a'){

    }else if(key == 's'){

    }else if(key == 'd'){

    }
  }
  //Impide que el personaje pueda salir de la ventana
  limitPlayer();

}
public void limitPlayer(){
   if(playerX > width)
     playerX = width;
   if(playerY > height)
     playerY = height;
   if(playerX < 0)
     playerX = 0;
   if(playerY < 0)
     playerY = 0;
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TestPlayer" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
