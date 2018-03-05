final int POSITIONX = 0;
final int POSITIONY = 1;
final int NUM_ENEMIES = 40;
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

boolean inputKeyUp;
boolean inputKeyDown;
boolean inputKeyRight;
boolean inputKeyLeft;

int i = 0;
int j = 0;
float mousePointer[] = {0,0};
Enemy enemies[] = new Enemy[NUM_ENEMIES];
Obstacle obstacles[] = new Obstacle[NUM_OBSTACLES];
Player player;
//variables per la creació de la sortida
String EXITMESSAGE = "EXIT";
float sortidaXY[] = {0,0};

final int RADIUS = 100;
//VARIABLES PER LA SELECCIO DE CONTROLS
float titleXY[] = {0.0f,0.0f};
//Zona de setup
void setup()
{
  //Pantalla complerta
  fullScreen();
  mainMenu = false;
  gameEnd = false;
  keyboard = true;
  player = new Player();
  //generació del primer punt del triangle que serà la sortida
  inputKeyUp = false;
  inputKeyDown = false;
  inputKeyRight = false;
  inputKeyLeft = false;

  titleXY[POSITIONX] = width/2;
  titleXY[POSITIONY] = height/2;
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i] = new Obstacle();
  }
  generateObstacles();
  generateExit();
}

//Zona de draw
void draw(){
  //Background blanc
  background(255);
  if(mainMenu){
    theMainMenu();
  }
  else if (!mainMenu && !gameEnd){
  //Obtenim la possició del mouse
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
    printExit();
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
      enemies[k].moveTowards(player.position, ceil(random(1,SPEED-1)));
    //passa alguna cosa si els enemics toquen al player
    if(enemies[k].colision(player.position, player.radius)){
      exit();
      // fill(255);
      // textSize(TEXTSIZEAA1);
      // fill(0);
      // text("YOU LOST", titleXY[POSITIONX]-TEXTSIZEAA1*2.5, titleXY[POSITIONY]);
    }
  }
}
  else{
    fill(0);
    textSize(TEXTSIZEAA1);
    text("YOU WON", titleXY[POSITIONX]-TEXTSIZEAA1*2.5, titleXY[POSITIONY]);
  }
}
void generateExit(){
  char x = 'x';
  char y = 'y';
  sortidaXY[POSITIONX] = random(RADIUS, width-RADIUS);
  sortidaXY[POSITIONY] = random(RADIUS, height-RADIUS);
  for(int i = 0; i<obstacles.length; i++){
    //NO VAN ELS WHILES, TOT I SER FALSE ENTRA IGUAL
    //CADA COP QUE CANVIA LA X O LA Y HEM DE SETEAR LA I A 0 UN ALTRE COP
    while ((sortidaXY[POSITIONX] <= obstacles[i].getPosition(POSITIONX)+RADIUS*2) && (sortidaXY[POSITIONX] >= obstacles[i].getPosition(POSITIONX)-RADIUS*2)){
      sortidaXY[POSITIONX] = random(RADIUS, width-RADIUS);
    }
     // println(x,i,sortidaXY[POSITIONX], obstacles[i].getPosition(POSITIONX));
     // println(x,i,obstacles[i].getPosition(POSITIONX)+RADIUS*2, obstacles[i].getPosition(POSITIONX)-RADIUS*2);
     // println(x,i,((sortidaXY[POSITIONX] <= obstacles[i].getPosition(POSITIONX)+RADIUS*2) && (sortidaXY[POSITIONX] >= obstacles[i].getPosition(POSITIONX)-RADIUS*2)));
    while ((sortidaXY[POSITIONY] <= obstacles[i].getPosition(POSITIONY)+RADIUS*2) && (sortidaXY[POSITIONY] >= obstacles[i].getPosition(POSITIONY)-RADIUS*2)){
      sortidaXY[POSITIONY] = random(RADIUS, height-RADIUS);
    }
     // println(y,i,sortidaXY[POSITIONY], obstacles[i].getPosition(POSITIONY));
     // println(y,i,obstacles[i].getPosition(POSITIONY)+RADIUS*2, obstacles[i].getPosition(POSITIONY)-RADIUS*2);
     // println(y,i, ((sortidaXY[POSITIONY] <= obstacles[i].getPosition(POSITIONY)+RADIUS*2) && (sortidaXY[POSITIONY] >= obstacles[i].getPosition(POSITIONY)-RADIUS*2)));
  }
}
void printExit(){
  //println(x1,y1,x1+(TRIANGLEAREA/2),y1,x1+(TRIANGLEAREA/4),y1-(TRIANGLEAREA/2));

  //generem un triangle equilater
  fill(233,200,0);
  ellipse(sortidaXY[POSITIONX],sortidaXY[POSITIONY],100,100);
  fill(0);
  textSize(TEXTSIZEEXIT);
  text(EXITMESSAGE,sortidaXY[POSITIONX]-TEXTSIZEEXIT,sortidaXY[POSITIONY]-50);
}
void mousePressed(){
  // println(' ');
  // println(player.position);
  // println(' ');
  if(!player.mouseColision(mousePointer))
    player.moveTowards(mousePointer, SPEED*10);
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
      if(obstacles[i].getPosition(POSITIONX) <= (obstacles[counter-1].getPosition(POSITIONX))+RADIUS*2 && (obstacles[i].getPosition(POSITIONX) >= (obstacles[counter-1].getPosition(POSITIONX))-RADIUS*2) && obstacles[i].getPosition(POSITIONY) <= (obstacles[counter-1].getPosition(POSITIONY))+RADIUS*2 && (obstacles[i].getPosition(POSITIONY) >= (obstacles[counter-1].getPosition(POSITIONY))-RADIUS*2)){
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

  ellipse(titleXY[POSITIONX]/2,titleXY[POSITIONY]-TEXTSIZEEXIT,RADIUS,RADIUS);
  textSize(TEXTSIZEEXIT);
  text("KEYBOARD CONTROL",titleXY[POSITIONX]/2+RADIUS/2-TEXTSIZEEXIT*6,titleXY[POSITIONY]-RADIUS);
  ellipse(titleXY[POSITIONX]/2+titleXY[POSITIONX],titleXY[POSITIONY]-TEXTSIZEEXIT,RADIUS,RADIUS);
  text("MICE CONTROL",titleXY[POSITIONX]/2+titleXY[POSITIONX]-RADIUS/3-TEXTSIZEEXIT*2,titleXY[POSITIONY]-RADIUS);
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
