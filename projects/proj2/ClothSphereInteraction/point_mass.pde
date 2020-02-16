class Point {
  //public int[] index;
  float mass = 0.9;
  float radius = 1;
  public Vector pos;
  public Vector vel = new Vector();
  public boolean isAnchor = false;
  
  //public Point(float x, float y, float z, int ix, int iy) {
  //  pos = new Vector(x, y, z);
  //  index = new int[] {ix, iy};
  //  isAnchor = false;
  //}
  
  Point(Vector _pos, float r, float m) {
    pos = _pos;
    radius = r;
    mass = m;
  }
}
