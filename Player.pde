class Player extends MovingObject{
  Player(){
    position = new PVector(width/2, height/2);
  }

  public void pop(){
    fill(0,255,0);
    strokeWeight(0);
    ellipse(position.x, position.y, radius, radius);
  }

  public boolean mouseColision(PVector endPos){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
      return magnitudeVector < (radius/2);
  }
}
