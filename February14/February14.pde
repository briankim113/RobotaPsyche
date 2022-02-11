Fish[] fishes = new Fish[20];
Food food1, food2;

void setup() {
  size(640,360);
  smooth();
  noStroke();
  
  // declaration and instantiation separated as such because height/width variables that may be called in object constructors are affected by size()
  for (int i=0; i<fishes.length; i++){
    fishes[i] = new Fish();
  }
  food1 = new Food();
  food2 = new Food();
}


void draw() {
  background(128, 206, 175); //ocean water

  for (int i=0; i<fishes.length; i++){
    for (int j=0; j<fishes.length; j++){
      if (i != j) { // do not repel yourself
        PVector fishForce = fishes[j].repel(fishes[i]);
        fishes[i].applyForce(fishForce);
      }
    }
    PVector foodForce1 = food1.attract(fishes[i]);
    PVector foodForce2 = food2.attract(fishes[i]);
    fishes[i].applyForce(foodForce1);
    fishes[i].applyForce(foodForce2);
    fishes[i].update();
    
    boolean foodEaten1 = fishes[i].eatCheck(food1);
    boolean foodEaten2 = fishes[i].eatCheck(food2);
    if (foodEaten1) food1.location = new PVector(random(width), random(height)); // food is respawn
    if (foodEaten2) food2.location = new PVector(random(width), random(height)); // food is respawn
    
    fishes[i].display();
  }
  
  food1.display();
  food2.display();
}

class Food {
  float radius;
  PVector location;
  float G = 1;

  Food() {
    radius = 6;
    location = new PVector(random(width), random(height));
  }

  PVector attract(Fish f) {
    PVector force = PVector.sub(location, f.location);
    float distance = force.mag();
    distance = constrain(distance,5.0,25.0); // constrain the distance so that our circle doesn’t spin out of control
    force.normalize();
    float strength = (G * radius * f.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    fill(0); //fish food color
    ellipse(location.x, location.y, radius*2, radius*2);
  }
}


class Fish {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G = 0.5;
  
  // array for object trail - implemented in display()
  // source - https://hellocircuits.com/2013/10/08/simple-object-trails-in-processing/
  int numShapes = 20;
  int currentShape; // counter
  float[] shapeX; // x coordinates
  float[] shapeY; // y coordinates
  float[] shapeA; // alpha values

  Fish() {
    location = new PVector(random(width),random(height)); // random so starting points are different
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 1; // gradually increased as fish eats food
    currentShape = 0;                   
    shapeX = new float[numShapes];  
    shapeY = new float[numShapes];  
    shapeA = new float[numShapes];
  }

  // Newton's second law
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  PVector repel(Fish f) {
    PVector force = PVector.sub(location, f.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();

    float strength = (G * mass * f.mass) / (distance * distance);
    force.mult(strength);
    force.mult(-1); // repel
    
    return force;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0); // clear the acceleration each time
  }
  
  boolean eatCheck(Food f) {
    if (
      (location.x >= f.location.x - f.radius) && (location.x <= f.location.x + f.radius) //in between horizontally
        &&
      (location.y >= f.location.y - f.radius) && (location.y <= f.location.y + f.radius) //in between vertically
    ){
      // modify fish-related things inside this function
      // for food-related things, modify outside this function because this Food f is pass by value (copy), not pass by reference (actual variable)
      mass++;
      return true;
    } else {
      return false;
    }
  }

  void display() {
    shapeX[currentShape] = location.x;
    shapeY[currentShape] = location.y;
    shapeA[currentShape] = 255;
    
    for (int i=0; i<numShapes; i++) {
      // color
      fill(255, shapeA[i]);
      shapeA[i] -= 255/numShapes;
      
      // shape   
      pushMatrix();
      translate(shapeX[i], shapeY[i]);
      rotate(velocity.heading());
      triangle(0, 5*mass, 0, -5*mass, 20*mass, 0); // eating food increases size
      popMatrix();
    }
    
    // increment counter
    currentShape++;
    currentShape %= numShapes;  // rollover counter to 0 when up to numShapes
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }

    if (location.y > height) {
      location.y = height;
      velocity.y = 0;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }
}
