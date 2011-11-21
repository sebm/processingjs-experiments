void setup() {
  size(400, 400);
}

float front = 0;
float back = 0;
float increment = PI/16;
float sweeps = 0;
float offset = 0;

color color1 = #ffffff;
color color2 = #ff00ff;

void recalculate() {
  // calculate front/back angles of foreground circle
  if (front < 2*PI + offset) {
    front += increment;
  } else if (back < 2* PI + offset) {
    back += increment;
  } else {
    sweeps++;
    offset = sweeps * increment;
    front = offset;
    back = offset;
  }
}

void draw() {
  // draw background circle
  fill(color1);
  stroke(color1);
  arc(200, 200, 400, 400, 0, 2*PI);

  recalculate();

  // draw foreground circle
  fill(color2);
  stroke(color2);
  arc(200, 200, 400, 400, back,front);
}

loop();
