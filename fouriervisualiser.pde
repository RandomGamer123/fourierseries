int[] midadj = {800,450}; //represents an offset to the center
JSONArray coefficients;
float[] startvalue = new float[2];
Pointer[] pointerarr = new Pointer[1000]; //edit this to be equal to the number of pointers
float scale = 5.8; //represents the amount you want to scale the visualisation up by
float baseangleincrement = 0.01; //represents the speed
float[] pointsx = new float[700]; //edit this to be larger than TAU/baseangleincrement
float[] pointsy = new float[700];
void setup() {
  size(1920,1080);
  background(0);
  coefficients = loadJSONArray("coeffs2.json"); //format of json: [[freq,real part of coeff 0 (start pos x), imag part of coeff 0 (start pos y)],[freq,length of coeff 1,angle of coeff 1],[freq,length of coeff -1,angle of coeff -1],[freq,length of coeff 2,angle of coeff 2],etc.]
  startvalue[0] = scale*(coefficients.getJSONArray(0).getFloat(1)-midadj[0]);
  startvalue[1] = scale*(coefficients.getJSONArray(0).getFloat(2)-midadj[1]);
  float[] currentloc = new float[2];
  currentloc[0] = startvalue[0];
  currentloc[1] = startvalue[1];
  for (int i = 1; i < coefficients.size(); i++) {
    JSONArray localdata = coefficients.getJSONArray(i);
    pointerarr[i-1] = new Pointer(localdata.getFloat(0),scale*localdata.getFloat(1),localdata.getFloat(2),currentloc);
    currentloc[0] = pointerarr[i-1].pointend[0];
    currentloc[1] = pointerarr[i-1].pointend[1];
  }
}
void draw() {
  background(0);
  float[] currentloc = new float[2];
  currentloc[0] = startvalue[0];
  currentloc[1] = startvalue[1];
  for (int i = 0; i < pointerarr.length; i++) {
    Pointer lclpointer = pointerarr[i];
    lclpointer.pointstart[0] = currentloc[0];
    lclpointer.pointstart[1] = currentloc[1];
    lclpointer.angleinc(baseangleincrement);
    lclpointer.calcend();
    lclpointer.redrawpointer();
    currentloc[0] = lclpointer.pointend[0];
    currentloc[1] = lclpointer.pointend[1];
  }
  stroke(#CC4449);
  strokeWeight(5);
  for (int i = pointsx.length-1; i > 0; i--) {
    pointsx[i] = pointsx[i-1];
    pointsx[i] = pointsx[i-1];
  }
  for (int i = pointsy.length-1; i > 0; i--) {
    pointsy[i] = pointsy[i-1];
    pointsy[i] = pointsy[i-1];
  }
  pointsx[0] = currentloc[0];
  pointsy[0] = currentloc[1];
  for (int i = 1; i < pointsx.length; i++) {
    line(pointsx[i-1],pointsy[i-1],pointsx[i],pointsy[i]);
  }
  saveFrame("fourier-####.png");
}
public class Pointer {
  float abslength, angle, frequency;
  float[] pointstart, pointend = new float[2];
  Pointer (float f, float l, float a, float[] start) {
    frequency = f;
    abslength = l;
    angle = a;
    pointstart = start;
    this.calcend();
    this.redrawpointer();
  }
  void calcend() {
    pointend[0] = pointstart[0]+abslength*cos(angle);
    pointend[1] = pointstart[1]+abslength*sin(angle);
  }
  void redrawpointer() {
    stroke(#CC4449,128);
    strokeWeight(0.005*abslength);
    noFill();
    ellipseMode(RADIUS);
    circle(pointstart[0],pointstart[1],abslength);
    strokeWeight(0.015*abslength);
    stroke(255);
    line(pointstart[0],pointstart[1],pointend[0],pointend[1]);
    noStroke();
    fill(255);
    circle(pointend[0],pointend[1],0.05*abslength);
  }
  void angleinc(float baseanglechange) {
    angle += baseanglechange*frequency;
  }
}
