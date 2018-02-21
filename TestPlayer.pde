//Controla la velocitat del juego
int speed = 15;
//Variables que controlan el personaje principal
int playerX;
int playerY;
final int playerRadiusX;
final int playerRadiusY;

void setup(){
  //Tamaño de la ventana
  fullScreen();
  //Grueso del pinzel
  strokeWeight(0);
  //Posicion inicial del personaje
  playerX = width/2;
  playerY = height/2;
}

void draw(){
  //Color de fondo a blanco
  background(255);

  //Rellena la elipse donde esta situado nuestro personaje de color verde
  fill(0,255,0);
  ellipse(playerX,playerY,playerRadiusX,playerRadiusY);
  //Si detecta una tecla presionada (w,a,s,d) mueve el
  //personaje hacia la direccion designada a cada letra
  if(keyPressed){
    if(key == 'w'){
      playerY-=;
    }else if(key == 'a'){

    }else if(key == 's'){

    }else if(key == 'd'){

    }
  }
  //Impide que el personaje pueda salir de la ventana
  limitPlayer();

}
void limitPlayer(){
   if(playerX > width)
     playerX = width;
   if(playerY > height)
     playerY = height;
   if(playerX < 0)
     playerX = 0;
   if(playerY < 0)
     playerY = 0;
}
//hola aixo es una prova pel git kraken, ets un pringat
