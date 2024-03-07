class Button {
  PImage button;
  float x;
  float y;
  boolean mouse_pressed = false;

  Button(String image_path) {
    button = loadImage(image_path);
  }
  
  void newImage(String path){
    button = loadImage(path);
  }

  void setPos(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void drawing() {
    float image_width = button.width * 2;
    float image_height = button.height * 2;
    image(button, x, y, image_width, image_height);
  }

  boolean clicked() {
    if (!mouse_pressed) {
      if (mousePressed && isMouseOnImage()) {// ckeck if the mouse is currently pressed
        mouse_pressed = true; 
      }
    } else {
      if (!mousePressed) { 
        mouse_pressed = false; 
        return true;
      }
    }
    return false; // button was not clicked
  }

  boolean isMouseOnImage() {
    if (mouseX > x && mouseX < (x + button.width * 2)) {
      if (mouseY > y && mouseY < (y + button.height * 2)) {
        return true;
      }
    }
    return false;
  }
}
