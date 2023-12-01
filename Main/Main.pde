SceneManager sceneManager;

PImage cursorIdleStateImg, cursorObjInteractImg;

final float padding = 50;
float rectW = 800;
float rectH = 100;

InteractObject[] doorways = new InteractObject[8];

CollectableObject testDummy;

InventorySlot slot_1;

//SAFE CODE
SafeObject mySafe;
ArrayList<Integer> code = new ArrayList<Integer>();
PImage closedSafe, openSafeMoney;
boolean safeIsOpen = false;

PImage dummySprite;

////////////////////////////////////////////////
// arraylist messages - stores all messages
// link an object to that message
// dummyobject has an ID = 3
// dummyObject.SendText(3);
// arraylist[3]
// dummyObject.SendText("lksdjflksdfl");
////////////////////////////////////////////////

void setup() {
  size(1920, 1080);

  cursorIdleStateImg = loadImage("idleCursor.png");
  cursorIdleStateImg.resize(32, 32);
  cursorObjInteractImg = loadImage("interactCursor.png");
  cursorObjInteractImg.resize(32, 32);

  //Images import
  closedSafe = loadImage("closedSafe.png");
  closedSafe.resize(1920, 1080);
  openSafeMoney = loadImage("openSafeMoney.jpg");
  openSafeMoney.resize(1920, 1080);

  sceneManager = new SceneManager();

  sceneManager.addScene(Scene.START, this::startScene);
  sceneManager.addScene(Scene.WINDOW_ROOM, this::livingRoomWindowScene);
  sceneManager.addScene(Scene.DOOR_ROOM, this::livingRoomDoorScene);
  sceneManager.addScene(Scene.HALLWAY, this::hallwayScene);
  sceneManager.addScene(Scene.KITCHEN, this::kitchenScene);
  sceneManager.addScene(Scene.BATHROOM, this::bathroomScene);
  sceneManager.addScene(Scene.SAFE, this::safeScene);
  //, this::safeSceneUpdate, this::safeSceneExit
  sceneManager.addScene(Scene.GAME_OVER, this::gameOverScene);

  initializeDoorways();

  dummySprite = loadImage("dummySprite.png");
  testDummy = new CollectableObject(300, 300, 100, 100, dummySprite);

  mySafe = new SafeObject(250, height - 300, 200, 450);
  slot_1 = new InventorySlot(width - padding * 2, padding * 2);
}

void initializeDoorways() {
  doorways[0] = new InteractObject(width / 2, height - padding, rectW, rectH); //WINDOW -> DOOR
  doorways[1] = new InteractObject(width / 2, height - padding, rectW, rectH); //DOOR -> WINDOW
  doorways[2] = new InteractObject(width / 2 - padding / 2, height / 2, rectH + padding, rectW / 2 + padding * 2); //DOOR -> HALLWAY
  doorways[3] = new InteractObject(width / 2, height - padding, rectW, rectH); //HALLWAY -> DOOR
  doorways[4] = new InteractObject(width / 2 - padding * 1.5, height / 2 + padding * 2, rectH * 4, rectW / 1.5); //HALLWAY -> KITCHEN
  doorways[5] = new InteractObject(width / 5 - padding, height / 2 + padding * 3, rectH * 3, rectW - padding); //HALLWAY -> BATHROOM
  doorways[6] = new InteractObject(padding * 3, height / 2 + padding, rectH * 3, rectW - padding * 2); //KITCHEN -> HALLWAY
  doorways[7] = new InteractObject(width - rectH * 2 - padding * 2, height / 2, rectH * 2, height); //BATHROOM -> HALLWAY
}

void draw() {
  background(255);
  sceneManager.update();

  if (isMouseInsideObject()) {
    cursor(cursorObjInteractImg);
  } else {
    cursor(cursorIdleStateImg);
  }

  renderDoorways();

  if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    testDummy.display(dummySprite);
  }

  //drawing safe
  if  (sceneManager.currentScene == Scene.SAFE) {
    mySafe.checkingCode();
    mySafe.update();
  }

  slot_1.appear();
}

void renderDoorways() {
  int[] renderIndices = getRenderIndices(sceneManager.currentScene);
  for (int index : renderIndices) {
    if (index < doorways.length) {
      doorways[index].render();
    }
  }
}


boolean isMouseInsideObject() {
  int[] checkIndices = getCheckIndices(sceneManager.currentScene);
  for (int index : checkIndices) {
    if ((index < doorways.length && doorways[index].isMouseInsideObject(mouseX, mouseY))
      ||  (sceneManager.currentScene == Scene.WINDOW_ROOM && mySafe.isMouseInsideObject(mouseX, mouseY))
      || (!testDummy.collected && sceneManager.currentScene == Scene.WINDOW_ROOM && testDummy.isMouseInsideObject(mouseX, mouseY) )) {
      return true;
    }
  }
  return false;
}


void mouseReleased() {
  mySafe.mousePressedSafe(mouseX, mouseY);
}

void mouseClicked() {
  Scene targetScene = null;
  //boolean safeClicked = false;

  if (sceneManager.currentScene == Scene.START) {
    targetScene = Scene.WINDOW_ROOM;
  } else if (mySafe.isMouseInsideObject(mouseX, mouseY) && sceneManager.currentScene == Scene.WINDOW_ROOM) {
    targetScene = Scene.SAFE;
  } else {
    int[] checkIndices = getCheckIndices(sceneManager.currentScene);
    for (int index : checkIndices) {
      if (doorways[index].isMouseInsideObject(mouseX, mouseY)) {
        targetScene = getTargetScene(index);
        break;
      }
    }
  }

  if (targetScene != null) {
    sceneManager.switchScene(targetScene);
  }

  boolean dummyClicked = false;
  if (testDummy.isMouseInsideObject(mouseX, mouseY) && sceneManager.currentScene == Scene.WINDOW_ROOM) {
    dummyClicked = true;
  }

  if (dummyClicked) {
    testDummy.collect();
    slot_1.containedObject = testDummy;
  }

  //if (safe.isMouseInsideObject(mouseX, mouseY) && sceneManager.currentScene == Scene.WINDOW_ROOM) {
  //  safeClicked = true;
  //}

  //if (safeClicked) {
  //}
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
  case SAFE:
    return new int[]{1};
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
  case SAFE:
    return new int[]{1};
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
  case 8:
    return Scene.SAFE;
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
  PImage livingRoom = loadImage("livingRoomWindow.jpg");
  livingRoom.resize(1920, 1080);
  image(livingRoom, 0, 0);
  mySafe.render();
  testDummy.render();
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

void safeScene() {
  push();
  imageMode(CENTER);
  PImage safe = loadImage("closedSafe.png");
  safe.resize(134 * 4, 171 * 4);
  image(safe, width / 2 - 20, height / 2);
  pop();
}

void gameOverScene() {
  // Code for the game over scene
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(24);
  text("Game Over. Click to restart", width / 2, height / 2);
}
