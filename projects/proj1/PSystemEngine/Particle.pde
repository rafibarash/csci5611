abstract class Particle {
  PVector pos;
  PVector vel = new PVector(random(-1, 1), random(-1, 1), 0);
  PVector acc = new PVector(0, 0, 0);
  float mass = 1;
  float radius = 6;
  float lifespan = 255;
  PImage img;
  PVector colr = new PVector(0, 0, 0);
  boolean isDead = false;
  
  Particle(PVector pos) {
    this.pos = pos.copy();
  }
  
  Particle(PVector pos, PVector vel) {
    this.pos = pos.copy();
    this.vel = vel.copy();
  }
  
  Particle withImg(PImage i) {
    img = i;
    return this;
  }
  
  Particle withLifespan(float l) {
    lifespan = l;
    return this;
  }
  
  Particle withColor(PVector c) {
    colr = c;
    return this;
  }
  
  // Update particle motion, lifespan
  void update(float dt) {
    numericalIntegration(pos, vel, acc, dt);
    handleWallCollisions();
    lifespan -= dt;
  }
  
  // Renders particle
  void render() {
    noFill();
    stroke(0, 153, 204);
    vertex(pos.x, pos.y, pos.z);
  }
  
  boolean isDead() {
    if (lifespan <= 0 || isDead) return true;
    return false;
  }
  
  void applyForce(PVector force) {
    acc.add(PVector.div(force, mass));
  }
  
  void handleParticleCollisions(ParticleSystem ps) {
    for (Particle p : ps.particles) {
        if (isCollision(p)) {
          handleParticleCollision(p);
        }
      }
  }
  
  boolean isCollision(Particle p) {
    float d = distance(pos, p.pos);
    return d < (radius + p.radius);
  }

  void handleParticleCollision(Particle p) {
    isDead = true;
  }
  
  private void handleWallCollisions() {
    // handle collisions with floor
    if (pos.y > height) {
      pos.y = height;
      vel.y *= -0.4;
    }
    // handle collisions with ceiling
    else if (pos.y < 0) {
      pos.y = 0;
      vel.y *= -0.4;
    }
    //// handle left wall
    //else if (pos.x < 0) {
    //  pos.x = 0;
    //  vel.x *= -0.4;
    //}
    //// handle right wall
    //else if (pos.x > width) {
    //  pos.x = width;
    //  vel.x *= -0.4;
    //}
  }
  
  PVector randPointOnSquare(float w, float h) {
    float x = random(w);
    float y = random(h);
    return new PVector(x, y);
  }
  
  PVector randPointOnDisk(float radius) {
    float r = radius * sqrt(random(1));  // want that uniform sampling yo
    float theta = 2 * PI * random(1);
    float x = r * sin(theta);
    float y = r * cos(theta);
    return new PVector(x, y);
  }
}
