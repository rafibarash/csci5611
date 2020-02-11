class Object {
  PShape shape;
  PVector pos;
  PVector size = new PVector(100, 100);
  float scale = 60;;
  
  Object(PVector pos, PShape shape) {
    this.pos = pos;
    this.shape = shape;
  }
  
  Object(PVector pos, PShape shape, float scale) {
    this.pos = pos;
    this.shape = shape;
    this.scale = scale;
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    scale(scale);
    rotateX(radians(180));
    rotateY(radians(180));
    shape(shape);
    popMatrix();
  }
}
