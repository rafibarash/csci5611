class Agent extends Object {
  Vector vel = new Vector();
  Vector acc = new Vector();
  Vector colr;
  Vector initPos;
  Vector goalPos;
  ArrayList<Vector> path;
  int curPathNodeIndex = 0;
  //float maxForce = 0.8;
  float maxForce = 10000;
  
  Agent(Vector _initPos, Vector _goalPos) {
    super(_initPos.copy(), 15);
    initPos = _initPos;
    goalPos = _goalPos;
    colr = new Vector(random(255), random(255), random(255));
  }
  
  /***********************************
   * Pulbic Methods
   **********************************/
  
  void render() {
    renderAgent();
    if (physics.roadmap != null) {
      renderLineToNextNode();
    }
  }
  
  void update(float dt) {
    applyForces();
    handleCollisions();
    eulerianIntegration(dt);
    // Check if dead
    if (pos.distance(goalPos) < radius) {
      isDead = true;
    }
  }
  
  void applyForce(Vector force) {
    force.limit(maxForce);
    acc.add(force);
  }
  
  // Distance
  float distance(Agent a1) {
    return pos.distance(a1.pos);
  }
  
  String getPosition() {
    return "<" + round(pos.x) + ", " + round(pos.y) + ">";
  }

   /*********************************
   * Private Methods
   ********************************/
  
   private void renderAgent() {
    fill(colr.x, colr.y, colr.z);
    noStroke();
    if (isDead) {
      fill(0);
      stroke(0);
    }
    circle(pos.x, pos.y, radius);
    //float theta = vel.dirXY() + radians(90);
    //pushMatrix();
    //translate(pos.x, pos.y);
    //rotate(theta);
    //beginShape(TRIANGLES);
    //vertex(0, -radius*2);
    //vertex(-radius, radius*2);
    //vertex(radius, radius*2);
    //endShape();
    //popMatrix();
  }
  
  private void renderLineToNextNode() {
    // Render line to next node
    Vector nextNode = path.get(curPathNodeIndex);
    stroke(colr.x, colr.y, colr.z);
    line(pos.x, pos.y, nextNode.x, nextNode.y);
    
    // draw a triangle at next node for arrow like line
    // Followed the code here - https://processing.org/discourse/beta/num_1219607845.html
    pushMatrix();
    translate(nextNode.x, nextNode.y);
    float a = atan2(pos.x-nextNode.x, nextNode.y-pos.y);
    rotate(a);
    line(0, 0, -10, -10);
    line(0, 0, 10, -10);
    popMatrix();
  }
  
  private void applyForces() {
    addBoidsForces(this);
    addObstacleForces();
    addWallForce();
    addForceTowardsNextNode();
  }
  
  private void handleCollisions() {
    // Check for collisions with obstacles
    for (Obstacle o : obstacles) {
      if (isCollision(o)) {
        numCollisions++;
        //handleCollision(o);
      }
    }
    // Check for collisions with other agents
    //for (Agent a : agents) {
    //  if (isCollision(a)) {
    //    numCollisions++;
    //  }
    //}
  }
  
  // Handle agent collision with sphere
  // Entirely based off "sphere collision code" example in 05RigidBodies lecture slides
  private void handleCollision(Object o) {
    float kbounce = 0.1;
    Vector normal = Vector.sub(pos, o.pos);
    normal.normalize();
    pos = Vector.add(o.pos, Vector.mul(normal, radius*1.01));
    Vector vNorm = Vector.mul(normal, vel.dot(normal));  // stoping
    vel.sub(Vector.mul(vNorm, kbounce));
    // add friction
    vel.sub(Vector.mul(normal, 2));
    
    // change node pointing towards
    if (curPathNodeIndex > 0) curPathNodeIndex--;
  }
  
  // Follows constructed graph to go towards random neighbor
  private void addForceTowardsNextNode() {
    // Try to path smooth to highest node in path available
    for (int i = path.size() - 1; i > curPathNodeIndex; i--) {
      if (physics.collisionFreePath(pos, path.get(i))) {
        curPathNodeIndex = i;
        break;
      }
    }
    // Add the force towards this node
    float k = 10;
    addForceTowardsTarget(pos, path.get(curPathNodeIndex), k);
  }
  
  private void addObstacleForces() {
    // Loop through obstacles and add force based on distance
    float kRad = 15;  // only apply force if kRad away
    float k = 0.03;  // tuning parameter
    //int count = 1;
    for (Obstacle o : obstacles) {
      if (pos.distance(o.pos) < kRad + radius + o.radius) {
        // Calculate vector pointing away from obstacle
        float d = pos.distance(o.pos);
        Vector diff = Vector.sub(pos, o.pos);
        diff.normalize();
        diff.div(d);  // weight by distance
        diff.mul(k);
        applyForce(diff);
      }
    }
  }
  
  private void addWallForce() {
    float rad = 30;
    float k = 10;
    float numForces = 3;
    Vector steer = new Vector();
    // Top
    if (pos.y < rad) {
      // Calculate vector pointing away from wall
      float d = pos.y - 0;
      Vector diff = Vector.sub(pos, new Vector(pos.x, 0));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    // Bottom
    else if (pos.y > height - rad) {
      // Calculate vector pointing away from wall
      float d = height - pos.y;
      Vector futurePos = pos.copy();         // want to point from wall to future pos
      futurePos.add(Vector.mul(vel, 0.01));  // integrate velocity and add to position to get future pos
      Vector diff = Vector.sub(futurePos, new Vector(pos.x, height));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    // Left
    else if (pos.x < rad) {
      // Calculate vector pointing away from wall
      float d = pos.x - 0;
      Vector futurePos = pos.copy();         // want to point from wall to future pos
      futurePos.add(Vector.mul(vel, 0.01));  // integrate velocity and add to position to get future pos
      Vector diff = Vector.sub(futurePos, new Vector(0, pos.y));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    // Right
    else if (pos.x > width - rad) {
      // Calculate vector pointing away from wall
      float d = width - pos.x;
      Vector futurePos = pos.copy();         // want to point from wall to future pos
      futurePos.add(Vector.mul(vel, 0.01));  // integrate velocity and add to position to get future pos
      Vector diff = Vector.sub(futurePos, new Vector(width, pos.y));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    for (int i=0; i < numForces; i++) {
      applyForce(steer);
    }
  }
  
  // Adding force towards goal, without accounting for any obstacles
  private void addForceTowardsTarget(Vector start, Vector target, float k) {
    Vector desired = getVecTowardsTarget(start, target, k);
    Vector f = getSteerForce(desired);
    applyForce(f);
  }
  
  // Compute normalized and tuned vector towards target
  private Vector getVecTowardsTarget(Vector start, Vector target, float k) {
    Vector desired = Vector.sub(target, start);
    desired.normalize();
    desired.mul(k);
    // this is target speed
    return desired;
  }
  
  // Given vector towards desired movement, generate force
  private Vector getSteerForce(Vector desired) {
    Vector force = Vector.sub(desired, vel);
    // add k
    return force;
  }
  
  private void eulerianIntegration(float dt) {
    vel.add(Vector.mul(acc, dt));
    pos.add(Vector.mul(vel, dt));
    acc.mul(0);
  }
  
  // Check if object lands inside circle
  private boolean isCollision(Object otherObj) {
    return !isDead && !otherObj.isDead && pos.distance(otherObj.pos) < otherObj.radius/2 + radius/2;
  }
  
 /*********************************
 * Getters and Setters
 ********************************/
 
 void setPath(ArrayList<Vector> newPath) {
   path = newPath;
 }
}
