class Obstacle{
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  final int RADIUS = 100;
  final int MIN = 1;
  final int MAXX = ceil(width/RADIUS)-1;
  final int MAXY = ceil(height/RADIUS)-1;
  float position[] = {0.0f,0.0f};
  public float magnitudeVector;

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

  public boolean colision(float endPos[], int endRadius){
      magnitudeVector = sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONY] - position[POSITIONY],2));
      return magnitudeVector < (endRadius * 0.5 + RADIUS * 0.5);
  }
}
