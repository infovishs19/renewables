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

class OrdinalScale2 {
 
  String [] domain = null;
  float [] range = null;
  
  HashMap<String,Float>  lookup = new  HashMap<String,Float> ();
  
  OrdinalScale2() {
  }
  
  void domain(String [] dom){
    this.domain =  dom;
  }
  
  void range(float [] ran){
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
      float val = this.range[i];
      lookup.put(theKey,val);
    }
  }
}

class LinearScale {
  
  float [] domain;
  float [] range;
  
  LinearScale() {
  }
  
  void domain(float [] dom){
    this.domain = dom;
  }
  
  void range(float [] ran){
    this.range = ran;
  }
}
