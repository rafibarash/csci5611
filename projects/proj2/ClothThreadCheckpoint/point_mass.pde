class Point {
  public int[] index;
  float mass = 1;
  float radius = 1;
  public Vector pos;
  public Vector vel = new Vector();
  public boolean isAnchor = false;
  public Point(float x, float y, float z, int ix, int iy) {
    pos = new Vector(x, y, z);
    index = new int[] {ix, iy};
    isAnchor = false;
  }
  
  public Point(float x, float y, float z) {
    pos = new Vector(x, y, z);
  }
  
  Point(Vector _pos) {
    pos = _pos;
  }
}
