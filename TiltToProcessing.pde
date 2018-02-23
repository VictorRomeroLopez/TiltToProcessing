//Zona de variables
final int POSITIONX = 0;
final int POSITIONY = 1;
final int ELLIPSERADIUS = 100;
final int NUMOBSTACLES = 3;
//Variables per la creacio del personatge i enemics
int playerPosition[]={0,0};
// int playerY;
final int min = 1;
final int maxX = ceil(height/100) - 3;
final int maxY = ceil(width/100) - 1;
final int playerRadiusX = 20;
final int playerRadiusY = 20;
final int obstacleRadiusX = 100;
final int obstacleTRadiusY = 100;
int mousePosition[] = {0,0};
int enemy1Position[] = {0,0};
int enemy2Position[] = {0,0};
int enemy3Position[] = {0,0};
int obstacleX_values [] = {0,0,0};
int obstacleY_values [] = {0,0,0};
boolean sameX = true;
boolean sameY = true;
//Variable estatica per controlar la velocitat del joc
final int speed = 15;
final int enemy1Speed = ceil(speed*0.8);
final int enemy2Speed = ceil(speed*0.6);
final int enemy3Speed = ceil(speed*0.5);
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

  generateObstacle(obstacleX_values, obstacleY_values);
  printObstacle(obstacleX_values, obstacleY_values);
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
  printObstacle(obstacleX_values, obstacleY_values);
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

void generateObstacle(int obstalceX_values[], int obstacleY_values[]){
    obstalceX_values[0] = ceil(random(1,16));
    obstacleY_values[0] = ceil(random(1,9));

    while(sameX && sameY)
    {
        obstalceX_values[1] = ceil(random(1,16));

        if(obstalceX_values[0] != obstalceX_values[1])
        {
          sameX = false;
        }

        obstacleY_values[1] = ceil(random(1,9));

        if(obstacleY_values[0] != obstacleY_values[1])
        {
          sameY = false;
        }

    }

    sameX = true;
    sameY = true;

    while(sameX && sameY){
        obstalceX_values[2] = ceil(random(1, 16));
        if(obstalceX_values[2] != obstalceX_values[1]){
          sameX = false;
        }
        obstacleY_values[2] = ceil(random(1, 9));
        if(obstacleY_values[2] != obstacleY_values[1]){
          sameY = false;
        }
    }
}
void printObstacle(int obstacleX_values[], int obstalceY_values[]){
  fill(23,240,230);
  ellipse(maxX* ELLIPSERADIUS, maxY * ELLIPSERADIUS, obstacleRadiusX, obstacleRadiusX );
  for(int i=0; i< obstacleX_values.length; i++){
  ellipse(obstacleX_values[i]* ELLIPSERADIUS, obstalceY_values[i] * ELLIPSERADIUS, obstacleRadiusX, obstacleRadiusX );
}

}
