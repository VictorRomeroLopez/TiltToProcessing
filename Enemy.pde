class Enemy extends MovingObject{
  Enemy(){
    position = new PVector(ceil(random(0,width)), ceil(random(0,height)));
    speed = ceil(random(SPEED/2,SPEED-2));
  }

  public void randomize(){
    position = new PVector(ceil(random(0,width)), ceil(random(0,height)));
  }

  public void pop(){
    fill(255,0,0);
    strokeWeight(0);
    ellipse(position.x, position.y, radius, radius);
  }
}
