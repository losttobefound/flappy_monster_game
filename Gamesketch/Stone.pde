class Stone {
  String image_path[] = {"./pics/stone1.png", "./pics/stone2.png", "./pics/stone3.png", "./pics/stone4.png"};
  PImage stone[];
  float stone_x;
  float stone_y;
  float image_width;
  float image_height; // to fit image to the window size
  int animation;
  float time;

  float size = random(0.1, 0.2);
  float animation_time = 1.5;


  Stone(int stone_number) {
    stone = new PImage[image_path.length];
    for (int i = 0; i < image_path.length; i++) {
      stone[i] = loadImage(image_path[i]);
    }
    float initialX = width + stone_number;
    if (stone_number > 0) {
      initialX += stone_number * 500; // adjust initial x position to avoid overlapping
    }
    stone_x = initialX;
    stone_y = random(769, 785);
  }

  void drawing() {
    image_width = stone[0].width * width / background.back.width * size + 15; // adjustment to the size of the background
    image_height = stone[0].height * height / background.back.height * size;
    image(stone[animation], stone_x, stone_y, image_width, image_height); //  draws stone calculated width and height
  }
  void setY() {
    stone_y = random(769, 785);
  }

  void act() {
    stone_x = stone_x - speed2;

    if (stone_x < -image_width) {
      stone_x = width + random (500, 800);
      setY(); // sets randommly position
    }
  }

  void animation() {
    float delta_time = 1/frameRate;//speed
    time = time + delta_time;

    if (time >= animation_time) {
      animation++;
      if (animation>= image_path.length) {
        animation = 0;
      }
    }
  }
}
