// simulation constants
float MAX_DENSITY = 1000;
int N = 128;                 // how many boxes in each row and col - ther higher the better, but slower)
int ITER = 16;               // how many iteration to run Gauss-Seidel relaxation - the higher the more accurate, but slower :/
int RES = 4;                 // how big each box is in pixel - the smaller the better, but hard to see.
float DIFF = 0;            // diffuse rate, needs tuning
float VISC = 0.0000001f;              // viscocity rate, needs tuning
float dt = 0.2;          // timestep
Fluid fluid;
float t = 0;

// how much density to add to fluid at each mouse update
float delta = 200f;

void settings() {
  size((N-2)*RES, (N-2)*RES);
}

void setup() {
  fluid = new Fluid(N, DIFF, VISC, dt);
}

void mouseDragged() {
  int x = int(map(mouseX, 0, width, 1, N-2));
  int y = int(map(mouseY, 0, height, 1, N-2));
  
  int startX = constrain(x-1, 1, N-2);
  int endX = constrain(x+1, 1, N-2);
  
  int startY = constrain(y-1, 1, N-1);
  int endY = constrain(y+1, 1, N-1);
  
  // add density based on mouse position
  for (int i = startX; i <= endX; i++) {
    for (int j = startY; j <= endY; j++) {
      fluid.addDensity(i, j, delta);
    }
  }
  
  for (int i = 0; i < 2; i++) {
    float angle = noise(t) * TWO_PI * 2;
    PVector v = PVector.fromAngle(angle);
    v.mult(0.2);
    t += 0.01;
    fluid.addVel(x, y, v.x, v.y);
  }
  
  // add velocity
  //fluid.addVel(x, y, 0, -100);
}

void draw() {
  background(0);
  fluid.step(ITER);
  fluid.render();
  fluid.dissolve(-1);
  surface.setTitle("FPS: " + round(frameRate));
}
