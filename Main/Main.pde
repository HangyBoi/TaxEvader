SceneManager sceneManager;

PImage cursorIdleStateImg, cursorObjInteractImg;

final float padding = 50;
float rectW = 800;
float rectH = 100;

DoorWay[] doorways = new DoorWay[8];

void setup() {
  fullScreen();

  cursorIdleStateImg = loadImage("idleCursor.png");
  cursorIdleStateImg.resize(32, 32);
  cursorObjInteractImg = loadImage("interactCursor.png");
  cursorObjInteractImg.resize(32, 32);

  sceneManager = new SceneManager();

  sceneManager.addScene(Scene.START, this::startScene);
  sceneManager.addScene(Scene.WINDOW_ROOM, this::livingRoomWindowScene);
  sceneManager.addScene(Scene.DOOR_ROOM, this::livingRoomDoorScene);
  sceneManager.addScene(Scene.HALLWAY, this::hallwayScene);
  sceneManager.addScene(Scene.KITCHEN, this::kitchenScene);
  sceneManager.addScene(Scene.BATHROOM, this::bathroomScene);
  sceneManager.addScene(Scene.GAME_OVER, this::gameOverScene);

  initializeDoorways();
}

void initializeDoorways() {
  doorways[0] = new DoorWay(width / 2, height - padding, rectW, rectH); //WINDOW -> DOOR
  doorways[1] = new DoorWay(width / 2, height - padding, rectW, rectH); //DOOR -> WINDOW
  doorways[2] = new DoorWay(width / 2 - padding / 2, height / 2, rectH + padding, rectW / 2 + padding * 2); //DOOR -> HALLWAY
  doorways[3] = new DoorWay(width / 2, height - padding, rectW, rectH); //HALLWAY -> DOOR
  doorways[4] = new DoorWay(width / 2 - padding * 1.5, height / 2 + padding * 2, rectH * 4, rectW / 1.5); //HALLWAY -> KITCHEN
  doorways[5] = new DoorWay(width / 5 - padding, height / 2 + padding * 3, rectH * 3, rectW - padding); //HALLWAY -> BATHROOM
  doorways[6] = new DoorWay(padding * 3, height / 2 + padding, rectH * 3, rectW - padding * 2); //KITCHEN -> HALLWAY
  doorways[7] = new DoorWay(width - rectH * 2 - padding * 2, height / 2, rectH * 2, height); //BATHROOM -> HALLWAY
}

void draw() {
  background(255);
  sceneManager.update();

  if (isMouseInsideDoor()) {
    cursor(cursorObjInteractImg);
  } else {
    cursor(cursorIdleStateImg);
  }

  renderDoorways();
}

void renderDoorways() {
  int[] renderIndices = getRenderIndices(sceneManager.currentScene);
  for (int index : renderIndices) {
    doorways[index].render();
  }
}

boolean isMouseInsideDoor() {
  int[] checkIndices = getCheckIndices(sceneManager.currentScene);
  for (int index : checkIndices) {
    if (doorways[index].isMouseInsideDoor(mouseX, mouseY)) {
      return true;
    }
  }
  return false;
}

void mouseClicked() {
  Scene targetScene = null;

  if (sceneManager.currentScene == Scene.START) {
    targetScene = Scene.WINDOW_ROOM;
  } else {
    int[] checkIndices = getCheckIndices(sceneManager.currentScene);
    for (int index : checkIndices) {
      if (doorways[index].isMouseInsideDoor(mouseX, mouseY)) {
        targetScene = getTargetScene(index);
        break;
      }
    }
  }

  if (targetScene != null) {
    sceneManager.switchScene(targetScene);
  }
}

int[] getRenderIndices(Scene currentScene) {
  switch (currentScene) {
  case WINDOW_ROOM:
    return new int[]{0};
  case DOOR_ROOM:
    return new int[]{1, 2};
  case HALLWAY:
    return new int[]{3, 4, 5};
  case KITCHEN:
    return new int[]{6};
  case BATHROOM:
    return new int[]{7};
  default:
    return new int[]{};
  }
}

int[] getCheckIndices(Scene currentScene) {
  switch (currentScene) {
  case WINDOW_ROOM:
    return new int[]{0};
  case DOOR_ROOM:
    return new int[]{1, 2};
  case HALLWAY:
    return new int[]{3, 4, 5};
  case KITCHEN:
    return new int[]{6};
  case BATHROOM:
    return new int[]{7};
  default:
    return new int[]{};
  }
}

Scene getTargetScene(int index) {
  switch (index) {
  case 0:
    return Scene.DOOR_ROOM;
  case 1:
    return Scene.WINDOW_ROOM;
  case 2:
    return Scene.HALLWAY;
  case 3:
    return Scene.DOOR_ROOM;
  case 4:
    return Scene.KITCHEN;
  case 5:
    return Scene.BATHROOM;
  case 6:
    return Scene.HALLWAY;
  case 7:
    return Scene.HALLWAY;
  default:
    return null;
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
