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
  
  String map(String s){
    return lookup.get(s);
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
  
  float map(String s){
    return lookup.get(s);
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
  
  float map(float n){
    return PApplet.map(n,this.domain[0],this.domain[1],this.range[0],this.range[1]);
  }
}
