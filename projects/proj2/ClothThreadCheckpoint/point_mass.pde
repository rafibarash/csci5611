class Point {
  public int[] index;
  public Vector pos;
  public Vector vel;
  public boolean isAnchor;
  public Point(float x, float y, float z, int ix, int iy) {
    pos = new Vector(x, y, z);
    vel = new Vector();
    index = new int[] {ix, iy};
    isAnchor = false;
  }
}
