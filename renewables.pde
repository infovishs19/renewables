int canvasW = 7680;
int canvasH = 1080;
PGraphics canvas;

String [] income = {"High income", "Upper middle income", "Lower middle income", "Low income"};
String [] region = {"South Asia", "Europe & Central Asia", "Middle East & North Africa", "Sub-Saharan Africa", "Latin America & Caribbean", "East Asia & Pacific", "North America"};

ArrayList<DataObject> data;
ArrayList<DataObject> futureData;
boolean ready = false;
PImage map;
PFont font;

// Scales
OrdinalScale regionColorScale = new OrdinalScale(); // Region zu Farbe
OrdinalScale yByIncome = new OrdinalScale(); // Income to Y
LinearScale surfaceScale = new LinearScale(); // Surface to Radius
LinearScale rankScale = new LinearScale(); // Value to Rank / X

// Design Variables
float divider;
float quarter;


// Processing Standard Functions
void settings() 
{
  size(canvasW/2, canvasH/2, P3D);
  PJOGL.profile=1;
}

void setup() {


  frameRate(30);
  canvas = createGraphics(canvasW, canvasH, P3D);

  map = loadImage("img/weltkarte.png");
  font = createFont("font/Montserrat-SemiBold.ttf", 35);



  // Load Data
  data = loadData("renewables_pop.csv"); // Current Data for sortedData
  futureData = loadData("renewables_pop.csv");// Current Data for nextSortedData


  divider = (canvas.height - 150.0) / 4.0;
  
  /********** Scale Setup **********/

  // Latin America & Caribbean | Sub-Saharan Africa | Middle East & North Africa | Europe & Central Asia | East Asia & Pacific | North America | South Asia
  regionColorScale.domain(region);
  
  regionColorScale.range(["29, 114, 137",   // South Asia
            "195, 114, 206",  // Europe & Central Asia
            "221, 81, 3",     // Middle East & North Africa
            "242, 172, 41",   // Sub-Saharan Africa
            "105, 186, 91",   // Latin America & Caribbean
            "172, 235, 242",  // East Asia & Pacific
            "46, 89, 2"]);    // North America

}

void draw() {

  background(0);
  canvas.beginDraw();
  canvas.background(255, 0, 0);
  canvas.endDraw();


  // First Setup
  if (frameCount < 10) {
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


  image(canvas, 0, 0, width, height);
}
