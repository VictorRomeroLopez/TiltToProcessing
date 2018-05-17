class Obstacle{
  final int RADIUS = 100;
<<<<<<< HEAD
  final int MIN = 3;
  final int MAXX = ceil((width-300)/RADIUS)-1;
  final int MAXY = ceil((height-300)/RADIUS)-1;
  float position[] = {0.0f,0.0f};
=======
  final int MIN = 1;
  final int MAXX = ceil(width/RADIUS)-1;
  final int MAXY = ceil(height/RADIUS)-1;
  PVector position;
>>>>>>> master
  public float magnitudeVector;

  Obstacle(){
    position = new PVector(random(MIN,MAXX) * RADIUS, random(MIN,MAXY) * RADIUS);
  }

  public PVector getPosition(){
    return position;
  }

  public int getRadius(){
      return RADIUS;
  }

  void randomizePosition(){
    position.x = (random(MIN,MAXX))*RADIUS;
    position.y = (random(MIN,MAXY))*RADIUS;
  }

  void printObstacle(){
    strokeWeight(0);
    ellipse(position.x, position.y, RADIUS, RADIUS );
  }

  public boolean colision(PVector endPos, int endRadius){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
      return magnitudeVector < (endRadius * 0.5 + RADIUS * 0.5);
  }

  public boolean colisionGenerator(float endPos[], float startPos[], int endRadius){

      return (startPos[POSITIONX] < endPos[POSITIONX] + endRadius || startPos[POSITIONX] > endPos[POSITIONX] - endRadius) &&
             (startPos[POSITIONY] > endPos[POSITIONY] + endRadius || startPos[POSITIONY] < endPos[POSITIONY] - endRadius);
  }

}
