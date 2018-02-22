//TestMoviment Personatge

//Zona de variables
//Variables per la creacio del personatge
int playerX;
int playerY;
final int playerRadiusX = 50;
final int playerRadiusY = 50;

//Variable estatica per controlar la velocitat del joc
final int speed = 10;

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
  playerX = width/2;
  playerY = height/2;
}

//Zona de draw
void draw(){
  //background blanc
  background(255);
  //Creem el personatge a una posició i el pintem de color verd
  fill(0,255,0);
  ellipse(playerX,playerY,playerRadiusX,playerRadiusY);

    //Notas: Intenta que el moviment estigui posat a una funcio tenint que pasarli
    //per parametre el punt inicial i el final. Els parametres de l'inicial
    //han de ser passats per referencia. He estat buscant pero no es fa igual que
    //a C. Busca si es pot fer.

  //Calculem el vector director normalitzat que ens moura el personatge
  vectorX = mouseX - playerX;
  vectorY = mouseY - playerY;
  normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
  //Es suma el vector resultant descomposat als seus respectius eixos
  playerX += normalizedVectorX;
  playerY += normalizedVectorY;

}
