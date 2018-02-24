class Player extends MovingObject{
  Player(){
    position[POSITIONX] = width/2;
    position[POSITIONY] = height/2;
  }

  public void pop(){
    fill(0,255,0);
    strokeWeight(0);
    ellipse(position[POSITIONX], position[POSITIONY], radius, radius);
  }

  public boolean mouseColision(int endPos[]){
      magnitudeVectorX = ceil(sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONX] - position[POSITIONX],2)));
      magnitudeVectorY = ceil(sqrt(pow(endPos[POSITIONY] - position[POSITIONY],2) + pow(endPos[POSITIONY] - position[POSITIONY],2)));
      return magnitudeVectorX < radius/2 && magnitudeVectorY < radius/2;
  }
}
