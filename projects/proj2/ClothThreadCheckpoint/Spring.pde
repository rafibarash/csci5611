class Spring {
  float l0;  // resting length
  float ks = 600;  // spring strength constant
  float kd = 400;   // spring dampening constant
  Point p1;
  Point p2;
  
  Spring(Point _p1, Point _p2, float _l0) {
    p1 = _p1;
    p2 = _p2;
    l0 = _l0;
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
