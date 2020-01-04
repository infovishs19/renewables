class DataObject implements Comparable<DataObject> {

  String CountryName;
  float Lat;
  float Lon;
  float Surface;
  String Code;
  String Region;
  String IncomeGroup;
  float E1990;
  float E1991;
  float E1992;
  float E1993;
  float E1994;
  float E1995;
  float E1996;
  float E1997;
  float E1998;
  float E1999;
  float E2000;
  float E2001;
  float E2002;
  float E2003;
  float E2004;
  float E2005;
  float E2006;
  float E2007;
  float E2008;
  float E2009;
  float E2010;
  float E2011;
  float E2012;
  float E2013;
  float E2014;
  float E2015;
  float EWachstum;
  float P1990;
  float P1991;
  float P1992;
  String P1993;
  float P1994;
  float P1995;
  float P1996;
  float P1997;
  float P1998;
  float P1999;
  float P2000;
  float P2001;
  float P2002;
  float P2003;
  float P2004;
  float P2005;
  float P2006;
  float P2007;
  float P2008;
  float P2009;
  float P2010;
  float P2011;
  float P2012;
  float P2013;
  float P2014;
  float P2015;

  HashMap<String, Float> lookup = new HashMap<String, Float>();

  DataObject(String CountryName, 
    float Lat, 
    float Lon, 
    float Surface, 
    String Code, 
    String Region, 
    String IncomeGroup, 
    float E1990, 
    float E1991, 
    float E1992, 
    float E1993, 
    float E1994, 
    float E1995, 
    float E1996, 
    float E1997, 
    float E1998, 
    float E1999, 
    float E2000, 
    float E2001, 
    float E2002, 
    float E2003, 
    float E2004, 
    float E2005, 
    float E2006, 
    float E2007, 
    float E2008, 
    float E2009, 
    float E2010, 
    float E2011, 
    float E2012, 
    float E2013, 
    float E2014, 
    float E2015, 
    float EWachstum, 
    float P1990, 
    float P1991, 
    float P1992, 
    String P1993, 
    float P1994, 
    float P1995, 
    float P1996, 
    float P1997, 
    float P1998, 
    float P1999, 
    float P2000, 
    float P2001, 
    float P2002, 
    float P2003, 
    float P2004, 
    float P2005, 
    float P2006, 
    float P2007, 
    float P2008, 
    float P2009, 
    float P2010, 
    float P2011, 
    float P2012, 
    float P2013, 
    float P2014, 
    float P2015) {


    this.CountryName=CountryName;
    this.Lat=Lat;
    this.Lon=Lon;
    this.Surface=Surface;
    this.Code=Code;
    this.Region=Region;
    this.IncomeGroup=IncomeGroup;
    this.E1990=E1990;
    // lookup.put("E1990",E1990);
    this.E1991=E1991;
    // lookup.put("E1991",E1991);
    this.E1992=E1992;
    //  lookup.put("E1991",E1991);
    this.E1993=E1993;
    this.E1994=E1994;
    this.E1995=E1995;
    this.E1996=E1996;
    this.E1997=E1997;
    this.E1998=E1998;
    this.E1999=E1999;
    this.E2000=E2000;
    this.E2001=E2001;
    this.E2002=E2002;
    this.E2003=E2003;
    this.E2004=E2004;
    this.E2005=E2005;
    this.E2006=E2006;
    this.E2007=E2007;
    this.E2008=E2008;
    this.E2009=E2009;
    this.E2010=E2010;
    this.E2011=E2011;
    this.E2012=E2012;
    this.E2013=E2013;
    this.E2014=E2014;
    this.E2015=E2015;
    this.EWachstum=EWachstum;
    this.P1990=P1990;
    this.P1991=P1991;
    this.P1992=P1992;
    this.P1993=P1993;
    this.P1994=P1994;
    this.P1995=P1995;
    this.P1996=P1996;
    this.P1997=P1997;
    this.P1998=P1998;
    this.P1999=P1999;
    this.P2000=P2000;
    this.P2001=P2001;
    this.P2002=P2002;
    this.P2003=P2003;
    this.P2004=P2004;
    this.P2005=P2005;
    this.P2006=P2006;
    this.P2007=P2007;
    this.P2008=P2008;
    this.P2009=P2009;
    this.P2010=P2010;
    this.P2011=P2011;
    this.P2012=P2012;
    this.P2013=P2013;
    this.P2014=P2014;
    this.P2015=P2015;


    //make a lookup for all years
    Field[] fields = DataObject.class.getDeclaredFields();
    println("fields.length:  "  + fields.length);
    for (int i=0; i<fields.length; i++) {
      Field f = fields[i];
      String name = f.getName();
      println("field name: " + name);
      if (name.startsWith("E")) {
        try {
          float value = f.getFloat(this);
          println("value: " + value);
          lookup.put(name, value);
        }
        catch(IllegalAccessException e) {
          e.printStackTrace();
        }
      }
    }
    
  }
  
  float getValue(String yearKey){
    
    float result =  this.lookup.get(yearKey);
    //println("yearKey of " + this.CountryName + " , " + yearKey + " value: " + result);
    return result;
  }
  
  String toString(){
    return this.CountryName + ", " + this.getValue(currentYearReference);
  } 
  
  @Override     
  public int compareTo(DataObject other) {          
    if(this.getValue(currentYearReference) < other.getValue(currentYearReference)){
      return 1;
    }else if(other.getValue(currentYearReference) < this.getValue(currentYearReference)){
      return -1;
    }
    else return 0;
  }
}
