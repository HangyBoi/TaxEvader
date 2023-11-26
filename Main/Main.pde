SceneManager sceneManager;
DoorWay fromWindowToFrontDoor;
DoorWay fromFrontDoorToWindow;
DoorWay fromFrontDoorToKitchen;
DoorWay fromKitchenToBathroom;

float padding = 50;
float rectW = 800;
float rectH = 100;

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

  // Initializing rectangular doorways for each scene
  fromWindowToFrontDoor = new DoorWay(width / 2, height - padding, rectW, rectH);
  fromFrontDoorToWindow = new DoorWay(width / 2, height - padding, rectW, rectH);
  fromFrontDoorToKitchen = new DoorWay(width / 2 - padding / 2, height / 2, rectH + padding, rectW / 2 + padding * 2);
  fromKitchenToBathroom = new DoorWay(width + padding * 2, height / 2, rectH, rectW);
}

void draw() {
  background(255);
  sceneManager.update();

  if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    fromWindowToFrontDoor.render();
  } else if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    fromFrontDoorToWindow.render();
    fromFrontDoorToKitchen.render();
  }
  //} else if (sceneManager.currentScene == )
}

void mouseClicked() {

  // Handle mouse clicks based on the current scene
  if (sceneManager.currentScene == Scene.START) {
    sceneManager.switchScene(Scene.WINDOW_ROOM);
  } else if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    if (fromWindowToFrontDoor.isMouseInsideDoor(mouseX, mouseY, width / 2, height - padding, rectW, rectH)) {
      sceneManager.switchScene(Scene.DOOR_ROOM);
    }
  } else if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    if (fromFrontDoorToWindow.isMouseInsideDoor(mouseX, mouseY, width / 2, height - padding, rectW, rectH)) {
      sceneManager.switchScene(Scene.WINDOW_ROOM);
    }
    if (fromFrontDoorToKitchen.isMouseInsideDoor(mouseX, mouseY, width / 2 - padding / 2, height / 2, rectH + padding, rectW / 2 + padding * 2)) {
      sceneManager.switchScene(Scene.KITCHEN);
    }
  } else if (sceneManager.currentScene == Scene.KITCHEN) {
    sceneManager.switchScene(Scene.BATHROOM);
  } else if (sceneManager.currentScene == Scene.BATHROOM) {
    sceneManager.switchScene(Scene.GAME_OVER);
  } else if (sceneManager.currentScene == Scene.GAME_OVER) {

    sceneManager.switchScene(Scene.START);
  }
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


  // Code for the living room with the window scene
  image(loadImage("livingRoomWindow.jpg"), 0, 0);
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
