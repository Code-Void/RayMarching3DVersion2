import peasy.*;

// RAY MARCHING IN 3D
// VERSION 2

PeasyCam cam;

boolean spheres = true;
boolean splatter = false;
boolean axis = false;

//increment for splatter
int incr = 5;
//window size
int windowSize = 300;
int colorIncr = 10;

ArrayList<MarchingObjects> objs = new ArrayList<MarchingObjects>();
ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Point> turnAroundPoints = new ArrayList<Point>();

Window looker;

void setup() {
  fullScreen(P3D, 2); 

  cam = new PeasyCam(this, 500);

  objs.add(new Sphere(50, 0, -300, 100));
  objs.add(new Sphere(0, 50, -200, 115));
  objs.add(new Sphere(0, 0, 0, 50));
  //objs.add(new Plane(0, 0, 0, 100, 100));

  looker = new Window(windowSize);
}

void draw() {
  background(0);

  cam.beginHUD();
  fill(255);
  textSize(15);
  String HUD = " Splattering - 'm': "+ splatter;
  HUD += '\n' + " Increment - 'DOWN or UP': "+ incr;
  HUD += '\n' + " Window pane - 'w': "+ windowSize;
  HUD += '\n' + " Color Increment - '+ or -': "+ colorIncr;
  text(HUD, 0, 0, 400, 400);

  String fpsHud = "FPS: " + (int) frameRate;
  text(fpsHud, width-60, 0, width, 200);

  cam.endHUD(); // always!

  if (axis) showAxis();

  if (spheres) {
    for (MarchingObjects m : objs) {
      m.show();
    }
  }
  looker.update();
}

void keyPressed() {
  if (key == 'a') axis = !axis;
  else if (key == 'm') {
    splatter = !splatter;
  } else if (key == 's') {
    spheres = !spheres;
  } else if (keyCode == DOWN) {
    if (incr > 1 && !splatter) incr--;
  } else if (keyCode == UP) {
    if (!splatter) incr++;
  } else if (key == 'w') {
    if (windowSize < 1000) windowSize += 100;
    else windowSize = 100;
  } else if (key == '+') {
    colorIncr++;
  } else if (key == '-') {
    if (colorIncr > 1) colorIncr--;
  } else if (key == 'c') {
    looker.turnAround();
  }
}

void showAxis() {
  strokeWeight(1);

  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);

  stroke(100, 0, 150);
  noFill();
  sphere(1000);
}
