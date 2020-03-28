class Agent extends Object {
  Vector pos;
  Vector vel = new Vector();
  Vector acc = new Vector();
  Vector initPos;
  Vector goalPos;
  ArrayList<Vector> path;
  int curPathNodeIndex = 0;
  float maxSpeed = 4;
  float maxForce = 0.1;
  boolean isDead = false;
  
  Agent(Vector _initPos, Vector _goalPos) {
    pos = _initPos.copy();
    initPos = _initPos;
    goalPos = _goalPos;
  }
  
  void render() {
    fill(0, 255, 0);
    if (isDead) {
      fill(0);
      stroke(0);
    }
    square(pos.x, pos.y, obstacleRad/2);
  }
  
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
    // Check if straightline towards goalPos (PATH SMOOTHING)
    if (physics.collisionFreePath(pos, goalPos)) {
      addForceTowardsTarget(goalPos);
    } else {
      // If near curPathNode, update index to next node
      if (pos.distance(path.get(curPathNodeIndex)) < 0.5) {
        curPathNodeIndex++;
      }
      // Add force in direction of nodePointingTowards
      addForceTowardsTarget(path.get(curPathNodeIndex));
    }
  }
  
  // Adding force towards goal, without accounting for any obstacles
  private void addForceTowardsTarget(Vector target) {
    Vector desired = Vector.sub(target,pos);

    // The distance is the magnitude of the vector pointing from
    // a position to target.
    float d = desired.mag();
    desired.normalize();
    // If we are closer than 100 pixels...
    if (d < 30) {
      // set the magnitude according to how close we are.
      float m = map(d,0,100,0,maxSpeed);
      desired.mul(m);
    } else {
      // Otherwise, proceed at maximum speed.
      desired.mul(maxSpeed);
    }

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
