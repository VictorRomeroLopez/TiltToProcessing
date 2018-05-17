class MovingObject{
  PVector position;
  int radius = 20;
  public float magnitudeVector;
  int speed;

  public int getRadius(){
    return radius;
  }

<<<<<<< HEAD
  public void moveTowards(float endPos[], int speed){
    float vectorX;
    float vectorY;
    vectorX = endPos[POSITIONX] - position[POSITIONX];
    vectorY = endPos[POSITIONY] - position[POSITIONY];
    position[POSITIONX] += (vectorX/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed;
    position[POSITIONY] += (vectorY/sqrt(pow(vectorX,2)+pow(vectorY,2)))*speed;
=======
  public void moveTowards(PVector endPos, int speed){
    PVector vector = new PVector(0,0);
    vector = new PVector(endPos.x - position.x, endPos.y - position.y);
    position.x += (vector.x/sqrt(pow(vector.x,2)+pow(vector.y,2)))*speed;
    position.y += (vector.y/sqrt(pow(vector.x,2)+pow(vector.y,2)))*speed;
>>>>>>> master
  }

  public void movementWithKeyboard(boolean keyInputUp,boolean keyInputDown,boolean keyInputLeft,boolean keyInputRigth, int speed){
    float vectorKX = 0.0f;
    float vectorKY = 0.0f;
    if(keyInputUp && keyInputLeft){
        vectorKX = -0.5f;
        vectorKY = -0.5f;
        }
    else if(keyInputUp && keyInputRigth){
        vectorKX = 0.5f;
        vectorKY = -0.5f;
        }
    else if(keyInputDown && keyInputLeft){
        vectorKX = -0.5f;
        vectorKY = 0.5f;
        }
    else if(keyInputDown && keyInputRigth){
        vectorKX = 0.5f;
        vectorKY = 0.5f;
        }
    else if(keyInputUp){
        vectorKX = 0.0f;
        vectorKY = -1.0f;
      }
    else if(keyInputLeft){
        vectorKX = -1.0f;
        vectorKY = 0.0f;
      }
    else if(keyInputDown){
        vectorKX = 0.0f;
        vectorKY = 1.0f;
      }
    else if(keyInputRigth){
        vectorKX = 1.0f;
        vectorKY = 0.0f;
      }


    position.x += vectorKX*speed;
    position.y += vectorKY*speed;
  }

  public boolean colision(PVector endPos, int endRadius){
      magnitudeVector = sqrt(pow(endPos.x - position.x,2) + pow(endPos.y - position.y,2));
      return magnitudeVector < (endRadius * 0.5 + radius * 0.5);
  }

  public void colisionMovement(PVector colisionPos, int radiusObstacle, int speed){
    PVector v = new PVector(position.x - colisionPos.x, position.y - colisionPos.y);
    v.setMag(radiusObstacle/2 + radius/2 + 1);
    position.x = v.x + colisionPos.x;
    position.y = v.y + colisionPos.y;
  }

  public PVector vectorProjection(PVector projector, PVector projected){
    PVector projection = projected;
    projection.x = (projector.x*projected.x)+(projector.y*projected.y)/(sqrt(pow(projector.x,2)+pow(projector.y,2))) * projector.x;
    projection.y = (projector.x*projected.x)+(projector.y*projected.y)/(sqrt(pow(projector.x,2)+pow(projector.y,2))) * projector.y;
    return projection;
  }
}
