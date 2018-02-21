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

public class NewSketch extends PApplet {

//TestMoviment Personatge

//Zona de variables
int playerX;
int playerY;
final int playerRadiusX = 50;
final int playerRadiusY = 50;

final int speed = 10;

int vectorX;
int vectorY;
int normalizedVectorX;
int normalizedVectorY;
//Zona de setup
public void setup()
{
  
  strokeWeight(5);
  playerX = width/2;
  playerY = height/2;
}

//Zona de draw
public void draw(){
  background(255);
  fill(0,255,0);
  ellipse(playerX,playerY,playerRadiusX,playerRadiusY);

  vectorX = mouseX - playerX;
  vectorY = mouseY - playerY;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  playerX += normalizedVectorX;
  playerY += normalizedVectorY;
}

public void mousePressed(){
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "NewSketch" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
