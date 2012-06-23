void setup() {
  int hourX = 200;
  int hourY = 50;

  size(400, 400);
}

void outerCircle() {
  arc(200, 200, 400, 400, 0, 2*PI);
}

float lineEndX;
float lineEndY;
float nubbin = 0;

void hourCircle() {
  lineEndX = 200 + 150 * sin(nubbin);
  lineEndY = 200 + 150 * -1 * cos(nubbin);
  arc(lineEndX, lineEndY, 100, 100, 0, 2*PI);
  nubbin += 0.01;
}

void draw() {
  outerCircle();
  hourCircle();
}

loop();
