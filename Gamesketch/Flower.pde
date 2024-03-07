class Flower {
  String image_path[] = {"./pics/flower1.png", "./pics/flower2.png"};
  PImage flower[];
  float flower_x;
  float flower_y;
  float image_width;
  float image_height; // to fit image to the window size
  int animation;
  float time;

  float size = 0.2;
  float animation_time = 1.9;


  Flower() {
    flower = new PImage[image_path.length];
    for (int i = 0; i < image_path.length; i++) {
      flower[i] = loadImage(image_path[i]);
    }
    flower_x = 200;
    flower_y = 750;
  }

  void drawing() {
    image_width = flower[0].width * width / background.back.width * size + 15; // adjustment to the size of the background
    image_height = flower[0].height * height / background.back.height * size;
    image(flower[animation], flower_x, flower_y, image_width, image_height); //  draws flower calculated width and height
  }

  void setY() {
    flower_y = random(750, 780);
  }

  void act() {
    flower_x = flower_x - speed2;

    if (flower_x < -image_width) {
      flower_x =width; // flower appear continuously
      setY(); // sets randomly the position of flower
    }
  }

  void animation() {
    float delta_time = 2/frameRate;//speed per second
    time = time + delta_time;

    if (time >= animation_time) {
      animation++;
      if (animation>= image_path.length) {
        animation = 0;
      }
    }
  }
}
