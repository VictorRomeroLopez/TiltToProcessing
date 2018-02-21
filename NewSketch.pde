//TestMoviment Personatge

//Zona de variables
int playerX;
int playerY;
final int playerRadiusX = 50;
final int playerRadiusY = 50;

final int speed = 10;

int vectorX;
int vectorY;
int normalizedVectorX;
int normalizedVectorY;
//Zona de setup
void setup()
{
  fullScreen();
  strokeWeight(5);
  playerX = width/2;
  playerY = height/2;
}

//Zona de draw
void draw(){
  background(255);
  fill(0,255,0);
  ellipse(playerX,playerY,playerRadiusX,playerRadiusY);

  vectorX = mouseX - playerX;
  vectorY = mouseY - playerY;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  playerX += normalizedVectorX;
  playerY += normalizedVectorY;
}

void mousePressed(){
}
