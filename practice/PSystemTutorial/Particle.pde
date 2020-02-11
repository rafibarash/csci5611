class Particle {
  PVector pos;
  PVector vel = new PVector(random(-1, 1), random(-1, 1), 0);
  PVector acc = new PVector(0, 0, 0);
  float mass = 1;
  float lifespan = 255;
  PImage img;
  //PVector color;
  //float lifetime;
  
  Particle(PVector pos) {
    this.pos = pos.copy();
  }
  
  Particle(PVector pos, PImage img) {
    this.pos = pos.copy();
    this.img = img;
  }
  
  Particle(PVector pos, PVector vel) {
    this.pos = pos.copy();
    this.vel = vel.copy();
  }
  
  Particle(PVector pos, PVector vel, PImage img) {
    this.pos = pos.copy();
    this.vel = vel.copy();
    this.img = img;
  }
  
  void run() {
    update();
    render();
  }
  
  // Update particle motion, lifespan
  // void update(float dt) {
  void update() {
    // numericalIntegration(pos, vel, acc, dt);
    numericalIntegration(pos, vel, acc, 1);
    lifespan -= 2;
  }
  
  // Renders particle
  void render() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(127, lifespan);
    ellipse(pos.x, pos.y, 12, 12);
  }
  
  boolean isDead() {
    if (lifespan <= 0) return true;
    return false;
  }
  
  void applyForce(PVector force) {
    acc.add(PVector.div(force, mass));
  }
}
