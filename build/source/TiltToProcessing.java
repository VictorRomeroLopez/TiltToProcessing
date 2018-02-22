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
//Variables per la creacio del personatge
int playerX;
int playerY;
final int playerRadiusX = 50;
final int playerRadiusY = 50;

//Variable estatica per controlar la velocitat del joc
final int speed = 10;

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
}

//Zona de draw
public void draw(){
  //background blanc
  background(255);
  //Creem el personatge a una posici\u00f3 i el pintem de color verd
  fill(0,255,0);
  ellipse(playerX,playerY,playerRadiusX,playerRadiusY);

    //Notas: Intenta que el moviment estigui posat a una funcio tenint que pasarli
    //per parametre el punt inicial i el final. Els parametres de l'inicial
    //han de ser passats per referencia. He estat buscant pero no es fa igual que
    //a C. Busca si es pot fer.

  //Calculem el vector director normalitzat que ens moura el personatge
  vectorX = mouseX - playerX;
  vectorY = mouseY - playerY;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  //Es suma el vector resultant descomposat als seus respectius eixos
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
