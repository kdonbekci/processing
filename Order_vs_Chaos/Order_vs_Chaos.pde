float t = 0;
float dt = 0;

void setup() {
  size(1000, 1000);
  //colorMode(HSB);
  background(255, 0, 0);
  //background(255,255,255);
}

void draw() {
  //background(255, 0, 0);
  //dt =mouseY/height/10;
  float n = 0;
  translate(width/2, height/2);
  rotate(t/2);

  stroke(0);
  while (n < width) {
    point(n-width/2, -height/16 + height/8* noise(n / 100, t));
    n = n + 1;
  }
  n=0;
  while (n < height) {
    point(-width/16 + width/8 *noise(n / 100, t), n-height/2);
    n = n + 1;
  }
  stroke(255);
  line(0, 0, width/2* sin(PI/4), height/2* sin(PI/4));
  line(0, 0, -width/2* sin(PI/4), height/2* sin(PI/4));
  line(0, 0, -width/2* sin(PI/4), -height/2* sin(PI/4));
  line(0, 0, width/2 * sin(PI/4), -height/2* sin(PI/4));
  line(0, 0, width/2, 0);
  line(0, 0, -width/2, 0);
  line(0, 0, 0, -height/2);
  line(0, 0, 0, height/2);

  //int data = 0;
  //for (int x=0; x<width; x++) {
  //  for (int y=0; y<height; y++) {
  //    data+=get(x,y);
  //  }
  //}
  //println(data); 
  t += dt;
  //if (dt<5) {
  //  dt*=1.01;
  //} else {
  //  dt=.01;;
  //}
}
void mousePressed() {
  dt+=.001;
}
void keyPressed() {
  if (key==' ') { 
    dt-= .001;
  }
}