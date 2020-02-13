class Vector {
  
  public float x, y, z;
  
  public Vector() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
  }
  
  public Vector(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
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
  
  public void scalarMul(float s) {
    x *= s;
    y *= s;
    z *= s;
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
