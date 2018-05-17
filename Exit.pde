class Exit {
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  final int RADIUS = 100;
  boolean succesfullyDone;
  float position[] = {0,0};
  float magnitudeVector;

  Exit(){
    position[POSITIONX] = random(300, width-300);
    position[POSITIONY] = random(300, height-300);
  }

  public int getRadius(){
      return RADIUS;
  }

  boolean generateExit(Player player, Obstacle obstacles, int lengthObstacles){
      //NO VAN ELS WHILES, TOT I SER FALSE ENTRA IGUAL
      //CADA COP QUE CANVIA LA X O LA Y HEM DE SETEAR LA I A 0 UN ALTRE COP
      if (colision(obstacles.position, obstacles.getRadius()) || colision(player.position, player.getRadius())){
        position[POSITIONX] = random(RADIUS, width-RADIUS);
        position[POSITIONY] = random(RADIUS, height-RADIUS);
        return false;
      }
      return true;
  }

  void printExit(){
    //println(x1,y1,x1+(TRIANGLEAREA/2),y1,x1+(TRIANGLEAREA/4),y1-(TRIANGLEAREA/2));

    //generem un triangle equilater
    fill(233,200,0);
    ellipse(position[POSITIONX],position[POSITIONY],100,100);
    fill(0);
    textSize(TEXTSIZEEXIT);
    text(EXITMESSAGE,position[POSITIONX]-TEXTSIZEEXIT,position[POSITIONY]-50);
  }

  public boolean colision(float endPos[], int endRadius){
      magnitudeVector = sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONY] - position[POSITIONY],2));
      return magnitudeVector < (endRadius * 0.5 + RADIUS * 0.5);
  }
}
