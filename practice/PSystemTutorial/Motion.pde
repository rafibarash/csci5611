// Eulerian Integration
// Determine new position & velocity via integrals
// y(t+1) = y(t) + y'(t)*dt
void numericalIntegration(PVector pos, PVector vel, PVector acc, float dt) {
  // TODO: Optimize and use half timestep for eulerian integration
  pos.add(PVector.mult(vel, dt));
  vel.add(PVector.mult(acc, dt));
  acc.mult(0); // clear acceleration
}
