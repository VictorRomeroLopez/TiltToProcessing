class Exit {
  final int RADIUS = 100;
  boolean succesfullyDone;
  PVector position;
  float magnitudeVector;

  Exit(){
<<<<<<< HEAD
    position[POSITIONX] = random(300, width-300);
    position[POSITIONY] = random(300, height-300);
=======
    position = new PVector(random(RADIUS, width-RADIUS), random(RADIUS, height-RADIUS));
>>>>>>> master
  }

  public int getRadius(){
      return RADIUS;
  }

  boolean generateExit(Player player, Obstacle obstacles, int lengthObstacles){
      //NO VAN ELS WHILES, TOT I SER FALSE ENTRA IGUAL
      //CADA COP QUE CANVIA LA X O LA Y HEM DE SETEAR LA I A 0 UN ALTRE COP
      if (colision(obstacles.position, obstacles.getRadius()) || colision(player.position, player.getRadius())){
        position = new PVector(random(RADIUS, width-RADIUS), random(RADIUS, height-RADIUS));
        return false;
      }
      return true;
  }

  void printExit(){
    //println(x1,y1,x1+(TRIANGLEAREA/2),y1,x1+(TRIANGLEAREA/4),y1-(TRIANGLEAREA/2));

    //generem un triangle equilater
    fill(233,200,0);
    ellipse(position.x,position.y,100,100);
    fill(0);
    textSize(TEXTSIZEEXIT);
    text(EXITMESSAGE,position.x-TEXTSIZEEXIT,position.y-50);
  }

  public boolean colision(PVector endPos, int endRadius){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
      return magnitudeVector < (endRadius * 0.5 + RADIUS * 0.5);
  }
}
