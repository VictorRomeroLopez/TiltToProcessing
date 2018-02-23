//Zona de variables
final int POSITIONX = 0;
final int POSITIONY = 1;
//Variables per la creacio del personatge i enemics
int playerPosition[]={0,0};
// int playerY;
final int playerRadiusX = 20;
final int playerRadiusY = 20;
int mousePosition[] = {0,0};
int enemy1Position[] = {0,0};
int enemy2Position[] = {0,0};
int enemy3Position[] = {0,0};
//Variable estatica per controlar la velocitat del joc
final int speed = 5;
final int enemy1Speed = ceil(speed*0.8);
final int enemy2Speed = ceil(speed*0.6);
final int enemy3Speed = ceil(speed*0.4);
//variables per calcular el vector de moviment
int vectorX;
int vectorY;
int normalizedVectorX;
int normalizedVectorY;
//Zona de setup
void setup()
{
  //Pantalla complerta
  fullScreen();
  //Modificar ample del pinzell
  strokeWeight(5);
  //Posicio inicial del personatge principal
  playerPosition[POSITIONX] = width/2;
  playerPosition[POSITIONY] = height/2;
  //Posicio inicial dels enemics
  enemy1Position[POSITIONX] = 0;
  enemy1Position[POSITIONY] = 1;
  enemy2Position[POSITIONX] = width;
  enemy2Position[POSITIONY] = 1;
  enemy3Position[POSITIONX] = width;
  enemy3Position[POSITIONY] = height;
}

//Zona de draw
void draw(){
  //Obtenim la possició del mouse
  mousePosition[POSITIONX] = mouseX;
  mousePosition[POSITIONY] = mouseY;
  //Background blanc
  background(255);
  //Creem el personatge a una posició i el pintem de color verd
  fill(0,255,0);
  ellipse(playerPosition[POSITIONX], playerPosition[POSITIONY], playerRadiusX, playerRadiusY);
  //Creem  els enemics a les seves posiciós i els pintem de color vermell
  fill(255,0,0);
  ellipse(enemy1Position[POSITIONX], enemy1Position[POSITIONY], playerRadiusX, playerRadiusY);
  ellipse(enemy2Position[POSITIONX], enemy2Position[POSITIONY], playerRadiusX, playerRadiusY);
  ellipse(enemy3Position[POSITIONX], enemy3Position[POSITIONY], playerRadiusX, playerRadiusY);
  //Moviment dels elements de joc
  movement(playerPosition, mousePosition, speed);
  movement(enemy1Position, playerPosition, enemy1Speed);
  movement(enemy2Position, playerPosition, enemy2Speed);
  movement(enemy3Position, playerPosition, enemy3Speed);
}

void mousePressed(){
  //Multiplicant la velocitat per un nombre fem que es crei un efecte similar al del dash
  movement(playerPosition, mousePosition, speed*5);
}

void movement(int startPoint[], int endPoint[], int speed){
    vectorX = endPoint[POSITIONX] - startPoint[POSITIONX];
    vectorY = endPoint[POSITIONY] - startPoint[POSITIONY];
    normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
    normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
    startPoint[POSITIONX] += normalizedVectorX;
    startPoint[POSITIONY] += normalizedVectorY;
}
