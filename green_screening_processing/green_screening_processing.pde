import processing.video.*;

Movie movie;
PImage imgReplacer;
PImage finalFrame;

void setup() {
  size(1280, 720);
  movie = new Movie(this, "greenscreen.mp4");
  imgReplacer = loadImage("beach.jpg");
  imgReplacer.loadPixels();
  movie.loop();
}

void draw() {
  movie.loadPixels();
  finalFrame = createImage(movie.width, movie.height, RGB);
  
  for (int j = 0; j < movie.height; j++) {
    for (int i = 0; i < movie.width; i++) {
      int index = i+(j*movie.width);
      float red = (movie.pixels[index] >> 16) & 0xFF;
      float green = (movie.pixels[index] >> 8) & 0xFF;
      float blue = movie.pixels[index] & 0xFF;

      if (green > red + blue) {
        float newRed = (imgReplacer.pixels[index] >> 16) & 0xFF;
        float newGreen = (imgReplacer.pixels[index] >> 8) & 0xFF;
        float newBlue = imgReplacer.pixels[index] & 0xFF;

        finalFrame.pixels[index] = color(newRed, newGreen, newBlue);
      } else {
        finalFrame.pixels[index] = movie.pixels[index];
      }
    }
  }
  finalFrame.updatePixels();

  image(finalFrame, 0, 0);
}

void movieEvent(Movie m) {
  m.read();
}
