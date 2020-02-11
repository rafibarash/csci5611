// Created for CSCI 5611

// Here is a simple processing program that demonstrates many components that you
// will need for HW1 including creating objects (a quad), moving and rotating 
// objects over time, and adding textures.

// If you are new to processing, you can find an excelent tuorial that will quickly
// introduce the key featuers here: https://processing.org/tutorials/p3d/

PImage img;  //Will store the texture/image we are drawing
float time;

void setup() {
  size(640, 360, P3D);
  img = loadImage("Big-Goldy-Face.jpg"); //What image to load, experiment with transparent images 
  noStroke();
  time = 0;
}

void draw() {
  time += .016;
  background(0); //Clear the background to black
  
  //We must first tell processing where to translate and rotate the image to, before we draw it
  translate(width / 2 + 100 * cos(time), height / 2 + 100 * sin(time), -100); //Replace this with time-based integration!
  rotateY(time);
  
  //We will draw the image on a quad (rectangle) made of 4 verticies
  beginShape();
  texture(img);
  // vertex( x, y, z, u, v) where u and v are the texture coordinates in pixels
  vertex(-100, -100, 0, 0, 0);
  vertex(100, -100, 0, img.width, 0);
  vertex(100, 100, 0, img.width, img.height);
  vertex(-100, 100, 0, 0, img.height);
  endShape();
}
