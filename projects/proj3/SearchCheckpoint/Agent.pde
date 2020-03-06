class Agent extends Object {
  Vector pos;
  Vector vel = new Vector();
  Vector acc = new Vector();
  Vector initPos;
  Vector goalPos;
  Vector nodePointingTowards;
  float maxSpeed = 5;
  float maxForce = 0.1;
  boolean isDead = false;
  
  Agent(Vector _initPos, Vector _goalPos) {
    pos = _initPos.copy();
    initPos = _initPos;
    goalPos = _goalPos;
    // Initialize nodePointingTowards
    nodePointingTowards = physics.getRandomEdgeNode(initPos);
  }
  
  void render() {
    fill(0, 255, 0);
    if (isDead) {
      fill(0);
      stroke(0);
    }
    square(pos.x, pos.y, 5);
  }
  
  void update(float dt) {
    // TODO: call planning algorithm to find next desired state, update pos towards that state
    //addForceTowardsTarget(goalPos);
    addForceTowardsNodePointingTowards();
    eulerianIntegration(dt);
    // Check if dead
    if (pos.distance(goalPos) < 1) {
      isDead = true;
    }
  }
  
  String getPosition() {
    return "<" + round(pos.x) + ", " + round(pos.y) + ">";
  }
  
  // Follows constructed graph to go towards random neighbor
  private void addForceTowardsNodePointingTowards() {
    // Check if straightline towards goalPos (PATH SMOOTHING)
    if (physics.collisionFreePath(pos, goalPos)) {
      nodePointingTowards = goalPos;
    } else {
      // If near nodePointingTowards, set new nodePointingTowards from graph
      if (pos.distance(nodePointingTowards) < 1) {
        nodePointingTowards = physics.getRandomEdgeNode(nodePointingTowards);
      }
    }
    // Add force in direction of nodePointingTowards
    addForceTowardsTarget(nodePointingTowards);
  }
  
  // Adding force towards goal, without accounting for any obstacles
  private void addForceTowardsTarget(Vector target) {
    Vector desired = Vector.sub(target,pos);

    // The distance is the magnitude of
    // the vector pointing from
    // location to target.
    float d = desired.magnitude();
    desired.normalize();
    // If we are closer than 100 pixels...
    if (d < 75) {
      //[full] ...set the magnitude
      // according to how close we are.
      float m = map(d,0,100,0,maxSpeed);
      desired.mul(m);
      //[end]
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
}
