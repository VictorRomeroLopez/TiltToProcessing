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
int enemy1X;
int enemy1Y;
int enemy2X;
int enemy2Y;
int enemy3X;
int enemy3Y;
final int speed = 15;
final int enemy1Speed = 10;
final int enemy2Speed = 8;
final int enemy3Speed = 5;

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
  enemy1X = 0;
  enemy1Y = 0;
  enemy2X = width;
  enemy2Y = 0;
  enemy3X = width;
  enemy3Y = height;
}

//Zona de draw
public void draw(){
  background(255);
  fill(0,255,0);
  ellipse(playerX,playerY,playerRadiusX,playerRadiusY);
  fill(255,0,0);
  ellipse(enemy1X, enemy1Y,playerRadiusX,playerRadiusY);
  fill(255,0,0);
  ellipse(enemy2X, enemy2Y,playerRadiusX,playerRadiusY);
  fill(255,0,0);
  ellipse(enemy3X, enemy3Y,playerRadiusX,playerRadiusY);
  vectorX = mouseX - playerX;
  vectorY = mouseY - playerY;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  playerX += normalizedVectorX;
  playerY += normalizedVectorY;

  vectorX = playerX - enemy1X;
  vectorY = playerY - enemy1Y;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy1Speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy1Speed);
  enemy1X += normalizedVectorX;
  enemy1Y += normalizedVectorY;

  vectorX = playerX - enemy2X;
  vectorY = playerY - enemy2Y;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy2Speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy2Speed);
  enemy2X += normalizedVectorX;
  enemy2Y += normalizedVectorY;

  vectorX = playerX - enemy3X;
  vectorY = playerY - enemy3Y;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy3Speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy3Speed);
  enemy3X += normalizedVectorX;
  enemy3Y += normalizedVectorY;
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
