final int POSITIONX = 0;
final int POSITIONY = 1;
final int NUM_ENEMIES = 1;
final int NUM_OBSTACLES = 10;
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
float mousePointer[] = {0,0};
Enemy enemies[] = new Enemy[NUM_ENEMIES];
Obstacle obstacles[] = new Obstacle[NUM_OBSTACLES];
Player player;
Exit exit;
//variables per la creació de la sortida
String EXITMESSAGE = "EXIT";

final int RADIUS = 100;

//VARIABLES PER LA SELECCIO DE CONTROLS
float titleXY[] = {0.0f,0.0f};
//Zona de setup
void setup()
{
  //Pantalla complerta
  fullScreen();
  mainMenu = true;
  gameEnd = false;
  keyboard = false;
  player = new Player();
  //generació del primer punt del triangle que serà la sortida
  inputKeyUp = false;
  inputKeyDown = false;
  dead = false;
  inputKeyRight = false;
  inputKeyLeft = false;
  startAgain = false;
  coloringMice = 0;
  coloringKeyboard = 0;

  titleXY[POSITIONX] = width/2;
  titleXY[POSITIONY] = height/2;
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
}

//Zona de draw
void draw(){
  //Background blanc
  background(255);
  mousePointer[0] = mouseX;
  mousePointer[1] = mouseY;
  if(mainMenu){
    controlSelection();
    theMainMenu();

  }
  else if (!mainMenu && !gameEnd){
  //Obtenim la possició del mouse
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
    if(player.position[POSITIONX] >= width){
      player.position[POSITIONX] = width;
    }
    if(player.position[POSITIONX] <= 0){
      player.position[POSITIONX] = 0;
    }
    if(player.position[POSITIONY] >= height){
      player.position[POSITIONY] = height;
    }
    if(player.position[POSITIONY] <= 0){
      player.position[POSITIONY] = 0;
    }
  }
  if(player.colision(exit.position,exit.getRadius()))
    gameEnd = true;
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
    player.position[POSITIONX] = mouseX;
    player.position[POSITIONY] = mouseY;
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
  }
  //aparició dels enemics a l'escenari i el persegueixen
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
    text("YOU LOST", titleXY[POSITIONX]-TEXTSIZEAA1*2.5, titleXY[POSITIONY]);
    if (startAgain)
      fill(200);
    else
      fill(0);
    ellipse(titleXY[POSITIONX], titleXY[POSITIONY]+ TEXTSIZEAA1*2, RADIUS, RADIUS);
    textSize(TEXTSIZEEXIT);
    text("START AGAIN", titleXY[POSITIONX] - TEXTSIZEEXIT*2.5, titleXY[POSITIONY] + TEXTSIZEAA1+TEXTSIZEAA1/2 );
    if(mousePointer[POSITIONX] <= titleXY[POSITIONX]+100 && mousePointer[POSITIONX] >= titleXY[POSITIONX]-100){
      startAgain = true;
    }
    if(mousePointer[POSITIONY] <= titleXY[POSITIONY]+ TEXTSIZEAA1*2+100 && mousePointer[POSITIONY] >= titleXY[POSITIONY]+ TEXTSIZEAA1*2-100){
      startAgain = true;
    }
    if(mousePointer[POSITIONX] > titleXY[POSITIONX]+100 || mousePointer[POSITIONX] < titleXY[POSITIONX]-100){
      startAgain = false;
    }
    if(mousePointer[POSITIONY] > titleXY[POSITIONY]+ TEXTSIZEAA1*2+100 || mousePointer[POSITIONY] < titleXY[POSITIONY]+ TEXTSIZEAA1*2-100){
      startAgain = false;
    }
  }
  else if (!mainMenu && gameEnd && !dead){
    fill(0);
    textSize(TEXTSIZEAA1);
    text("YOU WON", titleXY[POSITIONX]-TEXTSIZEAA1*2.5, titleXY[POSITIONY]);
    if (startAgain)
      fill(200);
    else
      fill(0);
    ellipse(titleXY[POSITIONX], titleXY[POSITIONY]+ TEXTSIZEAA1*2, RADIUS, RADIUS);
    textSize(TEXTSIZEEXIT);
    text("START AGAIN", titleXY[POSITIONX] - TEXTSIZEEXIT*2.5, titleXY[POSITIONY] + TEXTSIZEAA1+TEXTSIZEAA1/2 );
    if(mousePointer[POSITIONX] <= titleXY[POSITIONX]+100 && mousePointer[POSITIONX] >= titleXY[POSITIONX]-100){
      startAgain = true;
    }
    if(mousePointer[POSITIONY] <= titleXY[POSITIONY]+ TEXTSIZEAA1*2+100 && mousePointer[POSITIONY] >= titleXY[POSITIONY]+ TEXTSIZEAA1*2-100){
      startAgain = true;
    }
    if(mousePointer[POSITIONX] > titleXY[POSITIONX]+100 || mousePointer[POSITIONX] < titleXY[POSITIONX]-100){
      startAgain = false;
    }
    if(mousePointer[POSITIONY] > titleXY[POSITIONY]+ TEXTSIZEAA1*2+100 || mousePointer[POSITIONY] < titleXY[POSITIONY]+ TEXTSIZEAA1*2-100){
      startAgain = false;
    }
  }
}


void generateObstacles(){
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
void printObstacles(){
  for(int i = 0; i< obstacles.length; i++){
    obstacles[i].printObstacle();
  }
}
void theMainMenu(){
  fill(0);
  textSize(TEXTSIZEAA1);
  text("AA1", titleXY[POSITIONX]-TEXTSIZEAA1, titleXY[POSITIONY]);

  fill(coloringKeyboard);
  ellipse(titleXY[POSITIONX]/2,titleXY[POSITIONY]-TEXTSIZEEXIT,RADIUS,RADIUS);
  textSize(TEXTSIZEEXIT);
  text("KEYBOARD CONTROL",titleXY[POSITIONX]/2+RADIUS/2-TEXTSIZEEXIT*6,titleXY[POSITIONY]-RADIUS);
  fill(coloringMice);
  ellipse(titleXY[POSITIONX]/2+titleXY[POSITIONX],titleXY[POSITIONY]-TEXTSIZEEXIT,RADIUS,RADIUS);
  text("MICE CONTROL",titleXY[POSITIONX]/2+titleXY[POSITIONX]-RADIUS/3-TEXTSIZEEXIT*2,titleXY[POSITIONY]-RADIUS);
}
void mousePressed(){
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
    gameEnd = false;

  }
  if(!player.mouseColision(mousePointer) && !mainMenu)
    player.moveTowards(mousePointer, SPEED*10);
}
void controlSelection(){
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
  if(mousePointer[POSITIONX]<= titleXY[POSITIONX]/2+RADIUS && mousePointer[POSITIONX]>= titleXY[POSITIONX]/2-RADIUS){
    selectionKeyboardX = true;
  }
  if(mousePointer[POSITIONY]<= titleXY[POSITIONY] +RADIUS -TEXTSIZEEXIT&& mousePointer[POSITIONY]>= titleXY[POSITIONY]-RADIUS -TEXTSIZEEXIT){
    selectionKeyboardY = true;
  }
  if(mousePointer[POSITIONX]> titleXY[POSITIONX]/2+RADIUS || mousePointer[POSITIONX]< titleXY[POSITIONX]/2-RADIUS){
    selectionKeyboardX = false;
  }
  if(mousePointer[POSITIONY] > titleXY[POSITIONY] +RADIUS -TEXTSIZEEXIT || mousePointer[POSITIONY]< titleXY[POSITIONY]-RADIUS -TEXTSIZEEXIT){
    selectionKeyboardY = false;
  }
  //seleccio de ratoli
  if(mousePointer[POSITIONX]<= titleXY[POSITIONX]/2+titleXY[POSITIONX]+RADIUS && mousePointer[POSITIONX]>= titleXY[POSITIONX]/2+titleXY[POSITIONX]-RADIUS){
    selectionMiceX = true;
  }
  if(mousePointer[POSITIONY]<= titleXY[POSITIONY] +RADIUS -TEXTSIZEEXIT&& mousePointer[POSITIONY]>= titleXY[POSITIONY]-RADIUS -TEXTSIZEEXIT){
    selectionMiceY = true;
  }
  if(mousePointer[POSITIONX]> titleXY[POSITIONX]/2+titleXY[POSITIONX]+RADIUS || mousePointer[POSITIONX]< titleXY[POSITIONX]/2+titleXY[POSITIONX]-RADIUS){
    selectionMiceX = false;
  }
  if(mousePointer[POSITIONY] > titleXY[POSITIONY] +RADIUS -TEXTSIZEEXIT || mousePointer[POSITIONY]< titleXY[POSITIONY]-RADIUS -TEXTSIZEEXIT){
    selectionMiceY = false;
  }
}
void keyPressed(){
  if (key == 'w' || key == 'W' && !inputKeyUp)
    inputKeyUp = true;
  else if (key == 's' || key == 'S' && !inputKeyDown)
    inputKeyDown = true;
  else if (key == 'a' || key == 'A' && !inputKeyLeft)
    inputKeyLeft = true;
  else if (key == 'd' || key == 'D' && !inputKeyRight)
    inputKeyRight = true;
}
void keyReleased(){
  if (key == 'w' || key == 'W' && inputKeyUp)
    inputKeyUp =  false;
  else if (key == 's' || key == 'S' && inputKeyDown)
    inputKeyDown =  false;
  else if (key == 'a' || key == 'A' && inputKeyLeft)
    inputKeyLeft =  false;
  else if (key == 'd' || key == 'D' && inputKeyRight)
    inputKeyRight = false;
}
