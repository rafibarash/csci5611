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
  // Used StackOverflow for help with this
  // https://bobobobo.wordpress.com/2008/01/07/solving-linear-equations-ax-by-c-0/
  boolean isCollision(Vector n1, Vector n2) {
    // Ax + By + C = 0
    // (y1 – y2)x + (x2 – x1)y + (x1y2 – x2y1) = 0
    // Set constants for line equation
    float a = n1.y - n2.y;
    float b = n2.x - n1.x;
    float c = n1.x*n2.y - n2.x*n1.y;
    // Check if circle intersects with line
    // Finding the distance of line from circle. 
    double dist = (abs(a * pos.x + b * pos.y + c)) /  
                    sqrt(a * a + b * b); 
    return radius > dist;
  }
}
