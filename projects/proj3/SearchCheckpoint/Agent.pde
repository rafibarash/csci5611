class Agent {
  Vector pos;
  Vector vel = new Vector();
  Vector acc = new Vector();
  Vector goalPos = new Vector();
  float maxSpeed = 4;
  float maxForce = 0.1;
  
  Agent(Vector _pos) {
    pos = _pos;
  }
  
  Agent withGoalPos(Vector pos) {
    goalPos = pos;
    return this;
  }
  
  void render() {
    fill(0, 255, 0);
    square(pos.x, pos.y, 5);
  }
  
  void update(float dt) {
    // TODO: call planning algorithm to find next desired state, update pos towards that state
    addForceTowardsGoal();
    eulerianIntegration(dt);
  }
  
  String getPosition() {
    return "<" + pos.x + ", " + pos.y + ">";
  }
  
  private void addForceTowardsGoal() {
    Vector desired = Vector.sub(goalPos,pos);

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
