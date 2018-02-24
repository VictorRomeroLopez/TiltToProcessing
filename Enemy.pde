class Enemy extends MovingObject{
  Enemy(){
    position[POSITIONX] = ceil(random(0,width));
    position[POSITIONY] = ceil(random(0,height));
  }

  public void pop(){
    fill(255,0,0);
    strokeWeight(0);
    ellipse(position[POSITIONX], position[POSITIONY], radius, radius);
  }
}
