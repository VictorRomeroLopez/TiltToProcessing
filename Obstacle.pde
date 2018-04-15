class Obstacle{
  final int RADIUS = 100;
  final int MIN = 1;
  final int MAXX = ceil(width/RADIUS)-1;
  final int MAXY = ceil(height/RADIUS)-1;
  PVector position;
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
}
