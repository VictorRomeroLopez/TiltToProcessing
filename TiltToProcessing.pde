//Zona de variables
final int POSITIONX = 0;
final int POSITIONY = 1;
final int NUM_ENEMIES = 3;
final int NUM_OBSTACLES = 3;
final int SPEED = 10;
int enemyGenerationSpeed = 15;
boolean colisionObstacle;
int i = 0;
int j = 0;
float mousePointer[] = {0,0};
Enemy enemies[] = new Enemy[NUM_ENEMIES];
Obstacle obstacles[] = new Obstacle[NUM_OBSTACLES];
Player player;

//Zona de setup
void setup()
{
  //Pantalla complerta
  fullScreen();
  player = new Player();
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i] = new Obstacle();
  }
  generateObstacles();
}

//Zona de draw
void draw(){
  //Background blanc
  background(255);
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

void mousePressed(){
  println(' ');
  println(player.position);
  println(' ');
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
