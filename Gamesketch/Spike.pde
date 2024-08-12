class Spike{ 
  PImage top_spike;
  PImage bottom_spike;

  float spike_x;
  float spike_y;
  float image_width;
  float image_height;
  boolean passed; // tracks if the bird has passed through this spike

  Spike(int number){
    bottom_spike = loadImage("./pics/spikeC1.png");
    top_spike = loadImage("./pics/spikeC.png");
    spike_x = width /spike_number * (number+1);// location of each spike
    setY();
    passed = false; 
  }
  
  void drawing(){
    image_width = bottom_spike.width * width / background.back.width;
    image_height = bottom_spike.height * height / background.back.height;
    image(bottom_spike, spike_x, spike_y + gap/2, image_width, image_height);
    image(top_spike, spike_x, spike_y - gap/2 - image_height, image_width, image_height);
  }
  
  void setY(){
    spike_y = random(height/6, height / 8*5 );
  }
    
  void act(){
    spike_x = spike_x - speed;
    
    if (spike_x < -image_width){
      spike_x = width; // spikes appear continuously
      setY();
      passed = false; // reset when spike reappears
    }
  }
  
  boolean hit(float object_x, float object_y, float object_width, float object_height){ 
    float bird_collision_width = object_width * 0.8;
    float bird_collision_height = object_height * 0.2;

    //top spike
    boolean topCollision = object_x + bird_collision_width > spike_x &&
                           object_x < spike_x + image_width &&
                           object_y < spike_y - gap/2 &&
                           object_y + bird_collision_height > spike_y - gap/2 - image_height;

    //bottom spike
    boolean bottomCollision = object_x + bird_collision_width > spike_x &&
                              object_x < spike_x + image_width &&
                              object_y < spike_y + gap/2 + image_height &&
                              object_y + bird_collision_height > spike_y + gap/2;

    if (topCollision || bottomCollision) {
      println("Collision detected");
      return true;
    }
    
    return false;
  }
  
  boolean passedBird(float bird_x, float bird_width) {
    if (bird_x > spike_x + image_width && !passed) {
      passed = true; // update passed spike
      return true;
    }
    return false;
  }
}
