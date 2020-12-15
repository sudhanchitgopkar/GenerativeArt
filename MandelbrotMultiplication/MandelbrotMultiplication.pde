/*
This file contains the entirety of the functionality for a processing sketch
which is able to illustrate a novel representation of simple multiplication
tables. Learn more about this project via github.com/sudhanchitgopkar
@author: sudhan.chitgopkar
*/

// import recording library
import com.hamoid.*;

// create a new VideoExport-object
VideoExport videoExport;

//global vars
float radius;
int numPoints;
Point [] points;
float multVal;
float strokeColor;
String name;

//name-based generation functionality
public int nameToNum(String name) {
  //var declaration
  int nameNum = 0;
  this.name = name;
  //creates letter array of proper size
  char [] letters = new char [name.length()];
  
  //sets letters, evaluates unicode sum of letters
  for (int i = 0; i < name.length(); i++) {
      letters[i] = name.charAt(i);
      nameNum += (int) letters[i];
  } //for
  
  //maps sum to workable integer val
  nameNum = (int) map(nameNum,0,1000,0,100);
  //console printing to debug
  //System.out.println(nameNum);
  
  return nameNum;
} //nameToNum

void setup () {
  // Video Export settings
  videoExport = new VideoExport(this, "MandelbrotMult.mp4");
  videoExport.setFrameRate(7);  
  videoExport.startMovie();

  //general var setup
  frameRate(60);
  background(#1a1a1a);
  size(1080,1080);
  //fullScreen();
  textAlign(CENTER);
  noFill();
  strokeWeight(1.5);
  
  //generates circle
  radius = 350;
  circle(width/2,height/2,radius*2);
  
  //declarares circle modulo points
  numPoints = 300;
  points = new Point [numPoints];
  
  //initializes circle modulo points
  for (int i = 0; i < numPoints; i++) {
      points[i] = new Point(i);
      points[i].display(i);
  } //for

  //sets value of multiplication table to calculate
  //multVal = nameToNum("Sudhan");
  multVal = 0;
} //setup

void draw() {
  //resets background & colors
  background(#1a1a1a);
  fill(#5a5a5a);
  //sets bottom text
  text ("Table of: " + multVal, width/2, height * .9);
  //main line-drawing functionality
  for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints; j++) {
        for (int k = 0; k < numPoints; k++) {
          //determines point origin and ending
           if (multVal * i == j + numPoints * k ) {
              //draws final lines
               line(points[i].getX(),points[i].getY(),points[j].getX(),points[j].getY());
           } //if
        } //for
      } //for
      //line color changing functionality
      strokeColor = random(255);
      stroke(strokeColor,255,255);
  } //for
  //===== UNCOMMENT BELOW FOR ITERATION ANIMATION FUNCTIONALITY =====//
  if(multVal > 100) {
    multVal = 0;
    videoExport.endMovie();
    exit();
  } else {
  multVal += 1;
  } //if
  //===== UNCOMMENT ABOVE FOR ITERATION ANIMATION FUNCTIONALITY =====//
  videoExport.saveFrame();
  //noLoop();
  //save("wall2.tiff");
} //draw

//Point class functionality
public class Point {
  //declares global vars
  private float xPos;
  private float yPos;
  
  //Constructor
  public Point(int numPoint) {
      //sets point at proper location along circle
      xPos = (radius * cos(((numPoint * 2 * PI)/numPoints))) + width/2;
      yPos = (radius * sin(((numPoint * 2 * PI)/numPoints))) + height/2;
  } //Point
  
  //Displays point on screen
  public void display(int ID) {
      circle(xPos,yPos,10);
      //labels circles for debugging
      //text(ID,xPos,yPos);
  } //display
  
  //public getter for xPos
  public float getX() {
    return xPos;
  } //getX
  
  //public getter for yPos
  public float getY() {
    return yPos;
  } //getY
  
} //Point
