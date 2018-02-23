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

public class TiltToProcessing extends PApplet {

//TestMoviment Personatge

//Zona de variables
//Variables per la creacio del personatge i enemics
int playerX;
int playerY;
final int playerRadiusX = 20;
final int playerRadiusY = 20;
int enemy1X;
int enemy1Y;
int enemy2X;
int enemy2Y;
int enemy3X;
int enemy3Y;
//Variable estatica per controlar la velocitat del joc
final int speed = 5;
final int enemy1Speed = 4;
final int enemy2Speed = 3;
final int enemy3Speed = 2;
//variables per calcular el vector de moviment
int vectorX;
int vectorY;
int normalizedVectorX;
int normalizedVectorY;
//Zona de setup
public void setup()
{
    //Pantalla complerta
  
    //Modificar ample del pinzell
  strokeWeight(5);
    //Posicio inicial del personatge principal
  playerX = width/2;
  playerY = height/2;
  //posicio inicial dels enemics
  enemy1X = 0;
  enemy1Y = 0;
  enemy2X = width;
  enemy2Y = 0;
  enemy3X = width;
  enemy3Y = height;
}

//Zona de draw
public void draw(){
  //background blanc
  background(255);
  //Creem el personatge a una posici\u00f3 i el pintem de color verd
  fill(0,255,0);
  ellipse(playerX, playerY, playerRadiusX, playerRadiusY);
  //Creem  els enemics a les seves posici\u00f3s i els pintem de color vermell
  fill(255,0,0);
  ellipse(enemy1X, enemy1Y, playerRadiusX, playerRadiusY);
  ellipse(enemy2X, enemy2Y, playerRadiusX, playerRadiusY);
  ellipse(enemy3X, enemy3Y, playerRadiusX, playerRadiusY);

  //Calculem el vector director normalitzat que ens moura el personatge
  vectorX = mouseX - playerX;
  vectorY = mouseY - playerY;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  playerX += normalizedVectorX;
  playerY += normalizedVectorY;
//moviement enemic 1
  vectorX = playerX - enemy1X;
  vectorY = playerY - enemy1Y;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy1Speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy1Speed);
  enemy1X += normalizedVectorX;
  enemy1Y += normalizedVectorY;
//moviment enemic2
  vectorX = playerX - enemy2X;
  vectorY = playerY - enemy2Y;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy2Speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy2Speed);
  enemy2X += normalizedVectorX;
  enemy2Y += normalizedVectorY;
//moviment enemic 3
  vectorX = playerX - enemy3X;
  vectorY = playerY - enemy3Y;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy3Speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*enemy3Speed);
  enemy3X += normalizedVectorX;
  enemy3Y += normalizedVectorY;
}

public void mousePressed(){
  //Multiplicant la velocitat per deu fem que es crei un efecte similar al del dash
  vectorX = mouseX - playerX;
  vectorY = mouseY - playerY;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed*5);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed*5);
  playerX += normalizedVectorX;
  playerY += normalizedVectorY;

}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TiltToProcessing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
