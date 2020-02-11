import java.util.Iterator;

// GLOBALS
ArrayList<ParticleSystem> systems;
Repeller repeller;
 
// Processing function to configure project
void setup() {
  size(640,360);
  systems = new ArrayList();
  PImage smokeImg = loadImage("smoke.png");
  systems.add(new Fire(new PVector(width/1.5, height/2, 0), smokeImg));
  systems.add(new Water(new PVector(width/4, height/2, 0)));
  repeller = new Repeller(width/2-20, height/2, 0, 30, 100);
}
 
// Processing function that is called every frame
void draw() {
  background(255);
  Iterator<ParticleSystem> it = systems.iterator();
  while (it.hasNext()) {
    ParticleSystem ps = it.next();
    if (ps.type == PS_TYPE.WATER) {
      PVector gravity = new PVector(0, 0.1, 0);
      ps.applyForce(gravity);
    } else if (ps.type == PS_TYPE.FIRE) {
      //ps.applyRepeller(repeller);
      float dx = map(mouseX,0,width,-0.2,0.2);
      PVector wind = new PVector(dx,0, 0);
      ps.applyForce(wind);
    }
    ps.addParticle();
    ps.run();
    if (ps.isDead()) {
       it.remove();
    }
  }
  repeller.render();
}
