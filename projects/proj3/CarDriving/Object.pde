class Object {
  Vector pos;
  float radius;
  boolean isDead = false;
  
  Object(Vector _pos, float _radius) {
    pos = _pos;
    radius = _radius;
  }
  
  boolean isDetectable = true;
  
  boolean isDetectable() { return isDetectable; }
  
  // Check if point lands inside circle
  boolean isCollision(Vector otherPos) {
    return Vector.distance(pos, otherPos) < radius;
  }
}
