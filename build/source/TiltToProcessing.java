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
final int NUM_ENEMIES = 25;
final int NUM_OBSTACLES = 3;
final int SPEED = 10;
final int TEXTSIZEAA1 = 200;
final int TEXTSIZEEXIT = 32;
final int PLAYER_SPAWN_AREA = 25;
int enemyGenerationSpeed = 15;
boolean colisionObstacle;
//variables de control del joc i dels menus
boolean mainMenu;
boolean gameEnd;
boolean miceControl;
boolean keyboardControl;

int i = 0;
int j = 0;
float mousePointer[] = {0,0};
Enemy enemies[] = new Enemy[NUM_ENEMIES];
Obstacle obstacles[] = new Obstacle[NUM_OBSTACLES];
Player player;
//variables per la creaci\u00f3 de la sortida
String EXITMESSAGE = "EXIT";
float sortidaXY[] = {0,0};

final int RADIUS = 100;
//VARIABLES PER LA SELECCIO DE CONTROLS
float titleXY[] = {0,0};
//Zona de setup
public void setup()
{
  //Pantalla complerta
  
  mainMenu = false;
  gameEnd = false;
  player = new Player();
  //generaci\u00f3 del primer punt del triangle que ser\u00e0 la sortida
  sortidaXY[POSITIONX] = random(300, width-300);
  sortidaXY[POSITIONY] = random(300, height-300);

  titleXY[POSITIONX] = width/2;
  titleXY[POSITIONY] = height/2;
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i] = new Obstacle();
  }
  generateObstacles();
}

//Zona de draw
public void draw(){
  //Background blanc
  background(255);

  if(mainMenu){
    theMainMenu();
  }
  else if (!mainMenu && !gameEnd){
  //Obtenim la possici\u00f3 del mouse
  mousePointer[0] = mouseX;
  mousePointer[1] = mouseY;
  //Set de la variable a false
  colisionObstacle = false;
  //Imprim tots els obstacles
  fill(24,240,230);
  printObstacles();
  //fem apareixer el jugador
  player.pop();
  //moviment del jugador

  for(int i = 0; i < obstacles.length && !colisionObstacle ; i++){
    if(player.colision(obstacles[i].position, obstacles[i].getRadius())){
      colisionObstacle = true;
      player.colisionMovement(obstacles[i].position, obstacles[i].getRadius(), SPEED);
    }
  }
  if (!colisionObstacle && !player.mouseColision(mousePointer)){
    player.moveTowards(mousePointer, SPEED);
  }else if(!colisionObstacle){
    player.position[POSITIONX] = mouseX;
    player.position[POSITIONY] = mouseY;
  }

  //generador d'ememics a l'array
  if(j<enemies.length){
    if(frameCount % enemyGenerationSpeed == 0){
      enemies[i] = new Enemy();
      do{
      colisionObstacle = false;
      for(int l = 0; l < obstacles.length && !colisionObstacle ; l++){
          if(enemies[i].colision(obstacles[l].position, obstacles[l].getRadius()) || enemies[i].colision(player.position, player.radius*PLAYER_SPAWN_AREA)){
            colisionObstacle = true;
            enemies[i].randomize();
          }
        }
      }while(colisionObstacle);
      enemies[i].pop();
      i++;
      j++;
    }
  }
  //aparici\u00f3 dels enemics a l'escenari i el persegueixen
  for( int k = 0; k<j; k++){
    enemies[k].pop();
    colisionObstacle = false;
    for(int i = 0; i < obstacles.length && !colisionObstacle ; i++){
      if(enemies[k].colision(obstacles[i].position, obstacles[i].getRadius())){
        colisionObstacle = true;
        enemies[k].colisionMovement(obstacles[i].position, obstacles[i].getRadius(), SPEED);
      }
    }
    if(!colisionObstacle)
      enemies[k].moveTowards(player.position, ceil(random(1,SPEED-1)));
    //passa alguna cosa si els enemics toquen al player
    if(enemies[k].colision(player.position, player.radius)){
      exit();
    }
  }

  }
  else{
    fill(0);
    textSize(TEXTSIZEAA1);
    text("YOU WON", titleXY[POSITIONX]-TEXTSIZEAA1*2.5f, titleXY[POSITIONY]);
  }
}



public void generateExit(){
  //println(x1,y1,x1+(TRIANGLEAREA/2),y1,x1+(TRIANGLEAREA/4),y1-(TRIANGLEAREA/2));

  //generem un triangle equilater
  fill(233,200,0);
  ellipse(sortidaXY[POSITIONX],sortidaXY[POSITIONY],100,100);
  fill(0);
  textSize(TEXTSIZEEXIT);
  text(EXITMESSAGE,sortidaXY[POSITIONX]-TEXTSIZEEXIT,sortidaXY[POSITIONY]-50);
}

public void mousePressed(){
  // println(' ');
  // println(player.position);
  // println(' ');
  if(!player.mouseColision(mousePointer))
    player.moveTowards(mousePointer, SPEED*10);
}

public void generateObstacles(){
  int i = 0;
  int counter = 0;
  obstacles[i].randomizePosition();
  i++;
  while( i < obstacles.length){
    counter = i;
    obstacles[i].randomizePosition();
    while(counter != 0){
      if(obstacles[i].getPosition(POSITIONX) == obstacles[counter-1].getPosition(POSITIONX) && obstacles[i].getPosition(POSITIONY) == obstacles[counter-1].getPosition(POSITIONY)+100){
      obstacles[i].randomizePosition();
        counter = i;
      }
      counter--;
    }
    i++;
  }
}

public void printObstacles(){
  for(int i = 0; i< obstacles.length; i++){
    obstacles[i].printObstacle();
  }
}

public void theMainMenu(){
  fill(0);
  textSize(TEXTSIZEAA1);
  text("AA1", titleXY[POSITIONX]-TEXTSIZEAA1, titleXY[POSITIONY]);

  ellipse(titleXY[POSITIONX]/2,titleXY[POSITIONY]-TEXTSIZEEXIT,RADIUS,RADIUS);
  textSize(TEXTSIZEEXIT);
  text("KEYBOARD CONTROL",titleXY[POSITIONX]/2+RADIUS/2-TEXTSIZEEXIT*6,titleXY[POSITIONY]-RADIUS);
  ellipse(titleXY[POSITIONX]/2+titleXY[POSITIONX],titleXY[POSITIONY]-TEXTSIZEEXIT,RADIUS,RADIUS);
  text("MICE CONTROL",titleXY[POSITIONX]/2+titleXY[POSITIONX]-RADIUS/3-TEXTSIZEEXIT*2,titleXY[POSITIONY]-RADIUS);
}
class Enemy extends MovingObject{
  Enemy(){
    position[POSITIONX] = ceil(random(0,width));
    position[POSITIONY] = ceil(random(0,height));
  }

  public void randomize(){
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
  float position[] = { 0, 0 };
  int radius = 20;
  public float magnitudeVector;

  public void moveTowards(float endPos[], int speed){
    float vectorX;
    float vectorY;
    vectorX = endPos[POSITIONX] - position[POSITIONX];
    vectorY = endPos[POSITIONY] - position[POSITIONY];
    position[POSITIONX] += (vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed;
    position[POSITIONY] += (vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed;
  }

  public boolean colision(float endPos[], int endRadius){
      magnitudeVector = sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONY] - position[POSITIONY],2));
      return magnitudeVector < (endRadius * 0.5f + radius * 0.5f);
  }

  public void colisionMovement(float colisionPos[], int radiusObstacle, int speed){
    PVector v = new PVector(position[POSITIONX] - colisionPos[POSITIONX], position[POSITIONY] - colisionPos[POSITIONY]);
    v.setMag(radiusObstacle/2 + radius/2 + 1);
    position[POSITIONX] = v.x + colisionPos[POSITIONX];
    position[POSITIONY] = v.y + colisionPos[POSITIONY];
  }
}
class Obstacle{
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  final int RADIUS = 100;
  final int MIN = 1;
  final int MAXX = ceil(width/RADIUS)-1;
  final int MAXY = ceil(height/RADIUS)-1;
  float position[] = {0.0f,0.0f};

  Obstacle(){
    position[POSITIONX] = random(MIN,MAXX)*RADIUS;
    position[POSITIONY] = random(MIN,MAXY)*RADIUS;
  }

  public float getPosition(int i){
    float j = 0.0f;
    if(i == 0 || i == 1)
       j = position[i];
    return j;
  }
  public int getRadius(){
      return RADIUS;
    }

  public void randomizePosition(){
    position[POSITIONX] = ceil(random(MIN,MAXX))*RADIUS;
    position[POSITIONY] = ceil(random(MIN,MAXY))*RADIUS;
  }

  public void printObstacle(){
    strokeWeight(0);
    ellipse(position[POSITIONX], position[POSITIONY], RADIUS, RADIUS );
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

  public boolean mouseColision(float endPos[]){
      magnitudeVector = sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONY] - position[POSITIONY],2));
      return magnitudeVector < (radius/2);
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
