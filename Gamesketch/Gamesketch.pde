//Autor: Ivanna Haiduk
//Date: 02-24-2024


// OSC setup
import netP5.*;
import oscP5.*;

// OSC Messages
OscP5 osc = new OscP5(this, 1234);
NetAddress meineAdresse = new NetAddress("127.0.0.1", 1234);
OscMessage buttonMessage = new OscMessage("button");
OscMessage obstacle_hitMessage = new OscMessage("obstacle_hit");
OscMessage spike_hitMessage = new OscMessage("spike_hit");
OscMessage scoreMessage = new OscMessage("score");
OscMessage monsterMessage = new OscMessage("jump");
OscMessage gameoverMessage = new OscMessage("gameover");


int score;
float speed = 5; // spikes
float speed2 = 2; // stone and flower
float speed3= random(2,8);// obstacle
float gap = 250;// gap between spikes
int spike_number = 2;
int stone_number = 3;
int obstacle_number = 3;
float start_birdx = 100;
float start_birdy = 100;

boolean start_game = false;
String button_play_path = "./pics/play.png";
String button_playagain_path = "./pics/playagain.png";
float button_x = 300;
float button_y = 410;
PFont font;

int gameState;

// Objects
Background background;
Spike spike[];
Bird bird;
Flower flower;
Stone stone[];
Obstacle obstacle[];
Button button;


void setup() {
  size(1200, 950);
  background = new Background();
  font = loadFont("./data/BerlinSansFB-Bold-48.vlw");
  button = new Button(button_play_path);
  button.setPos(button_x, button_y);
  resetGame(false);
}

void resetGame(boolean start) { // reset game parameters and initialize objects
  score = 0;
  spike = new Spike[spike_number];
  for (int i = 0; i<spike_number; i++) {
    spike[i] = new Spike(i);
  }
  
  bird = new Bird();
  flower = new Flower();

  obstacle = new Obstacle[obstacle_number];
  for (int i = 0; i < obstacle_number; i++) {
    obstacle[i] = new Obstacle(i);
  }

  stone = new Stone[stone_number];
  for (int i = 0; i < stone_number; i++) {
    stone[i] = new Stone(i);
  }
  start_game = start;
  gameState = 0;
}

void draw() {

  background.drawingBackground();
 
  if (start_game) {
    if (gameState == 0) { // game starts
      
      background.actBackground();

      fill(255);
      textSize(32);
      textFont(font);
      text("Score: " + score, 40, 60);

      for (int i = 0; i < stone_number; i++) {
        stone[i].drawing();
        stone[i].animation();
        stone[i].act();
      }

      for (int i = 0; i < obstacle_number; i++) {
        obstacle[i].drawing();
        obstacle[i].animation();
        obstacle[i].act();
        
        if (obstacle[i].hit(bird.bird_x, bird.bird_y, bird.image_width, bird.image_height)) { // when bird hits the obstacle
          osc.send(obstacle_hitMessage, meineAdresse);
          osc.send(gameoverMessage, meineAdresse);
          gameState = 1;
        }
      }

      flower.drawing();
      flower.act();
      flower.animation();

      for (int i = 0; i < spike_number; i++) {
        spike[i].drawing();
        spike[i].act();
        
        if (spike[i].hit(bird.bird_x, bird.bird_y, bird.image_width, bird.image_height)) { // when bird hits the spike
          osc.send(spike_hitMessage, meineAdresse);
          osc.send(gameoverMessage, meineAdresse);
          gameState = 1; 
        } else if (spike[i].passedBird(bird.bird_x, bird.image_width)) { 
          osc.send(scoreMessage, meineAdresse);
          score += 1; 
        }
      }

      background.drawingBottom();
      bird.animation();
      background.actBottom();

      if (bird.bird_y + bird.image_height + 10>= height || gameState == 1) { //when bird has reached the ground or collided with an obstacle/spike
        osc.send(gameoverMessage, meineAdresse);
        gameState = 1; //game state to game over
        start_game = false; // restart
      }
    }
  } else {
    if (gameState == 1) { // game is finished
      fill(255);
      textSize(32);
      textFont(font);
     
      text("Score: " + score, 40, 60);
      button.newImage(button_playagain_path); // changed button to play again
    }
    button.drawing();
    if (button.clicked()) {
      osc.send(buttonMessage, meineAdresse);
      resetGame(true);// game starts again
    }
  }

  bird.drawing();
}
