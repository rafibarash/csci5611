class Obstacle extends Object {
  Vector pos;
  float radius;
  
  Obstacle(Vector _pos) {
    pos = _pos;
  }
  
  void render() {
    fill(100, 100, 100);
    noStroke();
    circle(pos.x, pos.y, radius);
  }
  
  // Check if point lands inside circle
  boolean isCollision(Vector otherPos) {
    return Vector.distance(pos, otherPos) < radius;
  }
  
  // Check if line made from two points intersects with circle
  // https://en.wikipedia.org/wiki/Line-sphere_intersection
  // Also looked at lecture slides 04 on collisions
  // ad^{2} + bd + c = 0
  boolean isCollision(Vector v1, Vector v2) {
    Vector uv = Vector.sub(v1, v2);                                  // line direction vector
    Vector rd = Vector.normalize(uv);                                // normalized line direction vector
    float a = 1;                                                     // a = magnitude(rd) = 1
    float b = 2 * Vector.dot(rd, Vector.sub(v1, pos));               // distance between origin and line, mult by 2
    float c = Vector.sub(v1, pos).magSquared() - pow(radius, 2);     // don't really understand c
    // Check if circle intersects with line
    //float d = pow(b, 2) - (4 * a * c);
    //return d >= 0;
    float[] x = quadraticSolver(a, b, c);
    return x[0] < 0 || x[1] < 0;
  }
  
  // Quadratic solver
  private float[] quadraticSolver(float a, float b, float c) {
    float[] x = new float[2];
    float d = sqrt(pow(b, 2) - 4*a*c);
    x[0] = (-b + d) / 2*a;
    x[1] = (-b - d) / 2*a;
    // check for imag numbers
    if (Float.isNaN(x[0])) x[0] = 0;
    if (Float.isNaN(x[1])) x[1] = 0;
    return x;
  }
}
