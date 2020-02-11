class Fire extends ParticleSystem {
  
  Fire(PVector og) {
    super(og, PS_TYPE.FIRE);
  }
  
  Fire(PVector og, PImage img) {
    super(og, PS_TYPE.FIRE, img);
  }
  
  void addParticle() {
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    PVector vel = new PVector(vx, vy, 0);
    if (img != null) {
      particles.add(new FireParticle(origin, vel, img));
    } else {
      particles.add(new FireParticle(origin));
    }
  }
}

class FireParticle extends Particle {
  
  FireParticle(PVector pos) {
    super(pos);
  }
  
  FireParticle(PVector pos, PImage img) {
    super(pos, img);
  }
  
  FireParticle(PVector pos, PVector vel, PImage img) {
    super(pos, vel, img);
  }
  
  void render() {
    if (img != null) {
      imageMode(CENTER);
      tint(0, lifespan);
      image(img, pos.x, pos.y);
    } else {
      float theta = map(pos.x,0,width,0,TWO_PI*2);
      rectMode(CENTER);
      fill(0,lifespan);
      stroke(0,lifespan);
      pushMatrix();
      translate(pos.x,pos.y);
      rotate(theta);
      rect(0,0,8,8);
      popMatrix();
    }
    
  }
}
