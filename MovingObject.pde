class MovingObject{
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  int position[] = { 0, 0 };
  int radius = 20;
  private int vectorX;
  private int vectorY;
  private int normalizedVectorX;
  private int normalizedVectorY;
  public int magnitudeVectorX;
  public int magnitudeVectorY;

  public void moveTowards(int endPos[], int speed){
    vectorX = endPos[POSITIONX] - position[POSITIONX];
    vectorY = endPos[POSITIONY] - position[POSITIONY];
    normalizedVectorX = ceil((vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
    normalizedVectorY = ceil((vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed);
    position[POSITIONX] += normalizedVectorX;
    position[POSITIONY] += normalizedVectorY;
  }

  public boolean colision(int endPos[], int endRadius){
      magnitudeVectorX = ceil(sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONX] - position[POSITIONX],2)));
      magnitudeVectorY = ceil(sqrt(pow(endPos[POSITIONY] - position[POSITIONY],2) + pow(endPos[POSITIONY] - position[POSITIONY],2)));
      return magnitudeVectorX < (endRadius*0.75+radius*0.75) && magnitudeVectorY < (endRadius*0.75+radius*0.75);
  }
}
