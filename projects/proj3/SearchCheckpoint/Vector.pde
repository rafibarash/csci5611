static class Vector {
  
  public float x, y, z;
  
  public Vector() {
    x = 0;
    y = 0;
    z = 0;
  }
  
  public Vector(float _x, float _y) {
    x = _x;
    y = _y;
    z = 0;
  }
  
  public Vector(float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
  }
  
  public Vector projectToPlane(Vector normal) {
    Vector tmp = projectToLine(normal);
    return new Vector(x-tmp.x, y-tmp.y, z-tmp.z);
  }
  
  public Vector projectToLine(Vector directional) {
    float tmp = this.dot(directional);
    tmp /= directional.magnitudeSquared();
    return new Vector(directional.x*tmp, directional.y*tmp, directional.z*tmp);
  }
  
  public float magnitude() {
    return sqrt(x*x + y*y + z*z);
  }
  
  public float magnitudeSquared() {
    return x*x + y*y + z*z;
  }
  
  public void normalize() {
    float len = this.magnitude();
    x /= len;
    y /= len;
    z /= len;
  }
  
  public void limit(float max) {
    float mag = this.magnitude();
    if (mag > max) {
      this.mul(max / mag);
    }
  }
  
  public float dot(Vector vec) {
    return x*vec.x + y*vec.y + z*vec.z;
  }
  
  public float angle(Vector vec) {
    return acos((this.dot(vec)/(this.magnitude()*vec.magnitude())));
  }
  
  public void add(Vector vec) {
    x += vec.x;
    y += vec.y;
    z += vec.z;
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
}

public float distance(Vector v1, Vector v2) {
  return sqrt(pow(v1.x-v2.x,2) + pow(v1.y-v2.y,2) + pow(v1.z-v2.z,2));
}
