class Physics {
  Vector dim = new Vector(800, 400, 800);  // world dimensions
  Cloth cloth = new Cloth(new Vector(0, 150, 0), CLOTH_WIDTH, CLOTH_HEIGHT, STRAND_LEN);
  Vector spherePos = new Vector(STRAND_LEN*CLOTH_WIDTH/2, 350, STRAND_LEN*CLOTH_WIDTH/2);
  float sphereRadius = 50;
  Vector gravity = new Vector(0, 9.81, 0);
  //Vector wind = new Vector(random(1, 2) * -1.5, 0, 0);
  Vector wind = new Vector(0, 0, 0);
  
  void update(float dt){
    cloth.update(dt);
    cloth.handleWorldCollisions(dim);
    cloth.handleSphereCollisions(spherePos, sphereRadius);
  }
  
  void render() {
    // Floor
    fill(0, 255, 0);
    pushMatrix();
    translate(0, 402, 0); 
    box(800, 2, 800);
    popMatrix();
    // Sphere
    fill(153, 51, 255);
    noStroke();
    pushMatrix();
    translate(spherePos.x, spherePos.y, spherePos.z);
    sphere(sphereRadius);
    popMatrix();
    // Cloth
    cloth.render();
  }
}
