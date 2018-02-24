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
int MAXX;
int MAXY;
final int MIN = 1;
final int BS = 100;
final int SPEED = 10;
int enemyGenerationSpeed = 15;
int obstacleX_value [] = {0,0,0};
int obstacleY_value [] = {0,0,0};
int i = 0;
int j = 0;
int mousePointer[] = {0,0};
Enemy enemies[] = new Enemy[25];
Player player;

//Zona de setup
public void setup()
{
  //Pantalla complerta
  
  //fem set de la X maxima i de la Y maxima a la que es podra generar un valor
  MAXX = ceil(width/BS)-1;
  MAXY = ceil(height/BS)-1;
  player = new Player();
  generateObstacle();
}

//Zona de draw
public void draw(){
  //Background blanc
  background(255);
  //Obtenim la possici\u00f3 del mouse
  mousePointer[0] = mouseX;
  mousePointer[1] = mouseY;
  //imprim tots els obstacles
  printObstacle();
  //fem apareixer el jugador
  player.pop();
  //moviment del jugador
  if (!player.mouseColision(mousePointer)){
    player.moveTowards(mousePointer, SPEED);
  }
  //generador d'ememics a l'array
  if(j<enemies.length){
    if(frameCount % enemyGenerationSpeed == 0){
      enemies[i] = new Enemy();
      enemies[i].pop();
      i++;
      j++;
    }
  }
  //aparici\u00f3 dels enemics a l'escenari i el persegueixen
  for( int k = 0; k<j; k++){
    enemies[k].pop();
    enemies[k].moveTowards(player.position, ceil(random(1,SPEED-1)));
    //passa alguna cosa si els enemics toquen al player
    if(enemies[k].colision(player.position, player.radius)){
      exit();
    }
  }
}

public void mousePressed(){
  if(!player.mouseColision(mousePointer))
    player.moveTowards(mousePointer, SPEED*10);
}

public void generateObstacle(){
  int i = 0;
  int counter = 0;
  obstacleX_value[i] = ceil(random(MIN,MAXX));
  obstacleY_value[i] = ceil(random(MIN,MAXY));
  i++;
  while( i < obstacleX_value.length){
    counter = i;
    obstacleX_value[i] = ceil(random(MIN,MAXX));
    obstacleY_value[i] = ceil(random(MIN,MAXY));
    while(counter != 0){
      if(obstacleX_value[i] == obstacleX_value[counter-1] && obstacleY_value[i] == obstacleY_value[counter-1]){
        obstacleX_value[i] = ceil(random(MIN,MAXX));
        obstacleY_value[i] = ceil(random(MIN,MAXY));
        counter = i;
      }
      counter--;
    }
    i++;
  }
}

public void printObstacle(){
  fill(23,240,230);
  for(int i=0; i< obstacleX_value.length; i++){
    ellipse(obstacleX_value[i] * BS, obstacleY_value[i] * BS, BS, BS );
  }
}
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
    position[POSITIONX] += normalizedVectorX;
    position[POSITIONY] += normalizedVectorY;
  }

  public boolean colision(int endPos[], int endRadius){
      magnitudeVectorX = ceil(sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONX] - position[POSITIONX],2)));
      magnitudeVectorY = ceil(sqrt(pow(endPos[POSITIONY] - position[POSITIONY],2) + pow(endPos[POSITIONY] - position[POSITIONY],2)));
      return magnitudeVectorX < (endRadius*0.75f+radius*0.75f) && magnitudeVectorY < (endRadius*0.75f+radius*0.75f);
  }
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
