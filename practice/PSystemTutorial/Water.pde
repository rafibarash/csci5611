class Water extends ParticleSystem {
  
  Water(PVector og) {
    super(og, PS_TYPE.WATER);
  }
  
  void addParticle() {
    if (img != null) {
      particles.add(new WaterParticle(origin, img));
    } else {
      particles.add(new WaterParticle(origin));
    }
  }
}

class WaterParticle extends Particle {
  
  WaterParticle(PVector pos) {
    super(pos);
  }
  
  WaterParticle(PVector pos, PImage img) {
    super(pos, img);
  }
  
  void render() {
    rectMode(CENTER);
    fill(175);
    stroke(0);
    rect(pos.x,pos.y,8,8);
  }
}
