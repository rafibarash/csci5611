import java.util.Iterator;

enum PS_TYPE { 
  DEFAULT, WATER, FIRE; 
}

abstract class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  PS_TYPE type;
  PImage img;
  
  ParticleSystem(PVector og, PS_TYPE type) {
    origin = og.copy();
    particles = new ArrayList();
    this.type = type;
  }
  
  ParticleSystem(PVector og, PS_TYPE type, PImage img) {
    origin = og.copy();
    particles = new ArrayList();
    this.type = type;
    this.img = img;
  }
 
  abstract void addParticle();
  
  void applyForce(PVector f) {
    for (Particle p : particles) {
      p.applyForce(f);
    }
  }
  
  void applyRepeller(Repeller r) {
    for (Particle p: particles) {
      PVector force = r.repel(p);
      p.applyForce(force);
    }
  }
  
  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
         it.remove();
      }
    }
  }
  
  void kill() {
    particles = new ArrayList();
  }
  
  boolean isDead() {
    if (particles.size() == 0) return true;
    return false;
  }
}
