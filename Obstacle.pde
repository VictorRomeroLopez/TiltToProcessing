class Obstacle{
  final int BS = 100;
  final int MIN = 1;
  final int MAXX = ceil(width/BS)-1;
  final int MAXY = ceil(height/BS)-1;
  int obstaclePositionX;
  int obstaclePositionY;

  Obstacle(){
    obstaclePositionX = ceil(random(MIN,MAXX));
    obstaclePositionY = ceil(random(MIN,MAXY));
  }

  void randomizePosition(){
    obstaclePositionX = ceil(random(MIN,MAXX));
    obstaclePositionY = ceil(random(MIN,MAXY));
  }

  void printObstacle(){
      ellipse(obstaclePositionX * BS, obstaclePositionY * BS, BS, BS );
  }
}
