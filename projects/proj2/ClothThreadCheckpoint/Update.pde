/*********************************
 * Update
 * 
 * the main update() method within draw, and its helper functions
 ********************************/
 
void update(float dt){
  //Compute (damped) Hooke's law for each spring
  for (int i = 0; i < CLOTH_WIDTH; i++) {
    for (int j = 0; j < CLOTH_WIDTH; j++) {
      if (points[i][j].isAnchor) continue;
      Vector acc = getSpringForcePoint(points[i][j]);
      acc.scalarMul(1/m);
      
      // Eulerian integration (now without wind contribution)
      acc.add(g);
      wind = new Vector(random(1, 2) * -7.5, 0, 0);
      acc.add(wind);
      acc.scalarMul(dt);
      points[i][j].vel.add(acc);
      Vector curVel = points[i][j].vel.copy();
      curVel.scalarMul(dt);
      points[i][j].pos.add(curVel);
    }
  }
}
