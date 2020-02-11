import java.util.Iterator;

enum PS_TYPE { 
  WATER, FIRE; 
}

abstract class ParticleSystem {
  ArrayList<Particle> particles = new ArrayList();
  PVector origin;
  PVector initVel = new PVector(0, 0, 0);
  PS_TYPE type;
  PImage img;
  float genRate = 1;
  float lifespan = 255;
  
  /**
   * Constructor Stuff
   */
   
  ParticleSystem(PVector og, PS_TYPE t) {
    origin = og.copy();
    type = t;
  }
  
  ParticleSystem withInitVel(PVector v) {
    initVel = v.copy();
    return this;
  }
  
  ParticleSystem withImg(PImage i) {
    img = i;
    return this;
  }
  
  ParticleSystem withGenRate(float r) {
    genRate = r;
    return this;
  }
  
  ParticleSystem withLifespan(float l) {
    lifespan = l;
    return this;
  }
  
  // generate new particles
  void genParticles(float dt) {
    // get num particles to generate
    int genNumParticles = calculateGenNumParticles(dt);
    // actually generate particles
    for (int i = 0; i < genNumParticles; i++) {
      genParticle(initVel.copy());
    }
  }
 
  abstract void genParticle(PVector initVel);
  
  void applyForce(PVector f) {
    for (Particle p : particles) {
      p.applyForce(f);
    }
  }
  
  void handleCollisions(ParticleSystem ps) {
    for (Particle p: particles) {
      p.handleParticleCollisions(ps);
    }
  }
  
  // generate new particles and update particles
  void update(float dt) {
    genParticles(dt);
    for (Particle p : particles) {
      p.update(dt);
    }
  }
  
  void render() {
    Iterator<Particle> it = particles.iterator();
    beginShape(POINTS);
    while (it.hasNext()) {
      Particle p = it.next();
      p.render();
      if (p.isDead()) {
         it.remove();
      }
    }
    endShape(POINTS);
  }
  
  void kill() {
    particles = new ArrayList();
  }
  
  boolean isDead() {
    if (particles.size() == 0) return true;
    return false;
  }
  
  void pertubVelocity(PVector vec) {
    PVector pertub = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    vec.add(pertub);
  }
  
  // determine num particles to generate based on timestep and genRate
  protected int calculateGenNumParticles(float dt) {
    // generate particles equal to timestep * genRate
    double numParticles = dt * genRate;
    int numParticlesInt = (int) numParticles;
    double fracPart = numParticles - numParticlesInt;
    // randomly generate fractional particle
    if (Math.random() < fracPart) {
      numParticlesInt++;
    }
    return numParticlesInt;
  }
}
