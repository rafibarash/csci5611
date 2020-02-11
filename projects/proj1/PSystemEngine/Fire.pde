class Fire extends ParticleSystem {
  
  Fire(PVector og) {
    super(og, PS_TYPE.FIRE);
  }
  
  void genParticle(PVector initVel) {
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    //float vz = randomGaussian()*0.3;
    float vz = 0;
    PVector vel = new PVector(vx, vy, vz).add(initVel);
    FireParticle p = new FireParticle(origin, vel);
    if (lifespan != 0) p = (FireParticle) p.withLifespan(lifespan).withColor(new PVector(255,0,0));
    if (img != null) p = (FireParticle) p.withImg(img);
    particles.add(p);
  }
  
}

class FireParticle extends Particle {
  
  FireParticle(PVector pos) {
    super(pos);
  }
  
  FireParticle(PVector pos, PVector vel) {
    super(pos, vel);
  }
  
  void render() {
    if (img != null) {
      imageMode(CENTER);
      if (random(1) < 0.002) {
        colr = new PVector(1, 1, 1);
      }
      tint(colr.x, colr.y, colr.z, lifespan);
      image(img, pos.x, pos.y);
    } else {
      noFill();
      stroke(colr.x, colr.y, colr.z);
      vertex(pos.x, pos.y, pos.z);
    }
  }
}
