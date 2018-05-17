class Bullet extends MovingObject {
  final int POSX = 0;
  final int POSY = 1;
  PVector position;
  int speed;
  boolean targetet;
  Enemy target;

  Bullet(PVector positionFired, Enemy enemyList[]) //contructor de bullet
  {
      targetet = false;
      speed = 10;
      position = positionFired;
      target = targeting(enemyList, positionFired);
  }

  public void pop(){
    fill(0,0,255);
    strokeWeight(0);
    ellipse(position.x, position.y, radius, radius);
  }

  Enemy targeting(Enemy enemyList[], PVector playerPosition){ //compara la posicio de tots els enemics per decidir un target
    PVector minDist;
    PVector nextDist;
    minDist.x = playerPosition.x - enemyList[0].position.x; //agafa com a posicio minima la del primer enemic
    minDist.y = playerPosition.y - enemyList[0].position.y;
    int enemy = 0;
    for(int i = 1; i< enemyList.length; i++){//compara amb la distancia de la resta dels enemics
      nextDist.x = playerPosition.x - enemyList[i].position.x;
      nextDist.y = playerPosition.y - enemyList[i].position.y;
      if (nextDist.x < minDist.x && nextDist.y < mextDist.y){
        minDist = nextDist;
        enemy = i;
      }
    }
  }
}
