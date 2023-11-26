//HELLO BUDDY!!

SceneManager sceneManager;

void setup() {
  fullScreen();
  sceneManager = new SceneManager();

  // Add scenes to the manager
  sceneManager.addScene(Scene.START, this::startScene);
  sceneManager.addScene(Scene.WINDOW_ROOM, this::livingRoomWindowScene);
  sceneManager.addScene(Scene.DOOR_ROOM, this::livingRoomDoorScene);
  sceneManager.addScene(Scene.KITCHEN, this::kitchenScene);
  sceneManager.addScene(Scene.BATHROOM, this::bathroomScene);
  sceneManager.addScene(Scene.GAME_OVER, this::gameOverScene);
}

void draw() {
  background(255);
  sceneManager.update();
  rectMode(CENTER);
}

void mouseClicked() {
  
  //////////// TO CHANGE!!!!!
  float rectW = 800;
  float rectH = 200;
  float paddingFromTheBottom = 100;

  // Handle mouse clicks based on the current scene
  if (sceneManager.currentScene == Scene.START) {
    // Handle clicks for the start scene
    // Transition to the next scene if needed
    sceneManager.switchScene(Scene.WINDOW_ROOM);
  } else if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    if (isMouseInsideDoor(mouseX, mouseY, width / 2, height - paddingFromTheBottom, rectW, rectH)) {

      sceneManager.switchScene(Scene.DOOR_ROOM);
    }
  } else if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    // Handle clicks for the bedroom scene
    // Transition to other scenes or perform actions
    sceneManager.switchScene(Scene.KITCHEN);
  } else if (sceneManager.currentScene == Scene.KITCHEN) {
    // Handle clicks for the kitchen scene
    sceneManager.switchScene(Scene.BATHROOM);
  } else if (sceneManager.currentScene == Scene.BATHROOM) {
    sceneManager.switchScene(Scene.GAME_OVER);
  } else if (sceneManager.currentScene == Scene.GAME_OVER) {
    // Handle clicks for the game over scene
    // Restart the game or perform other actions
    sceneManager.switchScene(Scene.START);
  }
}

boolean isMouseInsideDoor(float mouseX, float mouseY, float rectX, float rectY, float rectWidth, float rectHeight) {
  return ((mouseX >= rectX - rectWidth) && (mouseX <= rectX + rectWidth) && (mouseY >= rectY - rectHeight) && (mouseY <= rectY + rectHeight));
}

// Define functions for each scene
void startScene() {
  // Code for the start scene
  fill(0);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Click to start", width / 2, height / 2);
}

void livingRoomWindowScene() {
  //////////// TO CHANGE!!!!!
  float rectW = 800;
  float rectH = 200;
  float paddingFromTheBottom = 100;
  // Code for the living room with the window scene
  image(loadImage("livingRoomWindow.jpg"), 0, 0);
  noFill();
  strokeWeight(2);
  rect(width / 2, height - paddingFromTheBottom, rectW, rectH);
}

void livingRoomDoorScene() {
  // Code for the bedroom scene
  image(loadImage("livingRoomDoor.jpg"), 0, 0);
}

void kitchenScene() {
  // Code for the kitchen scene
  image(loadImage("kitchenRoom.jpg"), 0, 0);
}

void bathroomScene() {
  image(loadImage("bathRoom.jpg"), 0, 0);
}

void gameOverScene() {
  // Code for the game over scene
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(24);
  text("Game Over. Click to restart", width / 2, height / 2);
}
