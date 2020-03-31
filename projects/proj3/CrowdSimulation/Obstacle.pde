class Obstacle extends Object {
  
  Obstacle(Vector _pos, float _radius) {
    super(_pos, _radius);
  }
  
  void render() {
    fill(100);
    noStroke();
    circle(pos.x, pos.y, radius);
  }
  
  // Checks if line made from two points intersects with circle
  // Thank you for the sample code to help with this!!
  boolean isCollision(Vector v1, Vector v2) {
    //Step 1: Compute V - a normalized vector pointing from the start of the linesegment to the end of the line segment
    Vector uv = Vector.sub(v2, v1);                                  // line direction vector
    Vector v = Vector.normalize(uv);                                // normalized line direction vector
  
    //Step 2: Compute W - a displacement vector pointing from the start of the line segment to the center of the circle
    Vector w = Vector.sub(pos, v1);
    
    //Step 3: Solve quadratic equation for intersection point (in terms of V and W)
    float a = 1;                                   //Length of V (we normalized it)
    float b = -2 * Vector.dot(v, w);               //-2*dot(V,W)
    float c = w.magSquared() - pow(radius, 2);     //difference of squared distances
    
    float d = b*b - 4*a*c; //discriminant 
    
    boolean colliding = false;
    
    if (d >=0 ){ 
      //If d is positive we know the line is colliding, but we need to check if the collision line within the line segment
      //  ... this means t will be between 0 and the lenth of the line segment
      float t = (-b - sqrt(d))/(2*a); //Optimization: we only need the first collision
      if (t > 0 && t < uv.mag()){
        colliding = true;
      }
    }
    
    return colliding;
  }
}
