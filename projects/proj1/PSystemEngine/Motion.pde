// Eulerian Integration
// Determine new position & velocity via integrals
// y(t+1) = y(t) + y'(t)*dt
// Second order accurate
void numericalIntegration(PVector pos, PVector vel, PVector acc, float dt) {
  // TODO: Am i correctly doing this as eulerian integration?
  vel.add(PVector.mult(acc, dt));  // can just add acc since it is a constant
  PVector midVel = PVector.mult(vel, dt);
  PVector midAccVel = PVector.mult(acc, dt*dt/2);
  pos.add(midVel);
  pos.add(midAccVel);
  acc.mult(0); // clear acceleration
}

// Compute dot product of two vectors
float dotProduct(PVector p1, PVector p2) {
  return (p1.x * p2.x) + (p1.y * p2.y) + (p1.z + p2.z);
}

// Compute magnitude of a vector
float magnitude(PVector p) {
  return sqrt(dotProduct(p, p));
}

// Compute angle between two vectors
float angle(PVector p1, PVector p2) {
  return cos(dotProduct(p1, p2) / (magnitude(p1) * magnitude(p2)));    // is this right?
}

// Project vector p1 onto vector p2
PVector project(PVector p1, PVector p2) {
  return PVector.mult(p2, dotProduct(p1, p2));
}

// Bounce V - (1 + cor)B... cor = bounce coefficient
PVector bounce(PVector p1, PVector projection, float cor) {
  return PVector.sub(p1, PVector.mult(projection, 1 + cor));
}

// Normalizes vector - Finds vector in same direction with magnitude of 1
PVector normalize(PVector p) {
  return PVector.div(p, magnitude(p));
}

float distance(PVector p1, PVector p2) {
  return sqrt((p1.x - p2.x) * (p1.x - p2.x)  +
               (p1.y - p2.y) * (p1.y - p2.y) +
               (p1.z - p2.z) * (p1.z - p2.z));
  
}
