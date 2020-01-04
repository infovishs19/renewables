class OrdinalScale {
 
  String [] domain = null;
  String [] range = null;
  
  HashMap<String,String>  lookup = new  HashMap<String,String> ();
  
  OrdinalScale() {
  }
  
  void domain(String [] dom){
    this.domain =  dom;
  }
  
  void range(String [] ran){
    this.range = ran;
    this.createHash();
  }
  
  void createHash(){
    if(this.domain ==null || this.range == null || this.domain.length != this.range.length){
      println("Error in OrdinalScale");
      return;
    }
    for(int i=0; i<this.domain.length; i++){
      String theKey = this.domain[i];
      String val = this.range[i];
      lookup.put(theKey,val);
    }
  }
}

class LinearScale {
  LinearScale() {
  }
}
