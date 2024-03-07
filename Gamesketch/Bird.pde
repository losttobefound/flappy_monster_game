class Bird {
  String image_path[] ={ "./pics/monster1.png", "./pics/monster2.png", "./pics/monster3.png", "./pics/monster4.png"};

  PImage bird[];
  float bird_x;
  float bird_y;
  float image_width;
  float image_height;

  float size = 0.1f;
  float animation_time = 0.9f;
  float gravitation = 0.3f;
  float jump = 7f;

  int animation;
  float time;
  float y_velocity;

  Bird() {
    time = 0;
    animation = 0; //animation starts
    bird = new PImage[image_path.length];
    for (int i =0; i< image_path.length; i++) {
      bird[i] = loadImage(image_path[i]);
    }
    y_velocity = 10;// speed when bird falls down
    bird_x = start_birdx;// location
    bird_y = start_birdy;
  }
  void drawing() {
    image_width = bird[0].width * width/background.back.width * size + 15; // adjustment to the size of the background
    image_height = bird[0].height * height/background.back.height * size;
    image(bird[animation], bird_x, bird_y, image_width, image_height);
  }

  void animation() {
    y_velocity = y_velocity + gravitation; // bird falls down
    bird_y = bird_y + y_velocity;

    float delta_time = 1/frameRate;//speed 
    time = time + delta_time;

    if (time >= animation_time) {
      animation++;
      if (animation>= image_path.length) {
        animation = 0;
      }
    }
    if (mousePressed) {
      osc.send(monsterMessage, meineAdresse);
      y_velocity = -jump; //jumps up when mouse pressed
    }
  }
}
