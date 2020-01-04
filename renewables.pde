import java.util.*;
import java.lang.reflect.Field;

int canvasW = 7680;
int canvasH = 1080;
PGraphics canvas;

String [] income = {"High income", "Upper middle income", "Lower middle income", "Low income"};
String [] region = {"South Asia", "Europe & Central Asia", "Middle East & North Africa", "Sub-Saharan Africa", "Latin America & Caribbean", "East Asia & Pacific", "North America"};


// Class Specific Var
Country [] countryByRank; // Class Placeholder


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
  size(canvasW/1, canvasH/1, P3D);
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
  float [] rankRange = {40, canvas.width - 80};
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


  // First Setup
  if (frameCount < 10) {
    if (!ready) {
      canvas.background(0);
      return;
    } else {
      canvas.background(0);
    }
    gridLine();
    drawRanking(); // Call first Drawing
  }

  reDraw();

  canvas.endDraw();
  image(canvas, 0, 0, width, height);
}

// Sort Arrays
ArrayList<DataObject> sortArray(ArrayList<DataObject> arr, String year) {
  
  ArrayList<DataObject> newList = new ArrayList<DataObject>(arr);
  
  //give the year reference to all the data in newList
  //and then use the year reference in comparable
  for(DataObject d : newList){
    d.yearRef = year;
  }
  
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


void gridLine(){
  //    rankScale
  float gridValue = 15.0;
  float cycles = floor(data.size() / gridValue);

  for(int i = 0; i <= cycles + 1; i++){
    float tempX = rankScale.map(gridValue * i - 1);
    float tempYearX = rankScale.map((gridValue * i - 1) - 10);
    String tempText = "Rang: " + (int)(gridValue * i);

    canvas.stroke(255, 255, 255, 180);
    canvas.strokeWeight(2);

    if(i != 0 && i != cycles + 1){
      //      line(tempX, 0, tempX, 80);
      canvas.line(tempX, canvas.height - 80, tempX, canvas.height);

      // SetUp Text
      canvas.noStroke();
      canvas.textSize(16);
      canvas.textAlign(CENTER);
      canvas.fill(255, 255, 255, 180);

      //      text(tempText, tempX, 100);
      canvas.text(tempText, tempX, canvas.height - 100);
     // println(tempText);
     // println(tempX);
    }

  }

  // Add Height Information
  for(int i = 0; i < income.length; i++ ){
    canvas.pushMatrix();
    canvas.noStroke();
    canvas.textSize(20);
    canvas.translate(canvas.width - 50, yByIncome.map(income[i]));
    //angleMode(DEGREES);
    canvas.rotate(radians(-90));
    canvas.fill(255, 255, 255, 180);

    switch(income[i]){
      case "High income£":
        canvas.text(income[i], 0, 0);
        break;
      case "Upper middle income":
        canvas.text("Upper middle\nincome", 0, 0);
        break;
      case "Lower middle income":
        canvas.text("Lower middle\nincome", 0, 0);
        break;
      case "Low income":
        canvas.text(income[i], 0, 0);
        break;
      default:
        break;
    }
    canvas.popMatrix();
  }
}

void drawRanking(){
  canvas.background(0);

  countryByRank = new Country[data.size()];
  
  for (int i = 0; i < data.size(); i++) {
    countryByRank[i] = new Country(sortedData.get(i), i, currentYearReference);
    countryByRank[i].display();

  } // End Data for()
}

/* Easing Function */
float  ease(float n, float target) {
  float easing = 0.1;
  float d = target - n;
  return n + d * easing;
}



/******************** reDraw / animate all Objects ********************/
void reDraw(){
  
  //println("redraw  " + frameCount);
  canvas.background(0);
  canvas.imageMode(CENTER);
  //image(map, 280, 300, 400, 400);
   canvas.image(map, 280, 180, 400, 400);
  gridLine();

  for(int i = 0; i < sortedData.size(); i++){
    countryByRank[i].moveCountry();  
    countryByRank[i].display();
  }
  canvas.textAlign(LEFT);
  canvas.noStroke();
  canvas.fill(255, 255, 255, 180);
  canvas.textSize(35);
  // 7105.114285714286
  float yearX = (canvas.width - 7105) / 2;
  canvas.text(currentYear, canvas.width - yearX, canvas.height - 40);
  canvas.text("Erneuerbare Energie", 80, 100);
  canvas.textSize(25);
  canvas.text("Eine Rangliste der Energieanteile", 80, 135);
}


// Update on Click
void mouseClicked() {
  println("mouseClicked");
  updateYear();
  updateData();
}


/******************** Update Rank Data usw. ********************/
void updateData(){

  println("updateData");
  for(int i = 0; i < data.size(); i++){
    Country myObject = countryByRank[i];
    println(i + ") " + myObject.code);
    String currentCode = sortedData.get(i).Code;

    myObject.currentRanking = myObject.nextRank;

    for(int j = 0; j < data.size(); j++){
      if(myObject.code.equals(nextSortedData.get(j).Code)){
        myObject.nextRank = j;
        myObject.targetX = rankScale.map(myObject.currentRanking);
      }
    }
  }

}


// Change Value to new Year until == 2015
void updateYear(){
  
  println("updateYear");
  if(currentYear < 2014){
    // Change current Nr.
    currentYear++; // Add 1 to current Year
    currentYearReference = "E" + (int)currentYear;

    // Change Future Nr.
    nextYear++;
    nextYearReference  = "E" + (int)nextYear;

    // Update Sorted Array
    updateArrays(currentYearReference, nextYearReference);
  }else if(currentYear == 2014){
    // Change current Nr.
    currentYear++; // Add 1 to current Year
    currentYearReference = "E" + (int)currentYear;

    // Change Future Nr.
    nextYear = 1990;
    nextYearReference  = "E" + (int)nextYear;

    // Update Sorted Array
    updateArrays(currentYearReference, nextYearReference);   
  }else if(currentYear == 2015){
    currentYear = 1990; // Add 1 to current Year
    currentYearReference = "E" + (int)currentYear;

    // Change Future Nr.
    nextYear++;
    nextYearReference  = "E" + (int)nextYear;

    // Update Sorted Array
    updateArrays(currentYearReference, nextYearReference);
  }
  
  println("currentYear " + currentYear);
}

// Update Array Sorting to new Year
void updateArrays(String ny, String nyr) {    
  sortedData = sortArray(data, ny);
  nextSortedData = sortArray(futureData, nyr);
  //println("sortedData: ");
  //printHead(sortedData,10);
  //println("nextSortedData: ");
  //printHead(nextSortedData,10);
}


void printHead(ArrayList<DataObject> arr,int n){
  for(int i=0; i<n; i++){
    DataObject d = arr.get(i);
    println(i + ") " + d.CountryName);
  }
}
