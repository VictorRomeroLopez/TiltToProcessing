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
//variables per la creació de la sortida
String EXITMESSAGE = "EXIT";

final int RADIUS = 100;

//VARIABLES PER LA SELECCIO DE CONTROLS
PVector titleXY;

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
void draw(){
  //Background blanc
  background(255);
  mousePointer = new PVector(mouseX, mouseY);
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
    text("YOU LOST", titleXY.x-TEXTSIZEAA1*2.5, titleXY.y);
    if (startAgain)
      fill(200);
    else
      fill(0);
    ellipse(titleXY.x, titleXY.y+ TEXTSIZEAA1*2, RADIUS, RADIUS);
    textSize(TEXTSIZEEXIT);
    text("START AGAIN", titleXY.x - TEXTSIZEEXIT*2.5, titleXY.y + TEXTSIZEAA1+TEXTSIZEAA1/2 );
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
    text("YOU WON", titleXY.x-TEXTSIZEAA1*2.5, titleXY.y);
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
    text("START AGAIN", titleXY.x - TEXTSIZEEXIT*2.5, titleXY.y + TEXTSIZEAA1+TEXTSIZEAA1/2 );
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
  text("AA1", titleXY.x-TEXTSIZEAA1, titleXY.y);

  fill(coloringKeyboard);
  ellipse(titleXY.x/2,titleXY.y-TEXTSIZEEXIT,RADIUS,RADIUS);
  textSize(TEXTSIZEEXIT);
  text("KEYBOARD CONTROL",titleXY.x/2+RADIUS/2-TEXTSIZEEXIT*6,titleXY.y-RADIUS);
  fill(coloringMice);
  ellipse(titleXY.x/2+titleXY.x,titleXY.y-TEXTSIZEEXIT,RADIUS,RADIUS);
  text("MICE CONTROL",titleXY.x/2+titleXY.x-RADIUS/3-TEXTSIZEEXIT*2,titleXY.y-RADIUS);
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
