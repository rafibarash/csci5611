static class Vector {
  
  public float x, y, z;
  
  Vector() {
    x = 0;
    y = 0;
    z = 0;
  }
  
  Vector(float _x, float _y) {
    x = _x;
    y = _y;
    z = 0;
  }
  
  Vector(float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
  }
  
  Vector projectToPlane(Vector normal) {
    Vector tmp = projectToLine(normal);
    return new Vector(x-tmp.x, y-tmp.y, z-tmp.z);
  }
  
  Vector projectToLine(Vector directional) {
    float tmp = this.dot(directional);
    tmp /= directional.magSquared();
    return new Vector(directional.x*tmp, directional.y*tmp, directional.z*tmp);
  }
  
  public float mag() {
    return sqrt(x*x + y*y + z*z);
  }
  
  public float magSquared() {
    return x*x + y*y + z*z;
  }
  
  public void normalize() {
    float len = this.mag();
    x /= len;
    y /= len;
    z /= len;
  }
  
  static Vector normalize(Vector v) {
    Vector newV = v.copy();
    newV.normalize();
    return newV;
  }
  
  public void limit(float max) {
    float mag = this.mag();
    if (mag > max) {
      this.mul(max / mag);
    }
  }
  
  public float dot(Vector vec) {
    return x*vec.x + y*vec.y + z*vec.z;
  }
  
  static float dot(Vector v1, Vector v2) {
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
  }
  
  public float angle(Vector vec) {
    return acos((this.dot(vec)/(this.mag()*vec.mag())));
  }
  
  public void add(Vector vec) {
    x += vec.x;
    y += vec.y;
    z += vec.z;
  }
  
  public static Vector add(Vector v1, Vector v2) {
    Vector vec = v1.copy();
    vec.x += v2.x;
    vec.y += v2.y;
    vec.z += v2.z;
    return vec;
  }
  
  void sub(Vector vec) {
    x -= vec.x;
    y -= vec.y;
    z -= vec.z;
  }
  
  static Vector sub(Vector v1, Vector v2) {
    return new Vector(v1.x-v2.x, v1.y-v2.y, v1.z-v2.z);
  }
  
  public void scalarMul(float s) {
    x *= s;
    y *= s;
    z *= s;
  }
  
  void mul(float s) {
    x *= s; y *= s; z *= s;
  }
  
  static Vector mul(Vector v, float s) {
    return new Vector(v.x*s, v.y*s, v.z*s);
  }
  
  void div(float s) {
    x /= s; y /= s; z /= s;
  }
  
  static Vector div(Vector v, float s) {
    return new Vector(v.x/s, v.y/s, v.z/s);
  }
  
  public Vector copy() {
    return new Vector(x, y, z);
  }
  
  public void reflect(Vector n) {
    Vector normal = n.copy();
    float nl = normal.dot(this) * 2;
    normal.scalarMul(nl);
    x -= normal.x;
    y -= normal.y;
    z -= normal.z;
  }
  
  float distance(Vector v1) {
    return sqrt(pow(x-v1.x, 2) + pow(y-v1.y, 2) + pow(z-v1.z, 2));
  }
  
  static float distance(Vector v1, Vector v2) {
    return sqrt(pow(v1.x-v2.x,2) + pow(v1.y-v2.y,2) + pow(v1.z-v2.z,2));
  }
  
  // Returns angle representing direction vector is heading in (using XY)
  float dirXY() {
    if (x == 0) return 0;
    return atan2(y, x);
  }
  
  @Override
  String toString() { 
     return String.format("Vector <%.2f, %.2f, %.2f>", x, y, z); 
  }
  
  //@Override
  boolean equals(Vector other) {
    return this.distance(other) < 0.3;
  }
}
