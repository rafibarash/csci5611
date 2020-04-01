// Boids Parameters
float flockRadius = 20;

// Followed boids conceptual explanation here - https://www.red3d.com/cwr/boids/
// When my simulation was spazzing out, updated some math from here - https://www.processing.org/examples/flocking.html
void addBoidsForces(Agent a) {
  // Calculate three steering behaviors
  Vector sep = separation(a);
  Vector align = alignment(a);
  Vector coh = cohesion(a);
  
  // Apply forces to agent
  a.applyForce(sep);
  //a.applyForce(align);
  //a.applyForce(coh);
}

// Separation: steer to avoid crowding local flockmates
Vector separation(Agent a1) {
  // loop through agents and if other agent in neighborhood, add to steering force
  Vector sep = new Vector();
  float k = 1;
  int count = 0;
  for (Agent a2 : agents) {
    if (inNeighborhood(a1, a2)) {
      // Calculate vector pointing away from other agent
      float d = a1.distance(a2) - a1.radius/2 - a2.radius/2;
      if (d < 0) {
        d = 0.0001;
      }
      Vector away = Vector.sub(a1.pos, a2.pos);
      away.normalize();
      away.div(d);  // weight by distance
      sep.add(away);
      count++;
    }
  }
  // Calculate separation force
  if (count > 0) {
    sep.div(count);
  }
  
  if (sep.mag() > 0) {
    sep.normalize();
    sep.mul(k);
  }
  return sep;
}

// Alignment: steer towards the average heading of local flockmates
Vector alignment(Agent a1) {
  // loop through agents and if other agent in neighborhood, add to avg vel
  Vector align = new Vector();
  Vector avgVel = new Vector();
  float k = 1;
  int count = 0;
  for (Agent a2 : agents) {
    if (inNeighborhood(a1, a2)) {
      // Add that velocity to avg
      avgVel.add(a2.vel);
      count++;
    }
  }
  // Add steering force towards avg vel
  if (count > 0) {
    avgVel.div(count);
    avgVel.normalize();
    avgVel.mul(k);
  }
  return align;
}

// Cohesion: steer to move toward the average position of local flockmates
Vector cohesion(Agent a1) {
  // loop through agents and if other agent in neighborhood, add to avg pos
  Vector coh = new Vector();
  Vector avgPos = new Vector();
  float k = 1;
  int count = 0;
  for (Agent a2 : agents) {
    if (inNeighborhood(a1, a2)) {
      // Add pos to avg pos
      avgPos.add(a2.pos);
      count++;
    }
  }
  // Add seeking force towards avg position
  if (count > 0) {
    avgPos.div(count);
    Vector desired = Vector.sub(avgPos, a1.pos);
    desired.normalize();
    desired.mul(k);
  }
  return coh;
}

// Helper method for all three steering behaviors
boolean inNeighborhood(Agent a1, Agent a2) {
  return a1 != a2 && a1.pos.distance(a2.pos) - a1.radius/2 - a2.radius/2 < flockRadius;
}
