/*********************************
 * Render
 * 
 * the main render() method within draw, and its helper functions
 ********************************/

void render() {
  fill(0,0,0);
  
  // render the point masses -- VERY SLOW
  //for (int i = 0; i < CLOTH_WIDTH; i++) {
  //  for (int j = 0; j < CLOTH_WIDTH; j++) {
  //    pushMatrix();
  //    translate(points[i][j].pos.x, points[i][j].pos.y, points[i][j].pos.z);
  //    sphere(r);
  //    popMatrix();
  //  }
  //}
  
  // render the lines
  for (int i = 0; i < CLOTH_WIDTH; i++) {
    for (int j = 0; j < CLOTH_WIDTH; j++) {
      if (i < CLOTH_WIDTH - 1)
        line(points[i][j].pos.x, points[i][j].pos.y, points[i][j].pos.z, points[i+1][j].pos.x, points[i+1][j].pos.y, points[i+1][j].pos.z);
      if (j < CLOTH_WIDTH - 1)
        line(points[i][j].pos.x, points[i][j].pos.y, points[i][j].pos.z, points[i][j+1].pos.x, points[i][j+1].pos.y, points[i][j+1].pos.z);
    }
  }
}
