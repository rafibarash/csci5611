
// initializing the point mass array, equally distributed on a cloth
void initializePoints(float dist) {
  for (int i = 0; i < CLOTH_WIDTH; i++) {
    for (int j = 0; j < CLOTH_WIDTH; j++) {
      points[i][j] = new Point(dist * i, 0, dist * j, i, j);
    }
  }
  // set anchors
  //points[0][0].isAnchor = true;
  //points[CLOTH_WIDTH-1][0].isAnchor = true;
}

// calculate the spring force for point mass A, direction from A to B
Vector getSpringForce(Point a, Point b, float restingLength) {
  // first get the directional vector from a to b
  Vector dir = new Vector(b.pos.x-a.pos.x, b.pos.y-a.pos.y, b.pos.z-a.pos.z);
  // length of dir is the current length of this spring
  float springLen = dir.magnitude();
  // normalize it
  dir.normalize();
  // spring forces
  float sForce = k * (springLen - restingLength);
  float dForce = kd * (b.vel.dot(dir) - a.vel.dot(dir));
  dir.scalarMul(sForce + dForce);
  return dir;
}

// calculate the total vertical and horizontal spring forces for point mass A
Vector getSpringParallelForcePoint(Point a) {
  Vector result = new Vector();
  // a point mass may have up to 4 springs acting on it
  // each of them will exert a force that directed away from the point mass
  if (a.index[1] > 0) {
    Vector up = getSpringForce(a, points[a.index[0]][a.index[1]-1], l0);
    result.add(up);
  }
  if (a.index[1] < CLOTH_WIDTH-1) {
    Vector down = getSpringForce(a, points[a.index[0]][a.index[1]+1], l0);
    result.add(down);
  }
  if (a.index[0] > 0) {
    Vector left = getSpringForce(a, points[a.index[0]-1][a.index[1]], l0);
    result.add(left);
  }
  if (a.index[0] < CLOTH_WIDTH-1) {
    Vector right = getSpringForce(a, points[a.index[0]+1][a.index[1]], l0);
    result.add(right);
  }
  return result;
}

// calculate the total diagonal spring forces for point mass A
Vector getSpringDiagonalForcePoint(Point a) {
  Vector result = new Vector();
  // a point mass may have up to 4 springs acting on it
  // each of them will exert a force that directed away from the point mass
  if (a.index[0] < CLOTH_WIDTH-1 && a.index[1] > 0) {
    Vector ur = getSpringForce(a, points[a.index[0]+1][a.index[1]-1], l0 * sqrt(2));
    result.add(ur);
  }
  if (a.index[0] > 0 && a.index[1] > 0) {
    Vector ul = getSpringForce(a, points[a.index[0]-1][a.index[1]-1], l0 * sqrt(2));
    result.add(ul);
  }
  if (a.index[0] > 0 && a.index[1] < CLOTH_WIDTH-1) {
    Vector dl = getSpringForce(a, points[a.index[0]-1][a.index[1]+1], l0 * sqrt(2));
    result.add(dl);
  }
  if (a.index[0] < CLOTH_WIDTH-1 && a.index[1] < CLOTH_WIDTH-1) {
    Vector dr = getSpringForce(a, points[a.index[0]+1][a.index[1]+1], l0 * sqrt(2));
    result.add(dr);
  }
  return result;
}

// calculate the total bending spring forces for point mass A
Vector getSpringBendingForcePoint(Point a) {
  Vector result = new Vector();
  // a point mass may have up to 4 springs acting on it
  // each of them will exert a force that directed away from the point mass
  if (a.index[1] > 1) {
    Vector up = getSpringForce(a, points[a.index[0]][a.index[1]-2], 2*l0);
    result.add(up);
  }
  if (a.index[1] < CLOTH_WIDTH-2) {
    Vector down = getSpringForce(a, points[a.index[0]][a.index[1]+2], 2*l0);
    result.add(down);
  }
  if (a.index[0] > 1) {
    Vector left = getSpringForce(a, points[a.index[0]-2][a.index[1]], 2*l0);
    result.add(left);
  }
  if (a.index[0] < CLOTH_WIDTH-2) {
    Vector right = getSpringForce(a, points[a.index[0]+2][a.index[1]], 2*l0);
    result.add(right);
  }
  return result;
}

// calculate the total force acting on a point
Vector getSpringForcePoint(Point a) {
  Vector result = new Vector();
  result.add(getSpringParallelForcePoint(a));
  result.add(getSpringDiagonalForcePoint(a));
  //result.add(getSpringBendingForcePoint(a));
  return result;
}
