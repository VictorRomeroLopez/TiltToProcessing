//Zona de variables
final int POSITIONX = 0;
final int POSITIONY = 1;
final int NUM_ENEMIES = 3;
final int NUM_OBSTACLES = 3;
final int SPEED = 10;
final int TEXTSIZEAA1 = 200;
final int TEXTSIZEEXIT = 32;
int enemyGenerationSpeed = 15;
boolean colisionObstacle;
//variables de control del joc i dels menus
boolean mainMenu;
boolean gameEnd;

int i = 0;
int j = 0;
float mousePointer[] = {0,0};
Enemy enemies[] = new Enemy[NUM_ENEMIES];
Obstacle obstacles[] = new Obstacle[NUM_OBSTACLES];
Player player;
//variables per la creació de la sortida
String EXITMESSAGE = "EXIT";
float sortidaX1;
float sortidaY1;
final int TRIANGLEAREA = 200;
//VARIABLES PER LA SELECCIO DE CONTROLS
float titleX1 ;
float titleY1;
//Zona de setup
void setup()
{
  //Pantalla complerta
  fullScreen();
  mainMenu = false;
  gameEnd = true;
  player = new Player();
  //generació del primer punt del triangle que serà la sortida
  sortidaX1 = random(300, height-300);
  sortidaY1 = sortidaX1+50;

  titleX1 = width/2;
  titleY1 = height/2;
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i] = new Obstacle();
  }
  generateObstacles();
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
      enemies[i].pop();
      i++;
      j++;
    }
  }
  if (j >= enemies.length){
      generateExit();
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
    text("YOU WON", titleX1-TEXTSIZEAA1*2.5, titleY1);
  }
}



void generateExit(){
  //println(x1,y1,x1+(TRIANGLEAREA/2),y1,x1+(TRIANGLEAREA/4),y1-(TRIANGLEAREA/2));

  //generem un triangle equilater
  fill(233,200,0);
  triangle(sortidaX1,sortidaY1,sortidaX1+(TRIANGLEAREA/2),sortidaY1,sortidaX1+(TRIANGLEAREA/4),sortidaY1-(TRIANGLEAREA/2));
  fill(0);
  textSize(TEXTSIZEEXIT);
  text(EXITMESSAGE,sortidaX1+TRIANGLEAREA/4-TEXTSIZEEXIT,sortidaY1-TRIANGLEAREA/2);
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
      if(obstacles[i].getPosition(POSITIONX) == obstacles[counter-1].getPosition(POSITIONX) && obstacles[i].getPosition(POSITIONY) == obstacles[counter-1].getPosition(POSITIONY)){
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
  text("AA1", titleX1-TEXTSIZEAA1, titleY1);


  triangle(titleX1/2,titleY1,titleX1/2+(TRIANGLEAREA/2),titleY1,titleX1/2+(TRIANGLEAREA/4),titleY1-(TRIANGLEAREA/2));
  textSize(TEXTSIZEEXIT);
  text("KEYBOARD CONTROL",titleX1/2+TRIANGLEAREA/4-TEXTSIZEEXIT*4,titleY1-TRIANGLEAREA/2);
  triangle(titleX1/2+titleX1,titleY1,titleX1/2+(TRIANGLEAREA/2)+titleX1,titleY1,titleX1/2+(TRIANGLEAREA/4)+titleX1,titleY1-(TRIANGLEAREA/2));
  text("MICE CONTROL",titleX1/2+titleX1+TRIANGLEAREA/4-TEXTSIZEEXIT*4,titleY1-TRIANGLEAREA/2);
}
