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

final int NUM_ENEMIES = 10;
final int NUM_OBSTACLES = 10;
final int SPEED = 10;
final int TEXTSIZEAA1 = 200;
final int TEXTSIZEEXIT = 32;
final int PLAYER_SPAWN_AREA = 25;
final float ELIPSE_SIZE_PARTICLES = 15.0f;
final int NUMPARTICLES = 500;
int enemyGenerationSpeed = 15;
boolean colisionObstacle;
//variables de control del joc i dels menus
boolean mainMenu;
boolean gameEnd;
boolean miceControl;
boolean keyboardControl;
boolean keyboard;
boolean startAgain;
boolean dead;
//variables per controlar el moviment del jugador amb tecles
boolean inputKeyUp;
boolean inputKeyDown;
boolean inputKeyRight;
boolean inputKeyLeft;

boolean selectionKeyboardX;
boolean selectionKeyboardY;
boolean selectionMiceX;
boolean selectionMiceY;
int coloringKeyboard;
int coloringMice;

int i = 0;
int j = 0;
int l = 0;
int m = 0;
PVector mousePointer;
Enemy enemies[] = new Enemy[NUM_ENEMIES];
Particle particles[] = new Particle[NUMPARTICLES];
Obstacle obstacles[] = new Obstacle[NUM_OBSTACLES];
Player player;
Exit exit;
//variables per la creaci\u00f3 de la sortida
String EXITMESSAGE = "EXIT";

final int RADIUS = 100;

//VARIABLES PER LA SELECCIO DE CONTROLS
PVector titleXY;

//Zona de setup
public void setup()
{
  //Pantalla complerta
  
  mainMenu = true;
  gameEnd = false;
  keyboard = false;
  player = new Player();
  //generaci\u00f3 del primer punt del triangle que ser\u00e0 la sortida
  inputKeyUp = false;
  inputKeyDown = false;
  dead = false;
  inputKeyRight = false;
  inputKeyLeft = false;
  startAgain = false;
  coloringMice = 0;
  coloringKeyboard = 0;

  titleXY = new PVector(width/2, height/2);
  exit = new Exit();
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i] = new Obstacle();
  }
  generateObstacles();
  for(int i=0; i<obstacles.length; i++){
    if(!exit.generateExit(player, obstacles[i], obstacles.length)){
      i = 0;
    }
  }
  for(int i = 0; i<NUMPARTICLES; i++){
    particles[i] = new Particle();
  }
}

//Zona de draw
public void draw(){
  //Background blanc
  background(255);
  mousePointer = new PVector(mouseX, mouseY);
  if(mainMenu){
    controlSelection();
    theMainMenu();

  }
  else if (!mainMenu && !gameEnd){
  //Obtenim la possici\u00f3 del mouse
  //Set de la variable a false
  colisionObstacle = false;
  //Imprim tots els obstacles
  fill(24,240,230);
  printObstacles();
  //fem apareixer el jugador
  player.pop();
  //moviment del jugador
  if (keyboard){
    player.movementWithKeyboard(inputKeyUp ,inputKeyDown, inputKeyLeft, inputKeyRight,SPEED);
    if(player.position.x >= width){
      player.position.x = width;
    }
    if(player.position.x <= 0){
      player.position.x = 0;
    }
    if(player.position.y >= height){
      player.position.y = height;
    }
    if(player.position.y <= 0){
      player.position.y = 0;
    }
  }
    dead = false;
  for(int i = 0; i < obstacles.length && !colisionObstacle ; i++){
    if(player.colision(obstacles[i].position, obstacles[i].getRadius())){
      colisionObstacle = true;
      player.colisionMovement(obstacles[i].position, obstacles[i].getRadius(), SPEED);
    }
  }
 if(!keyboard){
  if (!colisionObstacle && !player.mouseColision(mousePointer)){
    player.moveTowards(mousePointer, SPEED);
  }else if(!colisionObstacle){
    player.position.x = mouseX;
    player.position.y = mouseY;
  }
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
  if (j >= enemies.length){
    exit.printExit();
    if(player.colision(exit.position,exit.getRadius()))
      gameEnd = true;
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
    //genera una velocitat diferent cada cop que s executa
      enemies[k].moveTowards(player.position, enemies[k].speed);
    //passa alguna cosa si els enemics toquen al player
    if(enemies[k].colision(player.position, player.radius)){
      gameEnd = true;
      dead = true;
    }
  }
  }
  else if (!mainMenu && gameEnd && dead){
    fill(0);
    textSize(TEXTSIZEAA1);
    text("YOU LOST", titleXY.x-TEXTSIZEAA1*2.5f, titleXY.y);
    if (startAgain)
      fill(200);
    else
      fill(0);
    ellipse(titleXY.x, titleXY.y+ TEXTSIZEAA1*2, RADIUS, RADIUS);
    textSize(TEXTSIZEEXIT);
    text("START AGAIN", titleXY.x - TEXTSIZEEXIT*2.5f, titleXY.y + TEXTSIZEAA1+TEXTSIZEAA1/2 );
    if(mousePointer.x <= titleXY.x+100 && mousePointer.x >= titleXY.x-100){
      startAgain = true;
    }
    if(mousePointer.y <= titleXY.y+ TEXTSIZEAA1*2+100 && mousePointer.y >= titleXY.y+ TEXTSIZEAA1*2-100){
      startAgain = true;
    }
    if(mousePointer.x > titleXY.x+100 || mousePointer.x < titleXY.x-100){
      startAgain = false;
    }
    if(mousePointer.y > titleXY.y+ TEXTSIZEAA1*2+100 || mousePointer.y < titleXY.y+ TEXTSIZEAA1*2-100){
      startAgain = false;
    }
  }
  else if (!mainMenu && gameEnd && !dead){
    fill(0);
    textSize(TEXTSIZEAA1);
    text("YOU WON", titleXY.x-TEXTSIZEAA1*2.5f, titleXY.y);
    if(l < particles.length){
      if(frameCount % 5 == 0){
        particles[m] = new Particle();
        l++;
        m++;
      }
    }
    for( int k = 0; k < m; k++){
      particles[k].velocity.x += particles[k].acceleration.x * particles[k].deltaT;
      particles[k].velocity.y += particles[k].acceleration.y * particles[k].deltaT;
      particles[k].location.x += particles[k].velocity.x * particles[k].deltaT;
      particles[k].location.y += particles[k].velocity.y * particles[k].deltaT;
      fill(random(255), random(255), random(255));
      ellipse(particles[k].location.x,particles[k].location.y,ELIPSE_SIZE_PARTICLES,ELIPSE_SIZE_PARTICLES);
      if(particles[k].location.y > height){
        particles[k] = new Particle();
      }
    }
    if (startAgain)
      fill(200);
    else
      fill(0);
    ellipse(titleXY.x, titleXY.y+ TEXTSIZEAA1*2, RADIUS, RADIUS);
    textSize(TEXTSIZEEXIT);
    text("START AGAIN", titleXY.x - TEXTSIZEEXIT*2.5f, titleXY.y + TEXTSIZEAA1+TEXTSIZEAA1/2 );
    if(mousePointer.x <= titleXY.x+100 && mousePointer.x >= titleXY.x-100){
      startAgain = true;
    }
    if(mousePointer.y <= titleXY.y+ TEXTSIZEAA1*2+100 && mousePointer.y >= titleXY.y+ TEXTSIZEAA1*2-100){
      startAgain = true;
    }
    if(mousePointer.x > titleXY.x+100 || mousePointer.x < titleXY.x-100){
      startAgain = false;
    }
    if(mousePointer.y > titleXY.y+ TEXTSIZEAA1*2+100 || mousePointer.y < titleXY.y+ TEXTSIZEAA1*2-100){
      startAgain = false;
    }
  }
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
      // if(obstacles[i].getPosition(POSITIONX) <= (obstacles[counter-1].getPosition(POSITIONX))+RADIUS*2 && (obstacles[i].getPosition(POSITIONX) >= (obstacles[counter-1].getPosition(POSITIONX))-RADIUS*2) && obstacles[i].getPosition(POSITIONY) <= (obstacles[counter-1].getPosition(POSITIONY))+RADIUS*2 && (obstacles[i].getPosition(POSITIONY) >= (obstacles[counter-1].getPosition(POSITIONY))-RADIUS*2)){
      if(obstacles[i].colision(obstacles[counter-1].position, 100)){
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
  text("AA1", titleXY.x-TEXTSIZEAA1, titleXY.y);

  fill(coloringKeyboard);
  ellipse(titleXY.x/2,titleXY.y-TEXTSIZEEXIT,RADIUS,RADIUS);
  textSize(TEXTSIZEEXIT);
  text("KEYBOARD CONTROL",titleXY.x/2+RADIUS/2-TEXTSIZEEXIT*6,titleXY.y-RADIUS);
  fill(coloringMice);
  ellipse(titleXY.x/2+titleXY.x,titleXY.y-TEXTSIZEEXIT,RADIUS,RADIUS);
  text("MICE CONTROL",titleXY.x/2+titleXY.x-RADIUS/3-TEXTSIZEEXIT*2,titleXY.y-RADIUS);
}
public void mousePressed(){
  if (selectionKeyboardX && selectionKeyboardY){
    keyboard = true;
    mainMenu = false;
  }
  else if (selectionMiceX && selectionMiceY){
    keyboard = false;
    mainMenu = false;
  }
  if (startAgain){
    mainMenu = false;
    startAgain = false;
    gameEnd = false;
    i = 0;
    j = 0;
    l = 0;
    m = 0;
    player.position.x = mouseX;
    player.position.y = mouseY;
    generateObstacles();
  }
  if(!player.mouseColision(mousePointer) && !mainMenu)
    player.moveTowards(mousePointer, SPEED*10);
}
public void controlSelection(){
 if (selectionKeyboardX && selectionKeyboardY){
   coloringKeyboard = 200;
 }
 else{
   coloringKeyboard = 0;
 }

 if (selectionMiceX && selectionMiceY){
   coloringMice = 200;
 }
 else{
   coloringMice = 0;
 }
 //seleccio de tecalt
  if(mousePointer.x<= titleXY.x/2+RADIUS && mousePointer.x>= titleXY.x/2-RADIUS){
    selectionKeyboardX = true;
  }
  if(mousePointer.y<= titleXY.y +RADIUS -TEXTSIZEEXIT&& mousePointer.y>= titleXY.y-RADIUS -TEXTSIZEEXIT){
    selectionKeyboardY = true;
  }
  if(mousePointer.x> titleXY.x/2+RADIUS || mousePointer.x< titleXY.x/2-RADIUS){
    selectionKeyboardX = false;
  }
  if(mousePointer.y > titleXY.y +RADIUS -TEXTSIZEEXIT || mousePointer.y< titleXY.y-RADIUS -TEXTSIZEEXIT){
    selectionKeyboardY = false;
  }
  //seleccio de ratoli
  if(mousePointer.x<= titleXY.x/2+titleXY.x+RADIUS && mousePointer.x>= titleXY.x/2+titleXY.x-RADIUS){
    selectionMiceX = true;
  }
  if(mousePointer.y<= titleXY.y +RADIUS -TEXTSIZEEXIT&& mousePointer.y>= titleXY.y-RADIUS -TEXTSIZEEXIT){
    selectionMiceY = true;
  }
  if(mousePointer.x> titleXY.x/2+titleXY.x+RADIUS || mousePointer.x< titleXY.x/2+titleXY.x-RADIUS){
    selectionMiceX = false;
  }
  if(mousePointer.y > titleXY.y +RADIUS -TEXTSIZEEXIT || mousePointer.y< titleXY.y-RADIUS -TEXTSIZEEXIT){
    selectionMiceY = false;
  }
}
public void keyPressed(){
  if (key == 'w' || key == 'W' && !inputKeyUp)
    inputKeyUp = true;
  else if (key == 's' || key == 'S' && !inputKeyDown)
    inputKeyDown = true;
  else if (key == 'a' || key == 'A' && !inputKeyLeft)
    inputKeyLeft = true;
  else if (key == 'd' || key == 'D' && !inputKeyRight)
    inputKeyRight = true;
}
public void keyReleased(){
  if (key == 'w' || key == 'W' && inputKeyUp)
    inputKeyUp =  false;
  else if (key == 's' || key == 'S' && inputKeyDown)
    inputKeyDown =  false;
  else if (key == 'a' || key == 'A' && inputKeyLeft)
    inputKeyLeft =  false;
  else if (key == 'd' || key == 'D' && inputKeyRight)
    inputKeyRight = false;
}
class Enemy extends MovingObject{
  Enemy(){
    position = new PVector(ceil(random(0,width)), ceil(random(0,height)));
    speed = ceil(random(SPEED/2,SPEED-2));
  }

  public void randomize(){
    position = new PVector(ceil(random(0,width)), ceil(random(0,height)));
  }

  public void pop(){
    fill(255,0,0);
    strokeWeight(0);
    ellipse(position.x, position.y, radius, radius);
  }
}
class Exit {
  final int RADIUS = 100;
  boolean succesfullyDone;
  PVector position;
  float magnitudeVector;

  Exit(){
    position = new PVector(random(RADIUS, width-RADIUS), random(RADIUS, height-RADIUS));
  }

  public int getRadius(){
      return RADIUS;
  }

  public boolean generateExit(Player player, Obstacle obstacles, int lengthObstacles){
      //NO VAN ELS WHILES, TOT I SER FALSE ENTRA IGUAL
      //CADA COP QUE CANVIA LA X O LA Y HEM DE SETEAR LA I A 0 UN ALTRE COP
      if (colision(obstacles.position, obstacles.getRadius()) || colision(player.position, player.getRadius())){
        position = new PVector(random(RADIUS, width-RADIUS), random(RADIUS, height-RADIUS));
        return false;
      }
      return true;
  }

  public void printExit(){
    //println(x1,y1,x1+(TRIANGLEAREA/2),y1,x1+(TRIANGLEAREA/4),y1-(TRIANGLEAREA/2));

    //generem un triangle equilater
    fill(233,200,0);
    ellipse(position.x,position.y,100,100);
    fill(0);
    textSize(TEXTSIZEEXIT);
    text(EXITMESSAGE,position.x-TEXTSIZEEXIT,position.y-50);
  }

  public boolean colision(PVector endPos, int endRadius){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
      return magnitudeVector < (endRadius * 0.5f + RADIUS * 0.5f);
  }
}
class MovingObject{
  PVector position;
  int radius = 20;
  public float magnitudeVector;
  int speed;

  public int getRadius(){
    return radius;
  }

  public void moveTowards(PVector endPos, int speed){
    PVector vector = new PVector(0,0);
    vector = new PVector(endPos.x - position.x, endPos.y - position.y);
    position.x += (vector.x/sqrt(pow(vector.x,2)+pow(vector.y,2)))*speed;
    position.y += (vector.y/sqrt(pow(vector.x,2)+pow(vector.y,2)))*speed;
  }

  public void movementWithKeyboard(boolean keyInputUp,boolean keyInputDown,boolean keyInputLeft,boolean keyInputRigth, int speed){
    float vectorKX = 0.0f;
    float vectorKY = 0.0f;
    if(keyInputUp && keyInputLeft){
        vectorKX = -0.5f;
        vectorKY = -0.5f;
        }
    else if(keyInputUp && keyInputRigth){
        vectorKX = 0.5f;
        vectorKY = -0.5f;
        }
    else if(keyInputDown && keyInputLeft){
        vectorKX = -0.5f;
        vectorKY = 0.5f;
        }
    else if(keyInputDown && keyInputRigth){
        vectorKX = 0.5f;
        vectorKY = 0.5f;
        }
    else if(keyInputUp){
        vectorKX = 0.0f;
        vectorKY = -1.0f;
      }
    else if(keyInputLeft){
        vectorKX = -1.0f;
        vectorKY = 0.0f;
      }
    else if(keyInputDown){
        vectorKX = 0.0f;
        vectorKY = 1.0f;
      }
    else if(keyInputRigth){
        vectorKX = 1.0f;
        vectorKY = 0.0f;
      }


    position.x += vectorKX*speed;
    position.y += vectorKY*speed;
  }

  public boolean colision(PVector endPos, int endRadius){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
      return magnitudeVector < (endRadius * 0.5f + radius * 0.5f);
  }

  public void colisionMovement(PVector colisionPos, int radiusObstacle, int speed){
    PVector v = new PVector(position.x - colisionPos.x, position.y - colisionPos.y);
    v.setMag(radiusObstacle/2 + radius/2 + 1);
    position.x = v.x + colisionPos.x;
    position.y = v.y + colisionPos.y;
  }
}
class Obstacle{
  final int RADIUS = 100;
  final int MIN = 1;
  final int MAXX = ceil(width/RADIUS)-1;
  final int MAXY = ceil(height/RADIUS)-1;
  PVector position;
  public float magnitudeVector;

  Obstacle(){
    position = new PVector(random(MIN,MAXX) * RADIUS, random(MIN,MAXY) * RADIUS);
  }

  public PVector getPosition(){
    return position;
  }

  public int getRadius(){
      return RADIUS;
  }

  public void randomizePosition(){
    position.x = (random(MIN,MAXX))*RADIUS;
    position.y = (random(MIN,MAXY))*RADIUS;
  }

  public void printObstacle(){
    strokeWeight(0);
    ellipse(position.x, position.y, RADIUS, RADIUS );
  }

  public boolean colision(PVector endPos, int endRadius){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
      return magnitudeVector < (endRadius * 0.5f + RADIUS * 0.5f);
  }
}
class Particle{
  PVector velocity;
  PVector acceleration;
  PVector location;
  float weight;
  float deltaT;

  Particle(){

    //MASSA
    weight = 1.0f;

    acceleration = new PVector(0.0f, 100/weight);

    location = new PVector(random(width), random(height));
    //VECTOR VELOCITAT
    velocity = new PVector(random(-40, 40), -random(100, 150));
    //TEMPS
    deltaT = 0.05f;
  }
}
class Player extends MovingObject{
  Player(){
    position = new PVector(width/2, height/2);
  }

  public void pop(){
    fill(0,255,0);
    strokeWeight(0);
    ellipse(position.x, position.y, radius, radius);
  }

  public boolean mouseColision(PVector endPos){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
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
