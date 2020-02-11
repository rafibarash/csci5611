class Repeller {
  float strength;
  PVector pos;
  float radius;
 
  Repeller(float x, float y, float z, float r, float s)  {
    pos = new PVector(x, y, z);
    radius = r;
    strength = s;
  }
  
  PVector repel(Particle p) {
    // Get force direction
    PVector dir = PVector.sub(pos, p.pos);
    // Get distance
    float d = dir.mag();
    d = constrain(d, 5, 100);
    dir.normalize();
    // Calculate magnitude
    float force = -1 * strength / (d * d);
    // Make vector out of direction and magnitude
    dir.mult(force);
    
    return dir;
  }
 
  void render() {
    stroke(0);
    fill(0);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}
