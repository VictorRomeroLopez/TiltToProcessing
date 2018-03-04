class Obstacle{
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  final int RADIUS = 100;
  final int MIN = 1;
  final int MAXX = ceil(width/RADIUS)-1;
  final int MAXY = ceil(height/RADIUS)-1;
  float position[] = {0.0f,0.0f};

  Obstacle(){
    position[POSITIONX] = random(MIN,MAXX)*RADIUS;
    position[POSITIONY] = random(MIN,MAXY)*RADIUS;
  }

  public float getPosition(int i){
    float j = 0.0f;
    if(i == 0 || i == 1)
       j = position[i];
    return j;
  }
  public int getRadius(){
      return RADIUS;
    }

  void randomizePosition(){
    position[POSITIONX] = (random(MIN,MAXX))*RADIUS;
    position[POSITIONY] = (random(MIN,MAXY))*RADIUS;
  }

  void printObstacle(){
    strokeWeight(0);
    ellipse(position[POSITIONX], position[POSITIONY], RADIUS, RADIUS );
  }
}
