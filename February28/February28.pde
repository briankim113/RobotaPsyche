//use ArrayList for dynamic size - no need for NullPointerException handling
ArrayList<Fish> fishes = new ArrayList<Fish>();
ArrayList<Food> foods = new ArrayList<Food>();

void setup() {
  size(600, 600);
  smooth();
  noStroke();
  
  // add 10 fishes
  for (int i=0; i<10; i++){
    fishes.add(new Fish());
  }
}

void mouseClicked() {
  // drop more food on mouse position
  foods.add(new Food(mouseX, mouseY));
}

void draw() {
  background(128, 206, 175); //ocean water
  
  fill(0);
  textSize(25);
  textAlign(CENTER);
  text("Number of Fish Left = " + fishes.size(), width/2, height/8);

  //for every fish
  for (int i=0; i<fishes.size(); i++){
    
    //fish repel each other
    for (int j=0; j<fishes.size(); j++){
      if (i != j) { // do not repel yourself
        PVector fishForce = fishes.get(j).repel(fishes.get(i));
        fishes.get(i).applyForce(fishForce);
      }
    }
    
    for (int k=0; k<foods.size(); k++){
      //food attracts fish
      PVector foodForce = foods.get(k).attract(fishes.get(i));
      fishes.get(i).applyForce(foodForce);
      
      //did this fish eat the food?
      boolean foodEaten = fishes.get(i).eatCheck(foods.get(k));
      if (foodEaten) foods.remove(k);
    }
    
    //update all forces and display fish
    fishes.get(i).update();
    fishes.get(i).display();
    
    //if fish doesn't eat in time...
    if (fishes.get(i).diesHungry()){
      fishes.remove(i);
    }
  }
  
  //display food
  for (int k=0; k<foods.size(); k++){
    foods.get(k).display();
  }
}

class Food {
  float radius;
  PVector location;
  float G = 1;

  Food(float x, float y) {
    radius = 6;
    location = new PVector(x, y);
  }

  PVector attract(Fish f) {
    PVector force = PVector.sub(location, f.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0); // constrain the distance so that our circle doesn’t spin out of control
    force.normalize();
    float strength = (G * radius * f.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    push();
    fill(0); //fish food color
    ellipse(location.x, location.y, radius*2, radius*2);
    pop();
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
  int timer; //in millis

  Fish() {
    location = new PVector(random(width),random(height)); // random so starting points are different
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 5; // gradually increased as fish eats food
    currentShape = 0;                   
    shapeX = new float[numShapes];  
    shapeY = new float[numShapes];  
    shapeA = new float[numShapes];
    timer = millis();
  }

  // Newton's second law
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
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
    //println("location.x", location.x, f.location.x - 5*mass, f.location.x + 5*mass);
    //println("location.y", location.y, f.location.y - 5*mass, f.location.y + 5*mass);

    //previously had f.radius (which is constant and does not consider fish's increasing size) instead of 5*mass
    if (
      (location.x >= f.location.x - (5*mass)) && (location.x <= f.location.x + (5*mass)) //in between horizontally
        &&
      (location.y >= f.location.y - (5*mass)) && (location.y <= f.location.y + (5*mass)) //in between vertically
    ){
      // modify fish-related things inside this function
      // remove food outside this function
      mass += 0.5; //smaller increase in mass for every food eaten
      
      //reset timer if fish eats food
      timer = millis();
      return true;
    } else {
      return false;
    }
  }
  
  boolean diesHungry(){
    int runtime = millis() - timer;
    if (runtime >= 10000) { //10 seconds seem fair for... DEATH
      return true;
    } else {
      return false;
    }
  }

  void display() {
    push();
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
      /*
      from Processing docs:
      A triangle is a plane created by connecting three points.
      The first two arguments specify the first point, the middle two arguments specify the second point, and the last two arguments specify the third point.
      */
      triangle(0, 5*mass, 0, -5*mass, 20*mass, 0); // eating food increases size
      popMatrix();
    }
    
    // increment counter
    currentShape++;
    currentShape %= numShapes;  // rollover counter to 0 when up to numShapes
    pop();
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
      velocity.y *= -1;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
  }
}
