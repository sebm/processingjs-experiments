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
int outerD = 740;
float outerR = outerD / 2;

// Ratios to define the circles' sizes in terms of the outer circle's size.
final float goldenRatio = 1 / 1.618034;
float ratioOuterToHour = goldenRatio;
float ratioHourToMinute = goldenRatio;
float ratioMinuteToSecond = goldenRatio;

// Size of the hour circle, and its offset from the outer circle's midpoint
float hourD = outerD * ratioOuterToHour;
float hourOffset = 0.5 * (outerD - hourD);

// Size of the minute circle and its offset from the hour circle's midpoint
float minuteD = hourD * ratioHourToMinute;
float minuteOffset = 0.5 * (hourD - minuteD);

// Size of the second circle and its offset from the minute circle's midpoint
float secondD = minuteD * ratioMinuteToSecond;
float secondOffset = 0.5 * (minuteD - secondD);

// Convert a "minutes" or "seconds" angle into radians.
float secondsOrMinutesToRadians(units) {
  return TWO_PI / 60 * units;
}

// Convert an "hours" angle into radians.
float hoursToRadians(hours) {
  return TWO_PI / 12 * hours;
}

// Establish the size of the canvas element.
void setup() {
  size(outerD, outerD);
}

// Draw the outer circle.
void outerCircle() {
  arc(outerR, outerR, outerD, outerD, 0, TWO_PI);
}

// Draw the hour circle.
void hourCircle() {
  float rads = hoursToRadians(theHours);

  hourX = outerR + hourOffset * sin(rads);
  hourY = outerR - hourOffset * cos(rads);
  arc(hourX, hourY, hourD, hourD, 0, TWO_PI);
}

// Draw the minute circle.
void minuteCircle() {
  float rads = secondsOrMinutesToRadians(theMinutes);
  minuteX = hourX + minuteOffset * sin(rads);
  minuteY = hourY - minuteOffset * cos(rads);
  arc(minuteX, minuteY, minuteD, minuteD, 0, TWO_PI);
}

// Draw the second circle.
void secondCircle() {
  float rads = secondsOrMinutesToRadians(theSeconds);
  secondX = minuteX + secondOffset * sin(rads);
  secondY = minuteY - secondOffset * cos(rads);
  arc(secondX, secondY, secondD, secondD, 0, TWO_PI);
}

// Draw the clock.
void draw() {
  // We add milliseconds onto the seconds so the circle will glide smoothly.
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
