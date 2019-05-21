public class Window {
  int size;
  PVector position;
  PVector lookAtPos;

  public Window(int size) {
    this.size = size;
    this.position = new PVector(cam.getPosition()[0], cam.getPosition()[1], cam.getPosition()[2]);
    this.lookAtPos = new PVector(cam.getLookAt()[0], cam.getLookAt()[1], cam.getLookAt()[2]);
  }

  void update() {
    position.set(cam.getPosition()[0], cam.getPosition()[1], cam.getPosition()[2]);
    lookAtPos.set(cam.getLookAt()[0], cam.getLookAt()[1], cam.getLookAt()[2]);

    //Returns direction to looking point
    PVector direction = lookAtPos.sub(position);
    direction.normalize();

    if (splatter) generateAllRays(position, direction);

    for (Point p : points) p.show();

    points.clear();
  }

  void generateAllRays(PVector ori, PVector direction) {
    float x = ori.x;
    float y = ori.y;
    float z = ori.z;

    for (int i = -size; i < size; i += incr) {
      for (int j = -size; j < size; j += incr) {
        ori.set(i + x, j + y, z);
        castSingleRay(ori, direction);
      }
    }
  }

  void castSingleRay(PVector ori, PVector direction) {
    PVector current = ori.copy();

    for (int iteration = 0; iteration < 500; iteration++) {
      float de;
      de = minDistToScene(current.x, current.y, current.z, objs);
      // de = maxDistToScene(current.x, current.y, current.z, objs);
      // de = newTypeDist(current.x, current.y, current.z, objs);

      if (de < 1) {
        color c = (int) map(iteration, 0, colorIncr, 255, 0);
        points.add(new Point(current.x, current.y, current.z, c));
        break;
      }
      current.add(PVector.mult(direction, de));
    }
  }

  void turnAround() {
  }
}

public class Point {
  float x, y, z;
  color col;

  public Point(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.col = color(255, 0, 0);
  }

  public Point(float x, float y, float z, color col) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.col = col;
  }

  void show() {
    stroke(col);
    strokeWeight(3);
    point(x, y, z);
  }
}
