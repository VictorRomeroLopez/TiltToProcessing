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
void setup()
{
  //Pantalla complerta
  fullScreen();
  //fem set de la X maxima i de la Y maxima a la que es podra generar un valor
  MAXX = ceil(width/BS)-1;
  MAXY = ceil(height/BS)-1;
  player = new Player();
  generateObstacle();
}

//Zona de draw
void draw(){
  //Background blanc
  background(255);
  //Obtenim la possició del mouse
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
  //aparició dels enemics a l'escenari i el persegueixen
  for( int k = 0; k<j; k++){
    enemies[k].pop();
    enemies[k].moveTowards(player.position, ceil(random(1,SPEED-1)));
    //passa alguna cosa si els enemics toquen al player
    if(enemies[k].colision(player.position, player.radius)){
      exit();
    }
  }
}

void mousePressed(){
  if(!player.mouseColision(mousePointer))
    player.moveTowards(mousePointer, SPEED*10);
}

void generateObstacle(){
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

void printObstacle(){
  fill(23,240,230);
  for(int i=0; i< obstacleX_value.length; i++){
    ellipse(obstacleX_value[i] * BS, obstacleY_value[i] * BS, BS, BS );
  }
}
