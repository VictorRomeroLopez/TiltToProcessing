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

//Zona de variables
final int POSITIONX = 0;
final int POSITIONY = 1;
//Variables per la creacio del personatge i enemics
int playerPosition[]={0,0};
// int playerY;
final int playerRadiusX = 20;
final int playerRadiusY = 20;
int mousePosition[] = {0,0};
int enemy1Position[] = {0,0};
int enemy2Position[] = {0,0};
int enemy3Position[] = {0,0};
//Variable estatica per controlar la velocitat del joc
final int speed = 5;
final int enemy1Speed = ceil(speed*0.8f);
final int enemy2Speed = ceil(speed*0.6f);
final int enemy3Speed = ceil(speed*0.4f);
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
  playerPosition[POSITIONX] = width/2;
  playerPosition[POSITIONY] = height/2;
  //posicio inicial dels enemics
  enemy1Position[POSITIONX] = 0;
  enemy1Position[POSITIONY] = 1;
  enemy2Position[POSITIONX] = width;
  enemy2Position[POSITIONY] = 1;
  enemy3Position[POSITIONX] = width;
  enemy3Position[POSITIONY] = height;
}

//Zona de draw
public void draw(){
  mousePosition[POSITIONX] = mouseX;
  mousePosition[POSITIONY] = mouseY;
  //background blanc
  background(255);
  //Creem el personatge a una posici\u00f3 i el pintem de color verd
  fill(0,255,0);
  ellipse(playerPosition[POSITIONX], playerPosition[POSITIONY], playerRadiusX, playerRadiusY);
  //Creem  els enemics a les seves posici\u00f3s i els pintem de color vermell
  fill(255,0,0);
  ellipse(enemy1Position[POSITIONX], enemy1Position[POSITIONY], playerRadiusX, playerRadiusY);
  ellipse(enemy2Position[POSITIONX], enemy2Position[POSITIONY], playerRadiusX, playerRadiusY);
  ellipse(enemy3Position[POSITIONX], enemy3Position[POSITIONY], playerRadiusX, playerRadiusY);
  movement(playerPosition, mousePosition, speed);
  movement(enemy1Position, playerPosition, enemy1Speed);
  movement(enemy2Position, playerPosition, enemy2Speed);
  movement(enemy3Position, playerPosition, enemy3Speed);

}

public void mousePressed(){
  //Multiplicant la velocitat per deu fem que es crei un efecte similar al del dash
  movement(playerPosition, mousePosition, speed*5);
}

public void movement(int startPoint[], int endPoint[], int speed){
    vectorX = endPoint[POSITIONX] - startPoint[POSITIONX];
    vectorY = endPoint[POSITIONY] - startPoint[POSITIONY];
    normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
    normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
    startPoint[POSITIONX] += normalizedVectorX;
    startPoint[POSITIONY] += normalizedVectorY;
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
