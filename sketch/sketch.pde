//Bibliotecas usada para criar um color picker
import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.utils.*;

//Arrays onde serão armazenadas as duas imagens
PImage d[], n[], s[]; 
//Va
boolean showSpec = true;
boolean showDif = true;
int imgIndex = 0;
int imageCount = 2;
int w = 500;
int h = 740;

//Inicializando arrays bidimensionais de vetores para armazenar os valores de cada pixel
PVector diffuseMap[][] = new PVector[w][h];
PVector normalMap[][] = new PVector[w][h];
PVector specMap[][] = new PVector[w][h];
PVector targetMap[][] = new PVector[w][h];
PVector Im = new PVector(255, 255, 255);
PVector Ka = new PVector(0,0,0);

void setup() {
  size(500, 800);
  d = new PImage[imageCount];
  n = new PImage[imageCount];
  s = new PImage[imageCount];

  d[0] = loadImage("char1_d.png");
  n[0] = loadImage("char1_n.png");
  s[0] = loadImage("char1_s.png");

  d[1] = loadImage("char2_d.png");
  n[1] = loadImage("char2_n.png");
  s[1] = loadImage("char2_s.png");

  initializeImage();
}

void initializeImage() {
  loadPixels();
  d[imgIndex].loadPixels();
  n[imgIndex].loadPixels();
  s[imgIndex].loadPixels();
  images();
}

void images() {
  for (int x = 0; x < d[imgIndex].width; x++) {
    for (int y = 0; y < d[imgIndex].height; y++) {
      diffuseMap[x][y] = new PVector(red(d[imgIndex].pixels[y * d[imgIndex].width + x]), green(d[imgIndex].pixels[y * d[imgIndex].width + x]), blue(d[imgIndex].pixels[y * d[imgIndex].width + x]));
      normalMap[x][y] = new PVector(red(n[imgIndex].pixels[y * n[imgIndex].width + x]), green(n[imgIndex].pixels[y * n[imgIndex].width + x]), blue(n[imgIndex].pixels[y * n[imgIndex].width + x])).normalize();
      specMap[x][y] = new PVector(red(s[imgIndex].pixels[y * s[imgIndex].width + x]), green(s[imgIndex].pixels[y * s[imgIndex].width + x]), blue(s[imgIndex].pixels[y * s[imgIndex].width + x]));
    }
  }
}
void keyPressed() {
  // "i" para mudar de imagem
  if (key == 105) {
    imgIndex = imgIndex + 1;
    if (imgIndex >= imageCount) {
      imgIndex = 0;
    }
    initializeImage();
    // "s" alternar para modo especular
  } else if (key == 115) {
    showSpec = true;
    showDif = false;
    // "d" alternar para difuso
  } else if (key == 100) {
    showSpec = false;
    showDif = true;
    // "a" alternar para ambos os modos
  } else if(key == 97){
    showSpec = true;
    showDif = true;
    // "c" para abrir o color picker
  } else if (key == 99) {
    color selectedColor = new UiBooster().showColorPicker("Choose your favorite color", "Color picking").getRGB();
    Im = new PVector(red(selectedColor), green(selectedColor), blue(selectedColor));
  }
}

void draw() {
  background(0);
  loadPixels();
  
  //map(mouseX, 0 , width, -width/2, width/2), map(mouseY, 0, height, -height/2, height/2)
  PVector L = new PVector(map(mouseX, 0 , width, -1, 1), map(mouseY, 0, height, -1, 1), 1).normalize();
  
  for (int x = 0; x < d[imgIndex].width; x++) {
    for (int y = 0; y < d[imgIndex].height; y++) {
      PVector Kd, N, Ks; 

      float nx = map(x, 0, d[imgIndex].width, -1, 1), ny = map(y, 0, d[imgIndex].height, -1, 1);
      PVector V = new PVector(nx, ny, 1).normalize();
      Kd = diffuseMap[x][y];
      N = normalMap[x][y];
      Ks = specMap[x][y];
      float val = -2*N.dot(L);
      PVector R = PVector.sub(L, PVector.mult(N, val)).normalize();
      float q = 256;
      int index = y * width + x;
      
      //Vetor onde poderá ser armazenado as componentes difusa e especular
      PVector temp = new PVector(red(pixels[index]), green(pixels[index]), blue(pixels[index]));
      
      //Calculando a componente difusa
      if (showDif) {
        float value = L.dot(N);
        if (value<0)value=0;
        temp.x+= floor(Im.x*value  * Kd.x/255);
        temp.y+= floor(Im.y*value  * Kd.y/255);
        temp.z+= floor(Im.z*value  * Kd.z/255);
      }
      
      //Calculando a componente especular
      if (showSpec) {
        float value = R.dot(V);
        if (value<0)value=0;
        float vq = pow(value, q);
        temp.x+= floor(Im.x * vq * Ks.x/255);
        temp.y+= floor(Im.y * vq * Ks.y/255);
        temp.z+= floor(Im.z * vq * Ks.z/255);
      }
      pixels[index] = color(Ka.x + temp.x,Ka.y + temp.y,Ka.z + temp.z);
    }
  }
  updatePixels();
}
