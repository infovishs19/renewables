int canvasW = 7680;
int canvasH = 1080;
PGraphics canvas;

String [] income = {"High income", "Upper middle income", "Lower middle income", "Low income"};
String [] region = {"South Asia", "Europe & Central Asia", "Middle East & North Africa", "Sub-Saharan Africa", "Latin America & Caribbean", "East Asia & Pacific", "North America"};

boolean ready = false;
PImage map;
PFont font;


// Processing Standard Functions
void settings() 
{
  size(canvasW/2, canvasH/2, P3D);
  PJOGL.profile=1;
}

void setup() {

  canvas = createGraphics(canvasW, canvasH, P3D);
  
  map = loadImage("img/weltkarte.png");
  font = loadFont("font/Montserrat-SemiBold.ttf");
  
  frameRate(30);
}

void draw(){
  background(255,0,0);
  
  
    // First Setup
  if(frameCount < 10){
    if (!ready) {
      background(0);
      return;
    } else {
      background(0);
    }
   // gridLine();
    //drawRanking(); // Call first Drawing
  }

  //reDraw();
  
  
  image(canvas,0,0,width,height);
}
