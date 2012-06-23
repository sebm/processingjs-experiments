void setup() {
  size(400, 400);
}

float hourX;
float hourY;

float minuteX;
float minuteY;

float secondX;
float secondY;

float theSeconds;
float theMinutes;
float theHours;

void outerCircle() {
  arc(200, 200, 400, 400, 0, 2*PI);
}


float secondsOrMinutesToRadians(units) {
  return 2 * PI / 60 * units;
}

float hoursToRadians(hours) {
  return 2 * PI / 12 * hours;
}

void hourCircle() {
  float theRadians = hoursToRadians(theHours);
  hourX = 200 + 150 * sin(theRadians);
  hourY = 200 - 150 * cos(theRadians);
  arc(hourX, hourY, 100, 100, 0, 2*PI);
}

void minuteCircle() {
  float theRadians = secondsOrMinutesToRadians(theMinutes);
  minuteX = hourX + 25 * sin(theRadians);
  minuteY = hourY - 25 * cos(theRadians);
  arc(minuteX, minuteY, 50, 50, 0, 2*PI);
}

void secondCircle() {
  float theRadians = secondsOrMinutesToRadians(theSeconds);
  secondX = minuteX + 15 * sin(theRadians);
  secondY = minuteY - 15 * cos(theRadians);
  arc(secondX, secondY, 20, 20, 0, 2*PI);
}


void draw() {
  int ms = new Date().getMilliseconds();
  theSeconds = second() + ms / 1000;
  theMinutes = minute() + theSeconds / 60;
  theHours = hour() + theMinutes / 60;
  outerCircle();
  hourCircle();
  minuteCircle();
  secondCircle();
}

loop();
