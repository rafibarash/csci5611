class Point {
  float mass = 0.9;
  float radius = 1;
  public Vector pos;
  public Vector vel = new Vector();
  public boolean isAnchor = false;
  
  Point(Vector _pos, float r, float m) {
    pos = _pos;
    radius = r;
    mass = m;
  }
}
