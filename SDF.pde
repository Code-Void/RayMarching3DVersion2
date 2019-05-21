float distPlane(float x, float y, float z, Plane plain) {
  PVector p = new PVector(x, y, z);
  PVector n = new PVector(plain.x, plain.y, plain.z);
  //n.normalize();

  return PVector.dot(p, n);// + plain.sizew;
}

float distSphere(float x, float y, float z, Sphere sph) {
  return dist(x, y, z, sph.x, sph.y, sph.z) - sph.size;
}

float newTypeDist(float x, float y, float z, ArrayList<MarchingObjects> objs) {  
  return max(distSphere(x, y, z, (Sphere) objs.get(1)), distSphere(x, y, z, (Sphere) objs.get(0)) * -1);
}

float minDistToScene(float x, float y, float z, ArrayList<MarchingObjects> objs) {
  float shortest;

  switch (objs.get(0).type) {
  case 0:
    shortest = distSphere(x, y, z, (Sphere) objs.get(0));
    break;
  case 2: 
    shortest = distPlane(x, y, z, (Plane) objs.get(0));
    break;
  default:
    println("Something is wrong");
    return 1000;
  } 

  for (int i = 1; i < objs.size(); i++) {
    float temp;
    switch (objs.get(i).type) {
    case 0:
      temp = distSphere(x, y, z, (Sphere) objs.get(i));
      break;
    case 2: 
      temp = distPlane(x, y, z, (Plane) objs.get(0));
      break;
    default:
      temp = 10000;
    }

    if (temp < shortest) shortest = temp;
  }

  return shortest;
}


float maxDistToScene(float x, float y, float z, ArrayList<MarchingObjects> objs) {
  float biggest;

  switch (objs.get(0).type) {
  case 0:
    biggest = distSphere(x, y, z, (Sphere) objs.get(0));
    break;
  default:
    println("Something is wrong");
    return 1000;
  } 

  for (int i = 1; i < objs.size(); i++) {
    float temp;
    switch (objs.get(i).type) {
    case 0:
      temp = distSphere(x, y, z, (Sphere) objs.get(i));
      break;
    default:
      temp = 10000;
    }

    if (temp > biggest) biggest = temp;
  }

  return biggest;
}
