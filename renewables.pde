import java.util.*;
import java.lang.reflect.Field;

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
OrdinalScale2 yByIncome = new OrdinalScale2(); // Income to Y
LinearScale surfaceScale = new LinearScale(); // Surface to Radius
LinearScale rankScale = new LinearScale(); // Value to Rank / X

// Design Variables
float divider;
float quarter;

float currentYear; // Raw Year Number
String currentYearReference; // Reference to Energy Number
float nextYear; // Raw next Year Number
public static String nextYearReference; // Reference to Energy Number

ArrayList<DataObject> sortedData;
ArrayList<DataObject> nextSortedData;

int [] comparedIndex;



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

  String [] colorStrings = {"29, 114, 137", // South Asia
    "195, 114, 206", // Europe & Central Asia
    "221, 81, 3", // Middle East & North Africa
    "242, 172, 41", // Sub-Saharan Africa
    "105, 186, 91", // Latin America & Caribbean
    "172, 235, 242", // East Asia & Pacific
    "46, 89, 2"};

  regionColorScale.range(colorStrings);    // North America

  // Fix it
  yByIncome.domain(income);

  float [] yrange = {(divider * 0) + (divider / 2), (divider * 1) + (divider / 2), (divider * 2) + (divider / 2), (divider * 3) + (divider / 2)};
  yByIncome.range(yrange);
  //    .range([(100) + (divider * 0) + (divider / 2), (100) +  (divider * 3) + (divider / 2), (100) +  (divider * 2) + (divider / 2), (100) +  (divider * 1) + (divider / 2)])

  float minSize = Float.MAX_VALUE;
  for (DataObject d : data) {
    if (d.Surface < minSize) {
      minSize = d.Surface;
    }
  }

  float maxSize = Float.MIN_VALUE;
  for (DataObject d : data) {
    if (d.Surface > maxSize) {
      maxSize = d.Surface;
    }
  }

  // Value Scale Radius
  float [] dom = {minSize, maxSize};
  surfaceScale.domain(dom);

  float [] ran = {10, 50};
  surfaceScale.range(ran);

  // Ranking Scale    

  float [] rankDom = {0, data.size()};
  rankScale.domain(rankDom);
  float [] rankRange = {40, width - 80};
  rankScale.range(rankRange);



  // Class Setup
  currentYear = 1990;
  currentYearReference = "E1991";
  sortedData = sortArray(data, currentYearReference);

  //get the first element
  //for(int i=0; i<20; i++){
  //  println(i +") " + sortedData.get(i));
  //}

  nextYear = 1991;
  nextYearReference = "E1991";
  nextSortedData = sortArray(futureData, nextYearReference);
  
  compareSortedData(); // Fill Comparison Array
  


  ready = true;
}

void draw() {

  background(0);
  canvas.beginDraw();
  canvas.textFont(font);
  canvas.noStroke();
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

// Sort Arrays
ArrayList<DataObject> sortArray(ArrayList<DataObject> arr, String year) {
  
  ArrayList<DataObject> newList = new ArrayList<DataObject>(arr);
  
  Collections.sort(newList);

  return newList;
}

void compareSortedData(){
 
  comparedIndex = new int[sortedData.size()];
  
  for(int i = 0; i < sortedData.size(); i++){
    
    int index = -1;
    String code = sortedData.get(i).Code;
    boolean found = false;
    for(int j=0; j<nextSortedData.size() && !found; j++){
      DataObject d = nextSortedData.get(j);
      if(d.Code.equals(code)){
        found = true;
        index = j;
      }
    }
    if(!found){
      println("Error in compareSortedData");
    }
    
    comparedIndex[i] = index;
  }
}
