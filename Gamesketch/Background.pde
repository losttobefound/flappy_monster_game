class Background {
  PImage back;
  PImage bottom;
  int backx, backy;
  int bottomx, bottomy;

  Background() {
    back = loadImage("./pics/bg.png");
    backx = 0;
    backy = 0;
    bottom= loadImage("./pics/bottom.png");
    bottomx = 0;
    bottomy = 880;
  }

  void drawingBackground() {
    imageMode(CORNER);
    image(back, backx, backy);
    image(back, backx + back.width, backy); // make a continious background
  }
  void actBackground() {
    backx -= 2;// speed

    if (backx <= -back.width) {
      backx = 0; // reset once first image is done
    }
  }
  void drawingBottom() {
    imageMode(CORNER);
    image(bottom, bottomx, bottomy);
    image(bottom, bottomx + bottom.width, bottomy); // make continious bottom to cover spikes
  }
  void actBottom() {
    bottomx -= 2;// speed

    if (bottomx <= -bottom.width) {
      bottomx = 0; // reset once first image is done
    }
  }
}
