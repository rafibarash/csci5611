class Cloth {
  Vector pos = new Vector(0, 0, 0);
  int width = 20;
  int height = 20;
  float strandLen = 10;  // distance between each point mass vertically and horizontally
  float pointRadius = 1;
  float pointMass = 0.9;
  Point[][] points;
  ArrayList<Spring> springs = new ArrayList();
  
  Cloth() {
    initCloth();
  }
  
  Cloth(int w, int h) {
    width = w;
    height = h;
    initCloth();
  }
  
  private void initCloth() {
    // Initialize points array
    initPoints();
    // Add forces
    addParallelForces();
    // Commenting these other forces out because they make the hanging cloth too rigid
    addDiagonalForces();
    addBendingForces();
  }
  
  private void initPoints() {
    points = new Point[width][height];
    Point p;
    Vector pPos;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        // Initialize point
        pPos = new Vector(pos.x+(strandLen*i), pos.y, pos.z+(strandLen*j));
        p = new Point(pPos, pointRadius, pointMass);
        // Set top anchor points
        if (j == 0 && i == 0 || j == 0 && i == width-1) {
          p.isAnchor = true;
        }
        points[i][j] = p;
      }
    }
  }
  
  // Create all vertical and horizontal (structural) spring forces
  private void addParallelForces() {
    Point p;
    Spring s;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        p = points[i][j];
        
        if (j > 0) {
          // Top force
          s = new Spring(p, points[i][j-1], strandLen);
          springs.add(s);
        }
        if (j < height - 1) {
          // Bottom force
          s = new Spring(p, points[i][j+1], strandLen);
          springs.add(s);
        }
        if (i > 0) {
          // Left force
          s = new Spring(p, points[i-1][j], strandLen);
          springs.add(s);
        }
        if (i < width - 1) {
          // Right force
          s = new Spring(p, points[i+1][j], strandLen);
          springs.add(s);
        }
      }
    }
  }
  
  // Create all diagonal spring forces
  private void addDiagonalForces() {
    Point p;
    Spring s;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        p = points[i][j];
        if (i < width-1 && j > 0) {
          // top right
          s = new Spring(p, points[i+1][j-1], strandLen * sqrt(2));
          springs.add(s);
        }
        if (i > 0 && j > 0) {
          // top left
          s = new Spring(p, points[i-1][j-1], strandLen * sqrt(2));
          springs.add(s);
        }
        if (i > 0 && j < height-1) {
          // bottom left
          s = new Spring(p, points[i-1][j+1], strandLen * sqrt(2));
          springs.add(s);
        }
        if (i < width-1 && j < height-1) {
          // bottom right
          s = new Spring(p, points[i+1][j+1], strandLen * sqrt(2));
          springs.add(s);
        }
      }
    }
  }
  
  // Create all bending spring forces
  private void addBendingForces() {
    Point p;
    Spring s;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        p = points[i][j];
        if (j > 1) {
          // up
          s = new Spring(p, points[i][j-2], strandLen * 2);
          springs.add(s);
        }
        if (j < height - 2) {
          // down
          s = new Spring(p, points[i][j+2], strandLen * 2);
          springs.add(s);
        }
        if (i > 1) {
          // left
          s = new Spring(p, points[i-2][j], strandLen * 2);
          springs.add(s);
        }
        if (i < width - 2) {
          // right
          s = new Spring(p, points[i+2][j], strandLen * 2);
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
  
  void renderTexture() {
    textureMode(NORMAL);
    noStroke();
    noFill();
    // we will render triangle strips, then use uv mapping to map it to texture.jpg
    for (int i=0; i < width-1; i++) {
      beginShape(TRIANGLE_STRIP);
      texture(clothTex);
      for (int j=0; j < height; j++) {
        float u1 = map(i, 0, width-1, 0, 1);
        float u2 = map(i+1, 0, width-1, 0, 1);
        float v = map(j, 0, height-1, 0, 1);
        vertex(points[i][j].pos.x, points[i][j].pos.y, points[i][j].pos.z, u1, v);
        vertex(points[i+1][j].pos.x, points[i+1][j].pos.y, points[i+1][j].pos.z, u2, v);
      }
      endShape();
    }
  }
  
  void render() {
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        Point p = points[i][j];
        // Render point
        renderPoint(p);  
   
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
  
  private void renderPoint(Point p) {
    // not really working with spheres rn cause of how slow it makes the sim
    //pushMatrix();
    //translate(p.pos.x, p.pos.y, p.pos.z);
    //noStroke();
    //fill(0);
    //sphere(p.radius);
    //popMatrix();
    vertex(p.pos.x, p.pos.y, p.pos.z);
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
