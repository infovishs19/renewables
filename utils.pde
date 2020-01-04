ArrayList<Gletscher> loadGlacierData(String path) {
  Table t = loadTable(path, "header");
  println(t.getRowCount() + " total rows in table");

  ArrayList<Gletscher> arr = new ArrayList<Gletscher>();
  //name,size,year,absoluteLength,breitengrad,laengengrad
  for (TableRow row : t.rows()) {

    String name = row.getString("name");
    int size = row.getInt("size");
    int year =  row.getInt("year");
    int absoluteLength =  row.getInt("absoluteLength");
    int breitengrad = row.getInt("breitengrad");
    int laengengrad= row.getInt("laengengrad");

    println(name + "," + size + "," + year);

    Gletscher g = new Gletscher( name, size, year, absoluteLength, breitengrad, laengengrad);
    arr.add(g);
  }

  println("ArrayList length: " + arr.size());

  return arr;
}
