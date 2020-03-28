class Agent extends Object {
  Vector pos;
  Vector vel = new Vector();
  Vector acc = new Vector();
  Vector colr;
  Vector initPos;
  Vector goalPos;
  ArrayList<Vector> path;
  int curPathNodeIndex = 0;
  float maxSpeed = 7;
  float maxForce = 0.8;
  boolean isDead = false;
  
  Agent(Vector _initPos, Vector _goalPos) {
    pos = _initPos.copy();
    initPos = _initPos;
    goalPos = _goalPos;
    colr = new Vector(random(255), random(255), random(255));
  }
  
  void render() {
    renderAgent();
    if (physics.roadmap != null) {
      renderLineToNextNode();
    }
  }
  
  void renderAgent() {
    fill(colr.x, colr.y, colr.z);
    noStroke();
    if (isDead) {
      fill(0);
      stroke(0);
    }
    square(pos.x, pos.y, obstacleRad/1.5);
  }
  
  void renderLineToNextNode() {
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
  
  //void renderPath() {
  //  // Render full path
  //  Vector prevNode = initPos;
  //  for (Vector nextNode : path) {
  //    stroke(colr.x, colr.y, colr.z);
  //    line(prevNode.x, prevNode.y, nextNode.x, nextNode.y);
  //    prevNode = nextNode;
  //  }
  //}
  
  void update(float dt) {
    addForceTowardsNodePointingTowards();
    eulerianIntegration(dt);
    // Check if dead
    //if (pos.distance(goalPos) < 1) {
    //  isDead = true;
    //}
  }
  
  String getPosition() {
    return "<" + round(pos.x) + ", " + round(pos.y) + ">";
  }
  
  // Follows constructed graph to go towards random neighbor
  private void addForceTowardsNodePointingTowards() {
    // Try to path smooth to highest node in path available
    for (int i = path.size() - 1; i > curPathNodeIndex; i--) {
      if (physics.collisionFreePath(pos, path.get(i))) {
        curPathNodeIndex = i;
        break;
      }
    }
    //addForceTowardsTarget(nodePointingTowards);
    addForceTowardsTarget(path.get(curPathNodeIndex));
    //if (physics.collisionFreePath(pos, goalPos)) {
    //  addForceTowardsTarget(goalPos);
    //} else {
    //  // If near curPathNode, update index to next node
    //  if (pos.distance(path.get(curPathNodeIndex)) < 0.5) {
    //    curPathNodeIndex++;
    //  }
    //  // Add force in direction of nodePointingTowards
    //  addForceTowardsTarget(path.get(curPathNodeIndex));
    //}
  }
  
  // Adding force towards goal, without accounting for any obstacles
  private void addForceTowardsTarget(Vector target) {
    Vector desired = Vector.sub(target,pos);

    // The distance is the magnitude of the vector pointing from
    // a position to target.
    float d = desired.mag();
    desired.normalize();
    // If we are closer than 100 pixels...
    //if (d < 30) {
    //  // set the magnitude according to how close we are.
    //  float m = map(d,0,100,0,maxSpeed);
    //  desired.mul(m);
    //} else {
    //  // Otherwise, proceed at maximum speed.
    //  desired.mul(maxSpeed);
    //}
    
    desired.mul(maxSpeed);

    // The usual steering = desired - velocity
    Vector steer = Vector.sub(desired,vel);
    steer.limit(maxForce);
    acc.add(steer);
  }
  
  private void eulerianIntegration(float dt) {
    vel.add(Vector.mul(acc, dt));
    vel.limit(maxSpeed);
    pos.add(Vector.mul(vel, dt));
    acc.mul(0);
  }
  
 /*********************************
 * Getters and Setters
 ********************************/
 
 void setPath(ArrayList<Vector> newPath) {
   path = newPath;
 }
}
