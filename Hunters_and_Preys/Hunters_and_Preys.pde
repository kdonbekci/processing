ArrayList<Hunter> hunters; //<>//
ArrayList<Prey> preys;
float t;
float hunter_size = 30;
float prey_size = 10;
int preyNo=1;

void setup() {

  size(800, 800);
  background(255);
  hunters  =new ArrayList<Hunter>();
  preys = new ArrayList<Prey>();
  hunters.add(new Hunter(50, 100, 300));
  t = 0;
}

void draw() {
  background(255);
  drawHunters();
  drawPreys();
  t += .005;
}
void drawPreys() {
  for (Prey p : preys) {
    p.run();
    fill(0);
    ellipse(p.pos.x, p.pos.y, prey_size, prey_size);
  }
}
void drawHunters() {
  for (Hunter h : hunters) { 
    h.hunt();
    fill(0);
    ellipse(h.pos.x, h.pos.y, hunter_size, hunter_size);
    noFill();

    //PVector arm = new PVector(h.dest.x, h.dest.y);
    //arm.sub(h.pos);
    //arm.normalize();
    //arm.mult(h.l);
    translate(h.pos.x, h.pos.y);
    bezier(0, 0, (noise(1, t)*h.arm.x)/4, (noise(2, t)*h.arm.y)/4, (noise(3, t)*3*h.arm.x)/4, (noise(4, t)*3*h.arm.y)/4, h.arm.x, h.arm.y);
    resetMatrix();
  }
}

void live() {
}


class Hunter {
  int l; 
  PVector pos;
  PVector dest;
  PVector arm;
  int n;

  Hunter(float x, float y, int lin) {
    l = lin;
    pos = new PVector(x, y);
    dest = new PVector(500, 500);
    arm = new PVector(500, 500);
    arm.limit(l);
    n = 0;
  }

  boolean closestPrey(Prey p) {
    PVector v1 = p.pos.copy();
    v1.sub(pos);
    return(v1.mag() < dest.mag());
  }

  void hunt() {
    if (!preys.isEmpty() && abs(dest.x - arm.x) < prey_size/2) {
      preys.remove(n-1);
      l+= 30;
      println("a");
      
    }
    if (!preys.isEmpty()) {
      for (Prey p : preys) {
        if (closestPrey(p)) {
          dest = p.pos.copy();
          dest = dest.sub(pos);
          n= p.n;
        }
      }
      arm.x = lerp(arm.x, dest.x, .05);
      arm.y = lerp(arm.y, dest.y, .05);

      arm.limit(l);
    }
  }

  void reproduce() {
    hunters.add(new Hunter(pos.x +(int)random(-50, 50), pos.y + (int)random(-50, 50), l/2));
    l = l /2;
  }
}

class Prey {
  PVector pos;
  int n;
  Prey(float x, float y) {
    pos = new PVector(x, y);
    n=preyNo;
    preyNo++;
  }

  void run() {
    //pos.x += random(-1, 1);
    //pos.y += random(-1, 1);
  }
}


void mousePressed() {
  preys.add(new Prey(mouseX, mouseY));
}