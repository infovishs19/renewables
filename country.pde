
class Country { // Klare Namenswahl hilft

  DataObject countryData;
  String code;
  float value;
  String incomeGroup;
  String regionColorGroup;
  String [] regionColors; //mayne make float [] out of this
  float red;
  float green;
  float blue;
  int currentRanking;
  int nextRank;
  float x;
  float targetX;
  float y;
  float r;
  
  
  /******************************* CLASS CONSTRUCTOR ********************************/
  Country(DataObject countryData, int countryRank, String myYear) {     
    // Getting Data
    this.countryData = countryData;
    this.code = this.countryData.Code;
    this.value = this.countryData.getValue(myYear); //TODO round to two after decimal

    // Choosing Color
    this.incomeGroup = this.countryData.IncomeGroup;
    this.regionColorGroup = regionColorScale.map(this.countryData.Region);
    this.regionColors = split(this.regionColorGroup,",");
    this.red = Float.parseFloat(this.regionColors[0]);
    this.green = Float.parseFloat(this.regionColors[1]);
    this.blue = Float.parseFloat(this.regionColors[2]);
    
    println("color of " + this.code + ": " + this.red + "," + this.green + "," + this.blue );


    // Ranking
    this.currentRanking = countryRank;
    this.nextRank = comparedIndex[countryRank];

    // Position & Size
    this.x = rankScale.map(this.currentRanking); // Berechnung mit d3 Scale (rankScale) Domain: 0 - anzahl Länder, SclaeLinear
    this.targetX = rankScale.map(this.currentRanking); // Target Position
    this.y = yByIncome.map(this.incomeGroup);
    this.r = 12;
    //    this.r = surfaceScale(this.countryData['Surface']);
  }

  /******************** ANIMATE RANKING ********************/
  void moveCountry(){
    this.x = ease(this.x, this.targetX); // Move Target

  }

  /******************** DISPLAY OBJECTS ********************/
  void display() {
    // Draw Point
    //    stroke('rgba(255, 255, 255, 0.3)');
    canvas.stroke(this.red, this.green, this.blue);
    canvas.strokeWeight(2);


    canvas.line(this.x, this.y - 40, this.x, this.y + 40);

    this.value = this.countryData.getValue(currentYearReference); //.toFixed(1); //TODO

    canvas.noStroke();
    canvas.fill(this.red, this.green, this.blue);
    canvas.ellipse(this.x, this.y, this.r, this.r);

    // Write Codename
    canvas.textSize(12);
    canvas.textAlign(CENTER);
    // text(this.currentRanking + 1, this.x, this.y + 60);
    canvas.text(this.value + '%', this.x, this.y + 60);
    canvas.text(this.code, this.x, this.y + 75);    

  }

}
