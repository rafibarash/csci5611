class Spring {
  float l0 = 10;  // resting length
  float ks = 500;  // spring strength constant
  float kd = 500;   // spring dampening constant
  Point p1;
  Point p2;
  
  Spring(Point _p1, Point _p2) {
    p1 = _p1;
    p2 = _p2;
  }
  
  // calculate the spring force for point mass A, direction from A to B
  Vector getForce() {
    // first get the directional vector from a to b
    Vector dir = Vector.sub(p2.pos, p1.pos);
    // length of dir is the current length of this spring
    float springLen = dir.magnitude();
    if (springLen < .001)
      return new Vector();
    // normalize it
    dir.normalize();
    // spring forces
    float sForce = ks * (springLen - l0);
    float dForce = kd * (p2.vel.dot(dir) - p1.vel.dot(dir));
    dir.scalarMul(sForce + dForce);
    return dir;
  }
}
