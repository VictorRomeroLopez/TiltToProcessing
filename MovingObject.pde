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

  public void movementWithKeyboard(char keyDown, int speed){
    float vectorKX = 0.0f;
    float vectorKY = 0.0f;
    if(keyDown == 'w' || keyDown == 'W'){
        vectorKX = 0.0f;
        vectorKY = -1.0f;
      }
    if(keyDown == 'a' || keyDown == 'A'){
        vectorKX = -1.0f;
        vectorKY = 0.0f;
      }
    if(keyDown == 's' || keyDown == 'S'){
        vectorKX = 0.0f;
        vectorKY = 1.0f;
      }
    if(keyDown == 'd' || keyDown == 'D'){
        vectorKX = 1.0f;
        vectorKY = 0.0f;
      }
      if(keyDown == 'w' || keyDown == 'W' && keyDown == 'a' || keyDown == 'A'){
          vectorKX = 1.0f;
          vectorKY = -1.0f;
        }
      if(keyDown == 'w' || keyDown == 'W' && keyDown == 'd' || keyDown == 'D'){
          vectorKX = -1.0f;
          vectorKY = -1.0f;
        }
      if(keyDown == 's' || keyDown == 'S' && keyDown == 'a' || keyDown == 'A'){
          vectorKX = 1.0f;
          vectorKY =  1.0f;
        }
      if(keyDown == 's' || keyDown == 'S' && keyDown == 'd' || keyDown == 'D'){
          vectorKX = -1.0f;
          vectorKY = 1.0f;
        }

    position[POSITIONX] += vectorKX*speed;
    position[POSITIONY] += vectorKY*speed;
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
