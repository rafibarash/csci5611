// Based off this video: https://www.youtube.com/watch?v=BZUdGqeOD0w
// And off this paper: https://web.archive.org/web/20160418004149/http://freespace.virgin.net/hugo.elias/graphics/x_water.htm

int cols, rows;
float[][] curWaterState;
float[][] prevWaterState;

//float damping = 0.95;
//float damping = 0.99999;

void setup() {
  size(600, 400);
  cols = width;
  rows = height;
  curWaterState = new float[cols][rows];
  prevWaterState = new float[cols][rows];
  prevWaterState[400][300] = 255;
  prevWaterState[200][200] = 255;
}

void draw() {
  background(0);
  loadPixels();
  
  // Update buffers
  for (int i=1; i < cols - 1; i++) {
    for (int j=1; j < rows - 1; j++) {
      curWaterState[i][j] = (prevWaterState[i-1][j] + 
                prevWaterState[i+1][j] + 
                prevWaterState[i][j-1] + 
                prevWaterState[i][j+1]
             ) / 2 - curWaterState[i][j];
      curWaterState[i][j] *= damping;
      
      int index = i + j*cols;
      pixels[index] = color(curWaterState[i][j]*255);
    }
  }
  
  // Display buffers
  updatePixels();
  
  // Swap buffers
  float[][] temp = prevWaterState;
  prevWaterState = curWaterState;
  curWaterState = temp;
  
  // update ripples based on mouse
  //prevWaterState[mouseX][mouseY] = 255;
}

//void mousePressed() {
//  prevWaterState[mouseX][mouseY] = 255;
//}

//void mouseDragged() {
//  int col = mouseX, row = mouseY;
//  if (col >= cols) col = cols - 1;
//  if (col < 0) col = 0;
//  if (row >= rows) row = rows - 1;
//  if (row < 0) row = 0;
//  prevWaterState[col][row] = 255;
//}
