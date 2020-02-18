class Physics {
  Cloth cloth;
  Vector gravity = new Vector(0, 9.81, 0);
  //Vector wind = new Vector(random(1, 2) * -1.5, 0, 0);
  Vector wind = new Vector(0, 0, 0);
  
  Physics() {
    cloth = new Cloth(CLOTH_WIDTH, CLOTH_HEIGHT);
  }
  
  void update(float dt){
    cloth.update(dt);
  }
  
  void render(boolean withTex) {
    if (withTex) cloth.renderTexture();
    else cloth.render();
  }
}
