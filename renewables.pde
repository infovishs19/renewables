int canvasW = 7680;
int canvasH = 1080;
PGraphics canvas;


// Processing Standard Functions
void settings() 
{
  size(canvasW/2, canvasH/2, P3D);
  PJOGL.profile=1;
}

void setup() {

  canvas = createGraphics(canvasW, canvasH, P3D);
  
}

void draw(){
  background(255,0,0);
  image(canvas,0,0,width,height);
}
