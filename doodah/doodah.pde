void setup() {
  size(600,600);
}

float rotation_factor = 0;
int col = 0;

void paintBackground() {
  background(sin(col) * 128 + 128, 128, cos(col) * 128 + 128);
  col += PI/128;
}

void paintTriangle() {
  translate(40*cos(rotation_factor)+300,40*sin(rotation_factor)+300);
  rotate(4*rotation_factor);
  triangle(0, 0, 0, 100, 100, 0);
  rotation_factor += PI/120;
}


void draw() {
  paintBackground();
  paintTriangle();
}

loop();
