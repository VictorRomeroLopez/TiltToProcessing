class Obstacle{
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  final int BS = 100;
  final int MIN = 1;
  final int MAXX = ceil(width/BS)-1;
  final int MAXY = ceil(height/BS)-1;
  int position[] = {0,0};

  Obstacle(){
    position[POSITIONX] = ceil(random(MIN,MAXX));
    position[POSITIONY] = ceil(random(MIN,MAXY));
  }

  public int getPosition(int i){
    if(i == 0 || i == 1)
      i = position[i];
    return i;
  }

  void randomizePosition(){
    position[POSITIONX] = ceil(random(MIN,MAXX));
    position[POSITIONY] = ceil(random(MIN,MAXY));
  }

  void printObstacle(){
    strokeWeight(0);
    ellipse(position[POSITIONX] * BS, position[POSITIONY] * BS, BS, BS );
  }
}
