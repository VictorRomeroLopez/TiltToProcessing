class Enemy extends MovingObject{
  final int ENEMIES_SPEED = 10;
  Enemy(){
<<<<<<< HEAD
    position[POSITIONX] = ceil(random(200,width-200));
    position[POSITIONY] = ceil(random(0200,height-200));
    speed = ceil(random(ENEMIES_SPEED/2,ENEMIES_SPEED-2));
  }

  public void randomize(){
    position[POSITIONX] = ceil(random(200,width-200));
    position[POSITIONY] = ceil(random(200,height-200));
=======
    position = new PVector(ceil(random(0,width)), ceil(random(0,height)));
    speed = ceil(random(SPEED/2,SPEED-2));
  }

  public void randomize(){
    position = new PVector(ceil(random(0,width)), ceil(random(0,height)));
>>>>>>> master
  }

  public void pop(){
    fill(255,0,0);
    strokeWeight(0);
    ellipse(position.x, position.y, radius, radius);
  }
}
