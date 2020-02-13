class Point {
  public int[] index;
  public Vector pos;
  public Vector vel;
  public boolean isAnchor;
  public Point(float x, float y, float z, int ix, int iy) {
    pos = new Vector();
    vel = new Vector();
    this.pos.x = x;
    this.pos.y = y;
    this.pos.z = z;
    index = new int[] {ix, iy};
    isAnchor = false;
  }
}