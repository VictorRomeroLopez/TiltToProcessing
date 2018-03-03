class MovingObject{
  final int POSITIONX = 0;
  final int POSITIONY = 1;
  float position[] = { 0, 0 };
  int radius = 20;
  public float magnitudeVector;

  public void moveTowards(float endPos[], int speed){
    float vectorX;
    float vectorY;
    vectorX = endPos[POSITIONX] - position[POSITIONX];
    vectorY = endPos[POSITIONY] - position[POSITIONY];
    position[POSITIONX] += (vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed;
    position[POSITIONY] += (vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed;
  }

  public void movementWithKeyboard(char key, int speed){
    float vectorKX = 0.0;
    float vectorKY = 0.0;
    switch (key) {
      case 'w':
      case 'W':
        vectorKX = 0;
        vectorKY = -1;
      break;
      case 'a':
      case 'A':
        vectorKX = -1;
        vectorKY = 0;
        break;
      case 's':
      case 'S':
        vectorKX = 0;
        vectorKY = 1;
        break;
      case 'D':
      case 'd':
        vectorKX = 1;
        vectorKY = 0;
        break;
    }
    position[POSITIONX] += (vectorKX/sqrt(pow(vectorKX,2)+pow(vectorKY,2)))*speed;
    position[POSITIONY] += (vectorKY/sqrt(pow(vectorKX,2)+pow(vectorKY,2)))*speed;

  }

  public boolean colision(float endPos[], int endRadius){
      magnitudeVector = sqrt(pow(endPos[POSITIONX] - position[POSITIONX],2) + pow(endPos[POSITIONY] - position[POSITIONY],2));
      return magnitudeVector < (endRadius * 0.5 + radius * 0.5);
  }

  public void colisionMovement(float colisionPos[], int radiusObstacle, int speed){
    PVector v = new PVector(position[POSITIONX] - colisionPos[POSITIONX], position[POSITIONY] - colisionPos[POSITIONY]);
    v.setMag(radiusObstacle/2 + radius/2 + 1);
    position[POSITIONX] = v.x + colisionPos[POSITIONX];
    position[POSITIONY] = v.y + colisionPos[POSITIONY];
  }
}
