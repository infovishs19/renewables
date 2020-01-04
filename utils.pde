ArrayList<DataObject> loadData(String path) {
  Table t = loadTable(path, "header");
  println(t.getRowCount() + " total rows in table");

  ArrayList<DataObject> arr = new ArrayList<DataObject>();
  //name,size,year,absoluteLength,breitengrad,laengengrad
  for (TableRow row : t.rows()) {


    String CountryName = row.getString("CountryName");
    float Lat = row.getFloat("Lat");
    float Lon = row.getFloat("Lon");
    float Surface = row.getFloat("Surface");
    String Code  = row.getString("Code");
    String Region = row.getString("Region");
    String IncomeGroup = row.getString("IncomeGroup");
    float E1990= row.getFloat("E1990");
    float E1991= row.getFloat("E1991");
    float E1992= row.getFloat("E1992");
    float E1993= row.getFloat("E1993");
    float E1994= row.getFloat("E1994");
    float E1995= row.getFloat("E1995");
    float E1996= row.getFloat("E1996");
    float E1997= row.getFloat("E1997");
    float E1998= row.getFloat("E1998");
    float E1999= row.getFloat("E1999");
    float E2000= row.getFloat("E2000");
    float E2001= row.getFloat("E2001");
    float E2002= row.getFloat("E2002");
    float E2003= row.getFloat("E2003");
    float E2004= row.getFloat("E2004");
    float E2005= row.getFloat("E2005");
    float E2006= row.getFloat("E2006");
    float E2007= row.getFloat("E2007");
    float E2008= row.getFloat("E2008");
    float E2009= row.getFloat("E2009");
    float E2010= row.getFloat("E2010");
    float E2011= row.getFloat("E2011");
    float E2012= row.getFloat("E2012");
    float E2013= row.getFloat("E2013");
    float E2014= row.getFloat("E2014");
    float E2015= row.getFloat("E2015");
    float EWachstum= row.getFloat("EWachstum");
    float P1990= row.getFloat("P1990");
    float P1991= row.getFloat("P1991");
    float P1992= row.getFloat("P1992");
    String P1993= row.getString("P1993");
    float P1994= row.getFloat("P1994");
    float P1995= row.getFloat("P1995");
    float P1996= row.getFloat("P1996");
    float P1997= row.getFloat("P1997");
    float P1998= row.getFloat("P1998");
    float P1999= row.getFloat("P1999");
    float P2000= row.getFloat("P2000");
    float P2001= row.getFloat("P2001");
    float P2002= row.getFloat("P2002");
    float P2003= row.getFloat("P2003");
    float P2004= row.getFloat("P2004");
    float P2005= row.getFloat("P2005");
    float P2006= row.getFloat("P2006");
    float P2007= row.getFloat("P2007");
    float P2008= row.getFloat("P2008");
    float P2009= row.getFloat("P2009");
    float P2010= row.getFloat("P2010");
    float P2011= row.getFloat("P2011");
    float P2012= row.getFloat("P2012");
    float P2013= row.getFloat("P2013");
    float P2014= row.getFloat("P2014");
    float P2015= row.getFloat("P2015");


    println(CountryName + "," + Lat + "," + Lon);

    DataObject d = new  DataObject( CountryName, Lat, Lon, Surface, Code, Region, IncomeGroup, E1990, E1991, E1992, E1993, E1994, E1995, E1996, E1997, E1998, E1999, E2000, E2001, E2002, E2003, E2004, E2005, E2006, E2007, E2008, E2009, E2010, E2011, E2012, E2013, E2014, E2015, EWachstum, P1990, P1991, P1992, P1993, P1994, P1995, P1996, P1997, P1998, P1999, P2000, P2001, P2002, P2003, P2004, P2005, P2006, P2007, P2008, P2009, P2010, P2011, P2012, P2013, P2014, P2015);
    arr.add(d);
  }

  println("ArrayList length: " + arr.size());

  return arr;
}
