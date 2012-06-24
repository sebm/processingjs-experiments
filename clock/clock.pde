// X and Y coordinates for the midpoints of our circles.
float hourX;
float hourY;

float minuteX;
float minuteY;

float secondX;
float secondY;

// The current time, represented in minutes, seconds, and hours.
// They are floats so that the circles will move at a steady pace.
float theSeconds;
float theMinutes;
float theHours;

// Diameter and radius of the outer circle.
int outerD = 400;
float outerR = outerD / 2;

// Ratios to define the circles' sizes in terms of the outer circle's size.
final float goldenRatio = 1 / 1.618034;
float ratioOuterToHour = goldenRatio;
float ratioHourToMinute = goldenRatio;
float ratioMinuteToSecond = goldenRatio;

float hourD = outerD * ratioOuterToHour;
float hourOffset = 0.5 * (outerD - hourD);

float minuteD = hourD * ratioHourToMinute;
float minuteOffset = 0.5 * (hourD - minuteD);

float secondD = minuteD * ratioMinuteToSecond;
float secondOffset = 0.5 * (minuteD - secondD);

void setup() {
  size(outerD, outerD);
}


void outerCircle() {
  arc(outerR, outerR, outerD, outerD, 0, 2*PI);
}

float secondsOrMinutesToRadians(units) {
  return 2 * PI / 60 * units;
}

float hoursToRadians(hours) {
  return 2 * PI / 12 * hours;
}

void hourCircle() {
  float theRadians = hoursToRadians(theHours);

  // hourX and hourY are the coords of the hour circle.
  // the hour circle rotates around x=outerR, y=outerR
  hourX = outerR + hourOffset * sin(theRadians);
  hourY = outerR - hourOffset * cos(theRadians);
  arc(hourX, hourY, hourD, hourD, 0, 2*PI);
}

void minuteCircle() {
  float theRadians = secondsOrMinutesToRadians(theMinutes);
  minuteX = hourX + minuteOffset * sin(theRadians);
  minuteY = hourY - minuteOffset * cos(theRadians);
  arc(minuteX, minuteY, minuteD, minuteD, 0, 2*PI);
}

void secondCircle() {
  float theRadians = secondsOrMinutesToRadians(theSeconds);
  secondX = minuteX + secondOffset * sin(theRadians);
  secondY = minuteY - secondOffset * cos(theRadians);
  arc(secondX, secondY, secondD, secondD, 0, 2*PI);
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
