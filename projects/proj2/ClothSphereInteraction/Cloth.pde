class Cloth {
  Vector pos = new Vector(0, 0, 0);
  int width = 20;
  int height = 20;
  float strandLen = 10;  // distance between each point mass vertically and horizontally
  float pointRadius = 1;
  float pointMass = 0.9;
  Point[][] points;
  ArrayList<Spring> springs = new ArrayList();
  
  Cloth(int w, int h) {
    width = w;
    height = h;
    initCloth();
  }
  
  Cloth(Vector _pos, int w, int h, float l) {
    pos = _pos;
    width = w;
    height = h;
    strandLen = l;
    initCloth();
  }
  
  // Called by constructor to initialize points and springs that make up cloth
  private void initCloth() {
    // Initialize points array
    initPoints();
    // Add forces
    addParallelForces();
    addDiagonalForces();
    addBendingForces();
  }
  
  // Called by physics engine to update state of cloth by a timestep
  void update(float dt){
    // Compute (damped) Hooke's law for each spring
    for (Spring s : springs) {
      Vector acc = s.getForce();
      Point p1 = s.p1;
      if (!p1.isAnchor) eulerianIntegration(p1, acc, dt);
    }
  }
  
  // Called by physics engine to display cloth state in Processing
  void render() {
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        Point p = points[i][j];
        // Render point
        //renderPoint(p);  
   
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
  
  // Called by physics engine to handle collisions with world (ceiling, floor, left, right)
  void handleWorldCollisions(Vector dim) {
    Point p;
    float kbounce = 0.4;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        p = points[i][j];
        if (p.pos.x > dim.x) {
          // right
          p.pos.x = dim.x;
          p.vel.x *= kbounce;
        } else if (p.pos.x < 0) {
          // left
          p.pos.x = 0;
          p.vel.x *= kbounce;
        } else if (p.pos.y > dim.y) {
          // ceiling
          p.pos.y = dim.y;
          p.vel.y *= kbounce;
        } else if (p.pos.y < 0) {
          // floor
          p.pos.y = 0;
          p.vel.y *= kbounce;
        } else if (p.pos.z > dim.z) {
          // forward
          p.pos.z = dim.z;
          p.vel.z *= kbounce;
        } else if (p.pos.z < 0) {
          // back
          p.pos.z = 0;
          p.vel.z *= kbounce;
        }
      }
    }
  }
  
  // Called by physics engine to handle collisions with sphere sitting on floor
  void handleSphereCollisions(Vector pos, float r) {
    Point p;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        p = points[i][j];
        if (isSphereCollision(p, pos, r)) {
          handleSphereCollision(p, pos, r);
        }
      }
    }
  }
  
  // Helper function for handleSphereCollision() to detect point collision with sphere
  boolean isSphereCollision(Point p, Vector spherePos, float sphereRad) {
    return Vector.distance(p.pos, spherePos) < sphereRad;
  }
  
  // Helper function for handleSphereCollisions() to handle point collision with sphere
  // Entirely based off "sphere collision code" example in 05RigidBodies lecture slides
  void handleSphereCollision(Point p, Vector spherePos, float sphereRad) {
    float kbounce = 0.1;
    Vector normal = Vector.sub(p.pos, spherePos);
    normal.normalize();
    p.pos = Vector.add(spherePos, Vector.mul(normal, sphereRad*1.01));
    Vector vNorm = Vector.mul(normal, p.vel.dot(normal));  // stoping
    p.vel.sub(Vector.mul(vNorm, kbounce));
    return;
  }
  
  // Helper function for initCloth() to initialize points array
  private void initPoints() {
    points = new Point[width][height];
    Point p;
    Vector pPos;
    for (int i=0; i < width; i++) {
      for (int j=0; j < height; j++) {
        // Initialize point (no anchors)
        pPos = new Vector(pos.x+(strandLen*i), pos.y, pos.z+(strandLen*j));
        p = new Point(pPos, pointRadius, pointMass);
        points[i][j] = p;
      }
    }
  }
  
  // Helper function for initCloth() to create all vertical and horizontal (structural) spring forces
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
  
  // Helper function for initCloth() to create all diagonal spring forces
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
  
  // Helper function for initCloth() to create all bending spring forces
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
  
  // Helper function for render() to render each point
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
  
  // Helper function for update() to advance state of cloth by timestep
  private void eulerianIntegration(Point p, Vector acc, float dt) {
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
