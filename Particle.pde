class Particle{
  PVector velocity;
  PVector acceleration;
  PVector location;
  float weight;
  float deltaT;

  Particle(){

    //MASSA
    weight = 1.0f;

    acceleration = new PVector(0.0, 100/weight);

    location = new PVector(random(width), random(height));
    //VECTOR VELOCITAT
    velocity = new PVector(random(-40, 40), -random(100, 150));
    //TEMPS
    deltaT = 0.05f;
  }
}
