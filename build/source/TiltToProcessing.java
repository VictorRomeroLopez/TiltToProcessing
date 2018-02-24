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
final int ELLIPSERADIUS = 100;
<<<<<<< Updated upstream
//Variables per la creacio del personatge , enemics i obstacles
int playerPosition[]={0,0};
final int min = 1;
int maxX;
int maxY;
final int playerRadiusX = 20;
final int playerRadiusY = 20;
=======
final int NUMOBSTACLES = 3;
//Variables per la creacio del personatge i enemics
// int playerY;
final int min = 1;
final int maxX = ceil(height/100) - 3;
final int maxY = ceil(width/100) - 1;
>>>>>>> Stashed changes
final int obstacleRadiusX = 100;
final int obstacleTRadiusY = 100;
int obstacleX_values [] = {0,0,0};
int obstacleY_values [] = {0,0,0};
boolean sameX = true;
boolean sameY = true;
//Variable estatica per controlar la velocitat del joc
final int speed = 10;
int i = 0;
int j = 0;
int mousePointer[] = {0,0};
Player player;
Enemy enemies[] = new Enemy[50];
int enemyGenerationSpeed = 15;

//Zona de setup
public void setup()
{
  //Pantalla complerta
  
  //fem set de la X maxima i de la Y maxima a la que es podra generar un valor
  maxX = ceil(width/100) - 3;
  maxY = ceil(height/100) - 1;
  //Modificar ample del pinzell
  player = new Player();

  // generateObstacle(obstacleX_values, obstacleY_values);
  // printObstacle(obstacleX_values, obstacleY_values);
}

//Zona de draw
public void draw(){
  //Background blanc
  background(255);
  //Obtenim la possici\u00f3 del mouse
  mousePointer[0] = mouseX;
  mousePointer[1] = mouseY;
  // printObstacle(obstacleX_values, obstacleY_values);
  player.pop();
  if (!player.mouseColision(mousePointer)){
    player.moveTowards(mousePointer, speed);
  }
  if(j<enemies.length){
    if(frameCount % enemyGenerationSpeed == 0){
      enemies[i] = new Enemy();
      enemies[i].pop();
      i++;
      j++;
    }
  }

  for( int k = 0; k<j; k++){
    enemies[k].pop();
    enemies[k].moveTowards(player.position, ceil(random(1,speed-1)));
    if(enemies[k].colision(player.position, player.radius)){
      // player.position[0] = width/2;
      // player.position[1] = height/2;
      exit();
    }
  }

}

public void mousePressed(){
  if(!player.mouseColision(mousePointer))
    player.moveTowards(mousePointer, speed*10);
}

// void generateObstacle(int obstalceX_values[], int obstacleY_values[]){
//     obstalceX_values[0] = ceil(random(1,10));
//     obstacleY_values[0] = ceil(random(1,9));
//
//     while(sameX && sameY)
//     {
//         obstalceX_values[1] = ceil(random(1,10));
//         if(obstalceX_values[0] != obstalceX_values[1])
//         {
//           sameX = false;
//         }
//         obstacleY_values[1] = ceil(random(1,9));
//         if(obstacleY_values[0] != obstacleY_values[1])
//         {
//           sameY = false;
//         }
//     }
//     sameX = true;
//     sameY = true;
//     while(sameX && sameY){
//         obstalceX_values[2] = ceil(random(1, 10));
//         if(obstalceX_values[2] != obstalceX_values[1]){
//           sameX = false;
//         }
//         obstacleY_values[2] = ceil(random(1, 9));
//         if(obstacleY_values[2] != obstacleY_values[1]){
//           sameY = false;
//         }
//     }
// }
//
// void printObstacle(int obstacleX_values[], int obstalceY_values[]){
//
//   fill(23,240,230);
//   ellipse(maxX * ELLIPSERADIUS, maxY * ELLIPSERADIUS, obstacleRadiusX, obstacleRadiusX );
//
//   for(int i=0; i< obstacleX_values.length; i++){
//     ellipse(obstacleX_values[i] * ELLIPSERADIUS, obstalceY_values[i] * ELLIPSERADIUS, obstacleRadiusX, obstacleRadiusX );
//   }
//
// }
class Enemy extends MovingObject{
  Enemy(){
    position[POSITIONX] = ceil(random(0,width));
    position[POSITIONY] = ceil(random(0,height));
  }

  public void pop(){
    fill(255,0,0);
    strokeWeight(0);
    ellipse(position[POSITIONX], position[POSITIONY], radius, radius);
  }
}
class MovingObject{
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  int position[] = { 0, 0 };
  int radius = 20;
  private int vectorX;
  private int vectorY;
  private int normalizedVectorX;
  private int normalizedVectorY;
  public int magnitudeVectorX;
  public int magnitudeVectorY;

  public void moveTowards(int endPos[], int speed){
    vectorX = endPos[POSITIONX] - position[POSITIONX];
    vectorY = endPos[POSITIONY] - position[POSITIONY];
    normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
    normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
<<<<<<< Updated upstream
    startPoint[POSITIONX] += normalizedVectorX;
    startPoint[POSITIONY] += normalizedVectorY;
}

public void generateObstacle(int obstalceX_values[], int obstacleY_values[]){
  //fem un random entre el maxim i el minim, arrodonint a la baixa i guardantho a un array
    obstalceX_values[0] = ceil(random(min,maxX));
    obstacleY_values[0] = ceil(random(min,maxY));
  //fem un random entre el maxim i el minim, arrodonint a la baixa i guardantho a un array
    while(sameX || sameY)
    {
        obstalceX_values[1] = ceil(random(1,maxX));
        sameX = obstalceX_values[0] == obstalceX_values[1];
        obstacleY_values[1] = ceil(random(min,maxY));
        sameY = obstacleY_values[0] == obstacleY_values[1];
    }
    sameX = true;
    sameY = true;
    while(sameX || sameY){
        obstalceX_values[2] = ceil(random(min, maxX));
        sameX = (obstalceX_values[2] == obstalceX_values[1]);
        obstacleY_values[2] = ceil(random(min, maxY));
        sameY = (obstacleY_values[2] == obstacleY_values[1]);
    }
}

public void printObstacle(int obstacleX_values[], int obstalceY_values[]){
  fill(23,240,230);

  for(int i=0; i< obstacleX_values.length; i++){
  ellipse(obstacleX_values[i]* ELLIPSERADIUS, obstalceY_values[i] * ELLIPSERADIUS, obstacleRadiusX, obstacleRadiusX );
=======
    position[POSITIONX] += normalizedVectorX;
    position[POSITIONY] += normalizedVectorY;
  }

  public boolean colision(int endPos[], int endRadius){
      magnitudeVectorX = ceil(sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONX] - position[POSITIONX],2)));
      magnitudeVectorY = ceil(sqrt(pow(endPos[POSITIONY] - position[POSITIONY],2) + pow(endPos[POSITIONY] - position[POSITIONY],2)));
      return magnitudeVectorX < (endRadius*0.75f+radius*0.75f) && magnitudeVectorY < (endRadius*0.75f+radius*0.75f);
  }
>>>>>>> Stashed changes
}
class Player extends MovingObject{
  Player(){
    position[POSITIONX] = width/2;
    position[POSITIONY] = height/2;
  }

  public void pop(){
    fill(0,255,0);
    strokeWeight(0);
    ellipse(position[POSITIONX], position[POSITIONY], radius, radius);
  }

  public boolean mouseColision(int endPos[]){
      magnitudeVectorX = ceil(sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONX] - position[POSITIONX],2)));
      magnitudeVectorY = ceil(sqrt(pow(endPos[POSITIONY] - position[POSITIONY],2) + pow(endPos[POSITIONY] - position[POSITIONY],2)));
      return magnitudeVectorX < radius/2 && magnitudeVectorY < radius/2;
  }
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
