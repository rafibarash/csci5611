class Agent extends Object {
  Vector vel = new Vector();
  Vector acc = new Vector();
  Vector colr;
  Vector initPos;
  Vector goalPos;
  ArrayList<Vector> path;
  int curPathNodeIndex = 0;
  float targetSpeed = 10;
  float maxForce = 1000;
  
  Agent(Vector _initPos, Vector _goalPos) {
    super(_initPos.copy(), 15);
    initPos = _initPos;
    goalPos = _goalPos;
    colr = new Vector(random(255), random(255), random(255));
  }
  
  /***********************************
   * Public Methods
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
        numObstacleCollisions++;
      }
    }
    
    // Check for wall collision
    // Top
    if (pos.y < 0 + radius/2) numObstacleCollisions++;
    // Bottom
    if (pos.y > height - radius/2) numObstacleCollisions++;
    // Left
    if (pos.x < 0 + radius/2) numObstacleCollisions++;
    // Right
    if (pos.x > height - radius/2) numObstacleCollisions++;
    
    // Check for collisions with other agents
    for (Agent a : agents) {
      if (isCollision(a)) {
        numAgentCollisions++;
      }
    }
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
    // Compute normalized and tuned vector towards goal
    Vector desired = Vector.sub(path.get(curPathNodeIndex), pos);
    desired.normalize();
    desired.mul(targetSpeed);
    // Add force towards node
    Vector force = Vector.sub(desired, vel);
    applyForce(force);
  }
  
  private void addObstacleForces() {
    // Loop through obstacles and add force based on distance
    float kRad = 15;  // only apply force if kRad away
    float k = 0.5;  // tuning parameter
    //int count = 1;
    for (Obstacle o : obstacles) {
      if (pos.distance(o.pos) < kRad + radius/2 + o.radius/2) {
        // Calculate vector pointing away from obstacle
        float d = pos.distance(o.pos) - o.radius/2 - radius/2;
        Vector diff = Vector.sub(pos, o.pos);
        diff.normalize();
        diff.div(d);  // weight by distance
        diff.mul(k);
        applyForce(diff);
      }
    }
  }
  
  private void addWallForce() {
    float rad = 50;
    float k = 30;
    Vector steer = new Vector();
    // Top
    if (pos.y < rad) {
      // Calculate vector pointing away from wall
      float d = pos.y - radius/2;
      Vector diff = Vector.sub(pos, new Vector(pos.x, radius/2));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    // Bottom
    else if (pos.y > height - rad) {
      // Calculate vector pointing away from wall
      float d = height - pos.y - radius/2;
      Vector diff = Vector.sub(pos, new Vector(pos.x, height - radius/2));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    // Left
    else if (pos.x < rad) {
      // Calculate vector pointing away from wall
      float d = pos.x - radius/2;
      Vector diff = Vector.sub(pos, new Vector(radius/2, pos.y));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    // Right
    else if (pos.x > width - rad) {
      // Calculate vector pointing away from wall
      float d = width - pos.x - radius/2;
      Vector diff = Vector.sub(pos, new Vector(width - radius/2, pos.y));
      diff.normalize();
      diff.div(d);  // weight by distance
      diff.mul(k);
    }
    applyForce(steer);
  }
  
  private void eulerianIntegration(float dt) {
    vel.add(Vector.mul(acc, dt));
    pos.add(Vector.mul(vel, dt));
    acc.mul(0);
  }
  
  // Check if object lands inside circle
  private boolean isCollision(Object otherObj) {
    return otherObj != this && !isDead && !otherObj.isDead && pos.distance(otherObj.pos) < otherObj.radius/2 + radius/2;
  }
  
 /*********************************
 * Getters and Setters
 ********************************/
 
 void setPath(ArrayList<Vector> newPath) {
   path = newPath;
 }
}
