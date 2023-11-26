SceneManager sceneManager;

DoorWay fromWindowToFrontDoor;
DoorWay fromFrontDoorToWindow;
DoorWay fromFrontDoorToHallway;
DoorWay fromHallwayToFrontDoor;
DoorWay fromHallwayToKitchen;
DoorWay fromHallwayToBathroom;
DoorWay fromKitchenToHallway;
DoorWay fromBathroomToHallway;

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
  sceneManager.addScene(Scene.HALLWAY, this::hallwayScene);
  sceneManager.addScene(Scene.KITCHEN, this::kitchenScene);
  sceneManager.addScene(Scene.BATHROOM, this::bathroomScene);
  sceneManager.addScene(Scene.GAME_OVER, this::gameOverScene);

  // Initializing rectangular doorways for each scene
  fromWindowToFrontDoor = new DoorWay(width / 2, height - padding, rectW, rectH);
  fromFrontDoorToWindow = new DoorWay(width / 2, height - padding, rectW, rectH);
  fromFrontDoorToHallway = new DoorWay(width / 2 - padding / 2, height / 2, rectH + padding, rectW / 2 + padding * 2);
  fromHallwayToFrontDoor = new DoorWay(width / 2, height - padding, rectW, rectH);
  fromHallwayToKitchen = new DoorWay(width / 2 - padding * 1.5, height / 2 + padding * 2, rectH * 4, rectW / 1.5);
  fromHallwayToBathroom = new DoorWay(width / 5 - padding, height / 2 + padding * 3, rectH * 3, rectW - padding);
  fromKitchenToHallway = new DoorWay(padding * 3, height / 2 + padding, rectH * 3, rectW - padding * 2);
  fromBathroomToHallway = new DoorWay(width - rectH * 2 - padding * 2, height / 2, rectH * 2, height);
}

void draw() {
  background(255);
  sceneManager.update();

  renderDoorways();
}

void renderDoorways() {
  if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    fromWindowToFrontDoor.render();
  } else if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    fromFrontDoorToWindow.render();
    fromFrontDoorToHallway.render();
  } else if (sceneManager.currentScene == Scene.HALLWAY) {
    fromHallwayToKitchen.render();
    fromHallwayToBathroom.render();
    fromHallwayToFrontDoor.render();
  } else if (sceneManager.currentScene == Scene.KITCHEN) {
    fromKitchenToHallway.render();
  } else if (sceneManager.currentScene == Scene.BATHROOM) {
    fromBathroomToHallway.render();
  }
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
    if (fromFrontDoorToHallway.isMouseInsideDoor(mouseX, mouseY, width / 2 - padding / 2, height / 2, rectH + padding, rectW / 2 + padding * 2)) {
      sceneManager.switchScene(Scene.HALLWAY);
    }
  } else if (sceneManager.currentScene == Scene.HALLWAY) {
    if (fromHallwayToKitchen.isMouseInsideDoor(mouseX, mouseY, width / 2 - padding * 1.5, height / 2 + padding * 2, rectH * 4, rectW / 1.5)) {
      sceneManager.switchScene(Scene.KITCHEN);
    }
    if (fromHallwayToBathroom.isMouseInsideDoor(mouseX, mouseY, width / 5 - padding, height / 2 + padding * 3, rectH * 3, rectW - padding)) {
      sceneManager.switchScene(Scene.BATHROOM);
    }
    if (fromHallwayToFrontDoor.isMouseInsideDoor(mouseX, mouseY, width / 2, height - padding, rectW, rectH)) {
      sceneManager.switchScene(Scene.DOOR_ROOM);
    }
  } else if (sceneManager.currentScene == Scene.KITCHEN) {
    if (fromKitchenToHallway.isMouseInsideDoor(mouseX, mouseY, padding * 3, height / 2 + padding, rectH * 3, rectW - padding * 2)) {
      sceneManager.switchScene(Scene.HALLWAY);
    }
  } else if (sceneManager.currentScene == Scene.BATHROOM) {
    if (fromBathroomToHallway.isMouseInsideDoor(mouseX, mouseY, width - rectH * 2 - padding * 2, height / 2, rectH * 2, height)) {
      sceneManager.switchScene(Scene.HALLWAY);
    }
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

void hallwayScene() {
  image(loadImage("hallwayRoom.jpg"), 0, 0);
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
