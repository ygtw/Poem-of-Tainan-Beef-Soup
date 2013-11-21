// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 16-13: Simple motion detection

PImage bimg ;
int imgI = 1; 
import rita.*;
int count = 0;
import processing.video.*;
// Variable for capture device
Capture video;
Timer timer;
// Previous Frame
PImage prevFrame;
// How different must a pixel be to be a "motion" pixel
float threshold = 100;

void setup() {
  size(640,480);
  video = new Capture(this, width, height, 30);
  video.start();
  // Create an empty image the same size as the video
  
 bimg = loadImage("(1).jpg");
  
  prevFrame = createImage(video.width,video.height,RGB);
  
  
  
  
  
  
  
 String[] strArray = {"牛","牛肉","牛肉","湯","不","是","牛肉麵","不","是","牛肉","湯麵","更","不會","是","牛肉","場","是以","溫體","清","燙","牛肉","再","一","刀一刀","慢慢","修剪","各","家","秘方","湯頭","用心","熬煮","每","碗","上桌","呈現","的","動態","藝術"}; 


  RiText.defaultFont("華康行書體", 30);

//  RiText rt2 = new RiText(this, "ZAG");
for(int i=0;i<strArray.length;i++)
{
  RiText rt1= new RiText(this, strArray[i]);
  rt1.fill(255);
  rt1.motionType(RiTa.EASE_IN_OUT);

  moveToRandom(rt1);
}
//  moveToRandom(rt2);
  
    timer = new Timer(3000);
  timer.start();
}

void draw() {
    if (timer.isFinished()) {
      
        timer.start();
     bimg = loadImage("("+(imgI) +").jpg");
     println("("+(imgI) +").jpg");
  imgI++;
  if(imgI==27) imgI=1;
     
  }
  
  count = 0;
  
  // Capture video
  if (video.available()) {
    // Save previous frame for motion detection!!
    prevFrame.copy(video,0,0,video.width,video.height,0,0,video.width,video.height); // Before we read the new frame, we always save the previous frame for comparison!
    prevFrame.updatePixels();
    video.read();
  }
  
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();
  
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;            // Step 1, what is the 1D pixel location
      color current = video.pixels[loc];      // Step 2, what is the current color
      color previous = prevFrame.pixels[loc]; // Step 3, what is the previous color
      color bg = bimg.pixels[loc]; // Step 3, what is the previous color
      
      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); float g1 = green(current); float b1 = blue(current);
      float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
      float bgr = red(bg); float bgg = green(bg); float bgb = blue(bg);
      float diff = dist(r1,g1,b1,r2,g2,b2);
      
      // Step 5, How different are the colors?
      // If the color at that pixel has changed, then there is motion at that pixel.
      if (diff > threshold) { 
        // If motion, display black
        pixels[loc] = color(255,80);
        count ++ ;
        
      } else {
        // If not, display white
        pixels[loc] = color(bgr,bgg,bgb);
      }
    }
  }
//  prevFrame.resize(800,0);

  updatePixels();
  
  if(count > 10000)
{
  fill(255, 100); // leave trails

  println(count);
  RiText.drawAll();
}
 
//  rect(0, 0, width, height);


  
  
}
