class Cloth {
  Vector pos = new Vector(0, 0, 0);
  int width = 20;
  int height = 20;
  float strandLen = 10;  // distance between each point mass vertically and horizontally 
  float pointRadius = 10;
  Point[][] points;
  ArrayList<Spring> springs = new ArrayList();
  
  Cloth() {
    initCloth();
  }
  
  private void initCloth() {
    // Initialize points array
    initPoints();
    // Add forces
    addParallelForces();
  }
  
  private void initPoints() {
    points = new Point[width][height];
    Point p;
    Vector pPos;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        // Initialize point
        pPos = new Vector(pos.x+(strandLen*i), pos.y+(strandLen*j), pos.z);
        p = new Point(pPos);
        // Set top anchor points
        if (j == 0 && i == 0 || j == 0 && i == width-1) {
          p.isAnchor = true;
        }
        points[i][j] = p;
      }
    }
  }
  
  private void addParallelForces() {
    Point p;
    Spring s;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        p = points[i][j];
        // Add parallel (structural) forces
        if (j > 0) {
          // Top force
          s = new Spring(p, points[i][j-1]);
          springs.add(s);
        }
        if (j < height - 1) {
          // Bottom force
          s = new Spring(p, points[i][j+1]);
          springs.add(s);
        }
        if (i > 0) {
          // Left force
          s = new Spring(p, points[i-1][j]);
          springs.add(s);
        }
        if (i < width - 1) {
          // Right force
          s = new Spring(p, points[i+1][j]);
          springs.add(s);
        }
      }
    }
  }
  
  void update(float dt){
    // Compute (damped) Hooke's law for each spring
    for (Spring s : springs) {
      Vector acc = s.getForce();
      Point p1 = s.p1;
      if (!p1.isAnchor) eulerianIntegration(p1, acc, dt);
    }
  }
  
  void render() {
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        Point p = points[i][j];
        // Render point
        //pushMatrix();
        //translate(p.pos.x, p.pos.y, p.pos.z);
        //noStroke();
        //fill(0);
        //sphere(p.radius);
        //popMatrix();
        
        // Render vertical line
        stroke(0);
        if (j > 0) {
          line(p.pos.x, p.pos.y, p.pos.z, points[i][j-1].pos.x, points[i][j-1].pos.y, points[i][j-1].pos.z);
        }
        
        // Render horizontal line
        if (i > 0) {
          line(p.pos.x, p.pos.y, p.pos.z, points[i-1][j].pos.x, points[i-1][j].pos.y, points[i-1][j].pos.z);
        }
      }
    }
  }
  
  void eulerianIntegration(Point p, Vector acc, float dt) {
    // Divide acc by mass
    acc.div(p.mass);
    // Add gravity
    acc.add(physics.gravity);
    // Add wind
    acc.add(physics.wind);
    // Update point's velocity from acc
    p.vel.add(Vector.mul(acc, dt));
    // Update point's pos from velocity
    Vector curVel = Vector.mul(p.vel, dt);
    p.pos.add(curVel);
  }
}
