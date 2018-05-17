class Enemy extends MovingObject{
  final int ENEMIES_SPEED = 10;
  Enemy(){
    position[POSITIONX] = ceil(random(200,width-200));
    position[POSITIONY] = ceil(random(0200,height-200));
    speed = ceil(random(ENEMIES_SPEED/2,ENEMIES_SPEED-2));
  }

  public void randomize(){
    position[POSITIONX] = ceil(random(200,width-200));
    position[POSITIONY] = ceil(random(200,height-200));
  }

  public void pop(){
    fill(255,0,0);
    strokeWeight(0);
    ellipse(position[POSITIONX], position[POSITIONY], radius, radius);
  }
}
