int STROKE_WEIGHT = 3;

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

// The angles where the circles should be placed,
// relative to the circles that contain them.
float secondRads;
float minuteRads;
float hourRads;

// Diameter and radius of the outer circle.
int outerD = 730;
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
  strokeWeight(STROKE_WEIGHT);
  size(outerD + STROKE_WEIGHT, outerD + STROKE_WEIGHT);
}

// Draw the outer circle.
void outerCircle() {
  arc(outerR, outerR, outerD, outerD, 0, TWO_PI);
}

// Draw the hour circle.
void hourCircle() {
  hourX = outerR + hourOffset * sin(hourRads);
  hourY = outerR - hourOffset * cos(hourRads);
  arc(hourX, hourY, hourD, hourD, 0, TWO_PI);
}

// Draw the minute circle.
void minuteCircle() {
  minuteX = hourX + minuteOffset * sin(minuteRads);
  minuteY = hourY - minuteOffset * cos(minuteRads);
  arc(minuteX, minuteY, minuteD, minuteD, 0, TWO_PI);
}

// Draw the second circle.
void secondCircle() {
  secondX = minuteX + secondOffset * sin(secondRads);
  secondY = minuteY - secondOffset * cos(secondRads);
  arc(secondX, secondY, secondD, secondD, 0, TWO_PI);
}

// Draw a tick in the hours circle.
void hourTick() {
  line(
    hourX + 0.45 * hourD * sin(hourRads),
    hourY - 0.45 * hourD * cos(hourRads),
    hourX + 0.50 * hourD * sin(hourRads),
    hourY - 0.50 * hourD * cos(hourRads)
  );
}

// Draw a tick in the minutes circle
void minuteTick() {
  line(
    minuteX + 0.45 * minuteD * sin(minuteRads),
    minuteY - 0.45 * minuteD * cos(minuteRads),
    minuteX + 0.50 * minuteD * sin(minuteRads),
    minuteY - 0.50 * minuteD * cos(minuteRads)
  );
}

// Draw a tick in the seconds circle
void secondTick() {
  line(
    secondX + 0.4 * secondD * sin(secondRads),
    secondY - 0.4 * secondD * cos(secondRads),
    secondX + 0.5 * secondD * sin(secondRads),
    secondY - 0.5 * secondD * cos(secondRads)
  );
}

// Draw ticks on the outer circle
void outerTicks() {
  for (int i=1; i <= 12; i++) {
    float theX = outerR * (1 + sin(hoursToRadians(i)));
    float theY = outerR * (1 - cos(hoursToRadians(i)));
    point(theX, theY);
  }
}


// Draw the clock.
void draw() {
  // We add milliseconds onto the seconds so the circle will glide smoothly.
  int ms = new Date().getMilliseconds();
  theSeconds = second() + ms / 1000;
  theMinutes = minute() + theSeconds / 60;
  theHours = hour() + theMinutes / 60;

  secondRads = secondsOrMinutesToRadians(theSeconds);
  minuteRads = secondsOrMinutesToRadians(theMinutes);
  hourRads = hoursToRadians(theHours);

  outerCircle();
  stroke(#ffffff);
  outerTicks();
  stroke(#000000);

  hourCircle();
  hourTick();

  minuteCircle();
  minuteTick();

  secondCircle();
  secondTick();
}

loop();
