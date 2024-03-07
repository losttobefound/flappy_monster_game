class Obstacle {
  String image_path[] = {"./pics/fly1.png", "./pics/fly2.png", "./pics/fly3.png"};
  PImage obstacle[];
  float obstacle_x;
  float obstacle_y;
  float image_width;
  float image_height;
  int animation;
  float time;

  float size;
  float animation_time = 0.2;

  Obstacle(int obstacle_number) {
    obstacle = new PImage[image_path.length];
    for (int i = 0; i < image_path.length; i++) {
      obstacle[i] = loadImage(image_path[i]);
    }
    float initialX = width + obstacle_number;
    if (stone_number > 0) {
      initialX += obstacle_number * 800; // adjust x position to avoid overlapping
    }
    obstacle_x = initialX;
    obstacle_y = 700;
  }

  void drawing() {
    image_width = obstacle[0].width * width / background.back.width * size + 5; // adjustment to the size of the background
    image_height = obstacle[0].height * height / background.back.height * size;
    image(obstacle[animation], obstacle_x, obstacle_y, image_width, image_height);
  }

  void act() {
    obstacle_x -= random(6, 8); // random horizontal velocity
    obstacle_y += random(-2, 2); // random vertical velocity

    if (obstacle_x < -image_width) {
      obstacle_x = width + random(700, 1500);
      obstacle_y = random(200, 785);
      size = random(0.1, 0.2);// set new random size for the obstacle
    }
  }

  void animation() {
    float delta_time = 2/frameRate; // Speed per second
    time = time + delta_time;

    if (time >= animation_time) {
      animation++;
      if (animation >= image_path.length) {
        animation = 0;
      }
    }
  }

  boolean hit(float object_x, float object_y, float object_width, float object_height) {
    for (int i = 0; i < obstacle_number; i++) {
      // check for collision between the bird and the current obstacle
      if (object_x + object_width - 20 >= obstacle_x &&
        object_x <= obstacle_x + image_width &&
        object_y + object_height - 20 >= obstacle_y &&
        object_y <= obstacle_y + image_height) {
        return true; // collision detected
      }
    }
    return false; 
  }
}
