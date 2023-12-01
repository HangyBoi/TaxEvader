//V15
import processing.sound.*;

SoundFile easter;
SoundFile music;
SoundFile beep;
SoundFile grr;
SoundFile plant;
SoundFile imusic;
SoundFile unlock;
SoundFile cat;
SoundFile ding;
SoundFile stephen;
SoundFile octopussy;
SoundFile rwg1;
SoundFile rwg2;
SoundFile rwg3;
SoundFile rwg4;
SoundFile ticket;

SceneManager sceneManager;

// Collectibles
CollectableObject[] collectibles = new CollectableObject[8];

// Doorways
InteractObject[] doorways = new InteractObject[17];

// Inventory Slots
InventorySlot[] slots = new InventorySlot[7];

// Dialogues
DialogueBox[] dialogueboxes = new DialogueBox[15];

// Safe
SafeObject mySafe;
ArrayList<Integer> code = new ArrayList<Integer>();
PImage closedSafe, openSafeMoney;
boolean safeIsOpen = false;

// Cursor Images
PImage cursorIdleStateImg, cursorObjInteractImg;


// Other variables
final float padding = 50;
float rectW = 800;
float rectH = 100;

boolean catIsSleeping = false;


int timer = 15;
int seconds = 0;
int minutes = 3;
int totaltimer = ((minutes * 60 + seconds)*60 + timer);
int startTime;






void setup() {
  size(1920, 1080);

  easter = new SoundFile(this, "fnaf.wav");
  music = new SoundFile(this, "Tax_Evader_song.wav");
  grr = new SoundFile(this, "grumpyIRS.wav");
  plant = new SoundFile(this, "MonsterPlant.wav");
  imusic = new SoundFile(this, "Tax_Evader_intro_song_v2_2.wav");
  unlock = new SoundFile(this, "safeUnlock.wav");
  beep = new SoundFile(this, "beepSafe.wav");
  cat = new SoundFile(this, "catMeouw.wav");
  ding = new SoundFile(this, "doorbell-1.wav");
  stephen = new SoundFile(this, "monsterSound.wav");
  octopussy = new SoundFile(this, "squidLaughing.wav");
  rwg1 = new SoundFile(this, "RWGhuh1.wav");
  rwg2 = new SoundFile(this, "RWGhuh2.wav");
  rwg3 = new SoundFile(this, "RWGhuh3.wav");
  rwg4 = new SoundFile(this, "RWGhuh4.wav");
  ticket = new SoundFile(this, "posterRip.wav");



  cursorIdleStateImg = loadImage("idleCursor.png");
  cursorIdleStateImg.resize(32, 32);
  cursorObjInteractImg = loadImage("interactCursorFin.png");
  cursorObjInteractImg.resize(32, 32);

  //Images import
  closedSafe = loadImage("closedSafe.jpg");
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
  sceneManager.addScene(Scene.INTRO, this::intro);
  sceneManager.addScene(Scene.END, this::end);
  sceneManager.addScene(Scene.BOOK_1, this::book1);
  sceneManager.addScene(Scene.BOOK_2, this::book2);
  sceneManager.addScene(Scene.BOOK_3, this::book3);
  sceneManager.addScene(Scene.BOOK_4, this::book4);

  initializeDoorways();
  initializeText();

  mySafe = new SafeObject(280, height - 200, 200, 300);

  collectibles[0] = new CollectableObject(width - padding * 8, 425, 200, 150, "cageEmptySprite.png", null, 200);
  collectibles[1] = new CollectableObject(width / 2 - padding * 2 + 15, 505, 160, 70, "ticketsSprite.png", null, 160);
  collectibles[2] = new CollectableObject(width / 2 - padding * 6 - 10, height / 2 + padding, 150, 150, "moneySprite.png", null, 200);
  collectibles[3] = new CollectableObject(width / 2 - padding *  6 - 15, 780, 200, 150, "umbrellaSprite.png", null, 250);
  collectibles[4] = new CollectableObject(padding * 7 + 20, height - padding * 6 + 30, 60, 100, "keySprite.png", null, 100);
  collectibles[5] = new CollectableObject(width / 2 + padding * 7, height / 2 + 150, 100, 100, "catnipSprite.png", null, 200);
  collectibles[6] = new CollectableObject(width / 2 - padding * 6 - 10, height / 2 + 50, 200, 150, "catSprite.png", "catSleepingSprite.png", 200);
  collectibles[7] = new CollectableObject(width / 2 - padding * 6 - 10, height / 2 + 50, 200, 150, "cageFullSprite.png", null, 200);


  slots[0] = new InventorySlot(width - padding * 2, padding * 2);
  slots[1] = new InventorySlot(width - padding * 2, padding * 6);
  slots[2] = new InventorySlot(width - padding * 2, padding * 10 + 20);
  slots[3] = new InventorySlot(width - padding * 2, padding * 14 + 40);
  slots[4] = new InventorySlot(width - padding * 2, padding * 18 + 30);
  slots[0] = new InventorySlot(width - padding * 2, padding * 2);
  slots[0] = new InventorySlot(width - padding * 2, padding * 2);



  startTime = millis();
}

void initializeDoorways() {
  //InteractObject(float xpos, float ypos, float rwidth, float rheight) {
  doorways[0] = new InteractObject(width / 2, height - padding, rectW, rectH); //WINDOW -> DOOR
  doorways[1] = new InteractObject(width / 2, height - padding, rectW, rectH); //DOOR -> WINDOW
  doorways[2] = new InteractObject(width / 2 - padding / 2, height / 2, rectH + padding, rectW / 2 + padding * 2); //DOOR -> HALLWAY
  doorways[3] = new InteractObject(width / 2, height - padding, rectW, rectH); //HALLWAY -> DOOR
  doorways[4] = new InteractObject(width / 2 - padding * 1.5, height / 2 + padding * 2, rectH * 4, rectW / 1.5); //HALLWAY -> KITCHEN
  doorways[5] = new InteractObject(width / 5 - padding, height / 2 + padding * 3, rectH * 3, rectW - padding); //HALLWAY -> BATHROOM
  doorways[6] = new InteractObject(padding * 3, height / 2 + padding, rectH * 3, rectW - padding * 2); //KITCHEN -> HALLWAY
  doorways[7] = new InteractObject(width - rectH * 2 - padding * 2, height / 2, rectH * 2, height); //BATHROOM -> HALLWAY
  doorways[8] = new InteractObject(0, 0, 650, 1200); //WINDOW -> EXIT
  doorways[9] = new InteractObject(1300, 481, 75, 75); //BATHROOMBOOK
  doorways[10] = new InteractObject(318, 945, 100, 100); //WINDOW -> EXIT
  doorways[11] = new InteractObject(1197, 894, 100, 100); //YELLOW
  doorways[12] = new InteractObject(1552, 748, 75, 55); //GREEN
  doorways[13] = new InteractObject(width/2, height/2, width, height); //BATHROOMBOOK
  doorways[14] = new InteractObject(width/2, height/2, width, height); //WINDOW -> EXIT
  doorways[15] = new InteractObject(width/2, height/2, width, height); //YELLOW
  doorways[16] = new InteractObject(width/2, height/2, width, height); //GREEN
}

void initializeText() {
  //DialogueBox(float xpos, float ypos, float rwidth, float rheight, int messanger)
  dialogueboxes[0] = new DialogueBox(width - rectW*1.815, height / 2.4, rectH * 2, height/5.7, 1);
  dialogueboxes[1] = new DialogueBox(width - rectH * 2 - padding * 7, height / 3.4, rectH * 1.7, height/4.2, 2);
  dialogueboxes[2] = new DialogueBox(width - rectH * 2 - padding * 2.8, height / 2.4, rectH * 2.2, height/5.2, 3);
  dialogueboxes[3] = new DialogueBox(width - rectH * 2 - padding * 11, height / 2, rectH * 2, height/3.3, 4);
  dialogueboxes[4] = new DialogueBox(width - rectH * 2 - padding * 5.1, height / 1.18, rectH * 2.7, height/4, 5);
  dialogueboxes[5] = new DialogueBox(width - rectH * 2 - padding * 24.4, height / 1.8, rectH * 2.2, height/4.7, 6);
  dialogueboxes[6] = new DialogueBox(width - rectH * 2 - padding * 18, height / 1.65, rectH * 4, height/8, 7); //stephen
  dialogueboxes[7] = new DialogueBox(width - rectH * 2 - padding * 32, height / 3.2, rectH * 2.7, height/3.5, 8);
  dialogueboxes[8] = new DialogueBox(0, 0, 650, 1200, 9);
  dialogueboxes[9] = new DialogueBox(0, 0, 650, 1200, 10);
  dialogueboxes[10] = new DialogueBox(0, 0, 650, 1200, 11);
  dialogueboxes[11] = new DialogueBox(0, 0, 650, 1200, 12);
  dialogueboxes[12] = new DialogueBox(width / 2 - padding * 6 - 10, height / 2 + 50, 200, 150, 13);
  dialogueboxes[13] = new DialogueBox(width / 2 - padding * 6 - 10, height / 2 + 50, 200, 150, 14);
  dialogueboxes[14] = new DialogueBox(0, 0, 650, 1200, 15);
}


void draw() {

  background(255);
  sceneManager.update();

  if (isMouseInsideObjectBool()) {
    cursor(cursorObjInteractImg);
  } else {
    cursor(cursorIdleStateImg);
  }

  renderDoorways();
  renderText();

  if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    collectibles[0].display();
    collectibles[1].display();

    dialogueboxes[0].display();
    dialogueboxes[0].update();
  }

  if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    collectibles[6].display();
  }

  if (sceneManager.currentScene == Scene.HALLWAY) {
    collectibles[3].display();
  }

  if (sceneManager.currentScene == Scene.BATHROOM) {
    collectibles[4].display();
  }

  if (sceneManager.currentScene == Scene.SAFE) {
    mySafe.checkingCode();
    mySafe.update();
  }

  if (sceneManager.currentScene == Scene.KITCHEN) {
    collectibles[5].display();
  }

  slots[0].appear();
  slots[1].appear();
  slots[2].appear();
  slots[3].appear();
  slots[4].appear();
  slots[0].appear();



  //drawing safe
  if  (sceneManager.currentScene == Scene.SAFE) {
    mySafe.checkingCode();
    mySafe.update();
    // println(code);
  }



  if  (sceneManager.currentScene != Scene.GAME_OVER && sceneManager.currentScene != Scene.START && sceneManager.currentScene != Scene.INTRO&& sceneManager.currentScene != Scene.END) {
    //timer
    int elapsedMillis = millis() - startTime;
    int elapsedSeconds = elapsedMillis / 1000;

    // Update timer based on elapsed time
    timer = 15 - elapsedSeconds % 60;
    seconds = 59 - elapsedMillis / 1000 % 60;
    minutes = 4 - elapsedMillis / 1000 / 60;


    textSize(50);
    fill(#F5E63B);
    stroke(0);
    strokeWeight(4);
    rect(100, 100, 160, 80, 28);
    fill(10);
    if (seconds < 10) {
      text(minutes + ":0" + seconds, 100, 100);
    } else {
      text(minutes + ":" + seconds, 100, 100);
    }

    if (minutes < 1 && seconds < 1) {
      Scene targetScene = getTargetScene(18);
      sceneManager.switchScene(targetScene);
    }
  }
}

void renderDoorways() {
  int[] renderIndices = getRenderIndices(sceneManager.currentScene);
  for (int index : renderIndices) {
    if (index < doorways.length) {
      doorways[index].render();
    }
  }
}

void renderText() {
  int[] textIndices = getTextIndices(sceneManager.currentScene);
  for (int index : textIndices) {
    if (index < dialogueboxes.length) {
      dialogueboxes[index].update();
      dialogueboxes[index].display();
    }
  }
}

boolean isMouseInsideObjectBool() {
  int[] checkDoorIndices = getCheckIndices(sceneManager.currentScene);
  int[] checkTextIndices = getTextIndices(sceneManager.currentScene);
  for (int indexDoor : checkDoorIndices) {
    for (int indexText : checkTextIndices) {
      if ((indexDoor < doorways.length && doorways[indexDoor].isMouseInsideObject(mouseX, mouseY))
        || (sceneManager.currentScene == Scene.WINDOW_ROOM && mySafe.isMouseInsideObject(mouseX, mouseY))
        //|| (!collectibles[0].collected && sceneManager.currentScene == Scene.WINDOW_ROOM && collectibles[0].isMouseInsideObject(mouseX, mouseY)) //cage
        || (!collectibles[1].collected && sceneManager.currentScene == Scene.WINDOW_ROOM && collectibles[1].isMouseInsideObject(mouseX, mouseY)) //ticket
        || (!collectibles[3].collected && sceneManager.currentScene == Scene.HALLWAY && collectibles[3].isMouseInsideObject(mouseX, mouseY)) //umbrella
        || (!collectibles[4].collected && sceneManager.currentScene == Scene.BATHROOM && collectibles[4].isMouseInsideObject(mouseX, mouseY)) //key
        || (!collectibles[5].collected && sceneManager.currentScene == Scene.KITCHEN && collectibles[5].isMouseInsideObject(mouseX, mouseY)) //catnip
        || (indexText < dialogueboxes.length && dialogueboxes[indexText].isMouseInsideObject(mouseX, mouseY))) {
        return true;
      } else if (collectibles[5].collected) {
        return ((!collectibles[6].collected && sceneManager.currentScene == Scene.DOOR_ROOM && collectibles[6].isMouseInsideObject(mouseX, mouseY)) || //cat
          (!collectibles[0].collected && sceneManager.currentScene == Scene.WINDOW_ROOM && collectibles[0].isMouseInsideObject(mouseX, mouseY))); //cage
      }
    }
  }
  return false;
}

void mouseReleased() {
  mySafe.mousePressedSafe(mouseX, mouseY);
}

void mouseClicked() {
  Scene targetScene = null;

  if (sceneManager.currentScene == Scene.START) {
    targetScene = Scene.INTRO;
  } else if (mySafe.isMouseInsideObject(mouseX, mouseY) && sceneManager.currentScene == Scene.WINDOW_ROOM) {
    targetScene = Scene.SAFE;
  } else {
    int[] checkIndices = getCheckIndices(sceneManager.currentScene);
    for (int index : checkIndices) {
      if (doorways[index].isMouseInsideObject(mouseX, mouseY) && index!=8) {
        targetScene = getTargetScene(index);
        break;
      }
    }
  }

  if (targetScene != null) {
    sceneManager.switchScene(targetScene);
  }

  if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    if (collectibles[0].isMouseInsideObject(mouseX, mouseY) && !collectibles[0].collected) {
      if (collectibles[6].interacted && slots[0].containedObject == null) {
        collectibles[0].collect();
        slots[0].containedObject = collectibles[0]; // Assign to cageSlot
      }
    } else if (collectibles[1].isMouseInsideObject(mouseX, mouseY) && !collectibles[1].collected) {
      collectibles[1].collect();
      slots[1].containedObject = collectibles[1]; // Assign to ticketsSlot
      if (!ticket.isPlaying()) {
        ticket.play();
      }
    }
  }


  if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    if (collectibles[5].collected) {
      collectibles[6].interact();
      if (collectibles[6].interacted && collectibles[6].isMouseInsideObject(mouseX, mouseY)) {
        collectibles[6].setSprite("catSprite.png", "catSleepingSprite.png", 200);
        slots[0].containedObject = null;
        catIsSleeping = true;
      }
    }
    if (catIsSleeping == true && collectibles[0].collected && collectibles[6].isMouseInsideObject(mouseX, mouseY)) {
      collectibles[6].collect();
      slots[0].containedObject = collectibles[7];
      cat.play();
    }
  }

  if (sceneManager.currentScene == Scene.HALLWAY) {
    if (collectibles[3].isMouseInsideObject(mouseX, mouseY) && !collectibles[3].collected) {
      collectibles[3].collect();
      slots[3].containedObject = collectibles[3]; // Assign to umbrellaSlot
      if (!ticket.isPlaying()) {
        ticket.play();
      }
    }
  }

  if (sceneManager.currentScene == Scene.BATHROOM) {
    if (collectibles[4].isMouseInsideObject(mouseX, mouseY) && !collectibles[4].collected) {
      collectibles[4].collect();
      slots[4].containedObject = collectibles[4]; // Assign to keySlot
      if (!octopussy.isPlaying()) {
        octopussy.play();
      }
    }
  }

  if (sceneManager.currentScene == Scene.KITCHEN) {
    if (collectibles[5].isMouseInsideObject(mouseX, mouseY) && !collectibles[5].collected) {
      collectibles[5].collect();
      slots[0].containedObject = collectibles[5]; // Assign to catnipSlot
      if (!ticket.isPlaying()) {
        ticket.play();
      }
    }
  }


  if (sceneManager.currentScene == Scene.DOOR_ROOM && doorways[8].isMouseInsideObject(mouseX, mouseY)) {
    if (slots[0].containedObject == collectibles[7] &&
      slots[1].containedObject == collectibles[1] &&
      slots[2].containedObject == collectibles[2] &&
      slots[3].containedObject == collectibles[3] &&
      slots[4].containedObject == collectibles[4]) {
      sceneManager.currentScene = Scene.END;
    }
  }
  //boolean safeClicked = false;
  if (sceneManager.currentScene == Scene.GAME_OVER) {
    exit();
  }




  if (sceneManager.currentScene == Scene.WINDOW_ROOM) {
    dialogueboxes[0].mouseClicked(); //tv
    dialogueboxes[1].mouseClicked(); //poster
  }
  if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    dialogueboxes[2].mouseClicked(); //plant
    dialogueboxes[3].mouseClicked(); //main door
  }
  if (sceneManager.currentScene == Scene.KITCHEN) {
    dialogueboxes[4].mouseClicked(); //washing machine
    dialogueboxes[5].mouseClicked(); //mouse in the pot
  }
  if (sceneManager.currentScene == Scene.BATHROOM) {
    dialogueboxes[6].mouseClicked(); //bathroom monster
    dialogueboxes[7].mouseClicked(); //drying money
  }
  if (sceneManager.currentScene == Scene.DOOR_ROOM) {
    if (slots[4].containedObject != collectibles[4]) {
      dialogueboxes[14].mouseClicked(); //locked window
    } else if (slots[0].containedObject != collectibles[7]) {
      dialogueboxes[9].mouseClicked(); //no cat
    } else if (slots[1].containedObject != collectibles[1]) {
      dialogueboxes[10].mouseClicked(); //no tickets
    } else if (slots[3].containedObject != collectibles[3]) {
      dialogueboxes[11].mouseClicked(); // no umbrella
    } else if (slots[2].containedObject != collectibles[2]) {
      dialogueboxes[8].mouseClicked(); // no money
    }

    if (slots[0].containedObject != collectibles[5]) {
      dialogueboxes[12].mouseClicked();
    }
    if (slots[0].containedObject != collectibles[0] & catIsSleeping == true) {
      dialogueboxes[13].mouseClicked();
    }
    if (slots[0].containedObject == collectibles[7]) {
      //dialogueboxes[13].;
    }
  }
  //if (sceneManager.currentScene == Scene.INTRO) {
  //  targetScene = Scene.WINDOW_ROOM;
  //}
  //if (sceneManager.currentScene == Scene.BOOK_1) {
  //  targetScene = Scene.WINDOW_ROOM;
  //}
  //if (sceneManager.currentScene == Scene.BOOK_2) {
  //  targetScene = Scene.WINDOW_ROOM;
  //}
  //if (sceneManager.currentScene == Scene.BOOK_3) {
  //  targetScene = Scene.WINDOW_ROOM;
  //}
  //if (sceneManager.currentScene == Scene.BOOK_4) {
  //  targetScene = Scene.BATHROOM;
  //}


  if (targetScene != null) {
    sceneManager.switchScene(targetScene);
  }

  println(mouseX + " + " + mouseY);
}

int[] getRenderIndices(Scene currentScene) {
  switch (currentScene) {
  case WINDOW_ROOM:
    return new int[]{0};
  case DOOR_ROOM:
    return new int[]{1, 2, 8, 10};
  case HALLWAY:
    return new int[]{3, 4, 5, 11};
  case KITCHEN:
    return new int[]{6, 12};
  case BATHROOM:
    return new int[]{7, 9};
  case SAFE:
    return new int[]{1};
  case BOOK_1:
    return new int[]{13};
  case BOOK_2:
    return new int[]{14};
  case BOOK_3:
    return new int[]{15};
  case BOOK_4:
    return new int[]{16};
  default:
    return new int[]{};
  }
}


int[] getCheckIndices(Scene currentScene) {
  switch (currentScene) {
  case WINDOW_ROOM:
    return new int[]{0};
  case DOOR_ROOM:
    return new int[]{1, 2, 8, 10};
  case HALLWAY:
    return new int[]{3, 4, 5, 11};
  case KITCHEN:
    return new int[]{6, 12};
  case BATHROOM:
    return new int[]{7, 9};
  case SAFE:
    return new int[]{1};
  case BOOK_1:
    return new int[]{13};
  case BOOK_2:
    return new int[]{14};
  case BOOK_3:
    return new int[]{15};
  case BOOK_4:
    return new int[]{16};
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
    return Scene.END;
  case 9:
    return Scene.BOOK_2;
  case 10:
    return Scene.BOOK_3;
  case 11:
    return Scene.BOOK_4;
  case 12:
    return Scene.BOOK_1;
  case 13:
    return Scene.KITCHEN;
  case 14:
    return Scene.BATHROOM;
  case 15:
    return Scene.DOOR_ROOM;
  case 16:
    return Scene.HALLWAY;
  case 17:
    return Scene.SAFE;
  case 18:
    return Scene.GAME_OVER;
  default:
    return null;
  }
}

int[] getTextIndices(Scene currentScene) {
  switch (currentScene) {
  case WINDOW_ROOM:
    return new int[]{0, 1};
  case DOOR_ROOM:
    return new int[]{2, 3, 8, 9, 10, 11, 12, 13, 14};
  case HALLWAY:
    return new int[]{};
  case KITCHEN:
    return new int[]{4, 5};
  case BATHROOM:
    return new int[]{6, 7};
  case SAFE:
    return new int[]{};
  default:
    return new int[]{};
  }
}

// Define functions for each scene
void startScene() {
  // Code for the start scene
  fill(0);
  textSize(150);
  textAlign(CENTER, CENTER);
  text("Click to start", width / 2, height / 2);
}

void livingRoomWindowScene() {
  // Code for the living room with the window scene
  if (!music.isPlaying()) {
    music.play();
  }
  PImage livingRoom = loadImage("livingRoomWindowFin.jpg");
  livingRoom.resize(1920, 1080);
  image(livingRoom, 0, 0);
  mySafe.render();
  collectibles[0].render();
  collectibles[1].render();
}

void livingRoomDoorScene() {
  // Code for the bedroom scene
  if (!music.isPlaying()) {
    music.play();
  }
  image(loadImage("livingRoomDoorFin.jpg"), 0, 0);
  collectibles[6].render();
}

void hallwayScene() {
  if (!music.isPlaying()) {
    music.play();
  }
  image(loadImage("hallwayRoomFin.jpg"), 0, 0);
  collectibles[3].render();
}

void kitchenScene() {
  // Code for the kitchen scene
  if (!music.isPlaying()) {
    music.play();
  }
  image(loadImage("kitchenRoomFin.jpg"), 0, 0);
  collectibles[5].render();
}

void bathroomScene() {
  if (!music.isPlaying()) {
    music.play();
  }
  image(loadImage("bathRoomFin.jpg"), 0, 0);
  collectibles[4].render();
}





void book1() {
  image(loadImage("bookblue.jpg"), 0, 0);
}
void book2() {
  image(loadImage("bookgreen.jpg"), 0, 0);
}
void book3() {
  image(loadImage("bookred.jpg"), 0, 0);
}
void book4() {
  image(loadImage("bookyellow.jpg"), 0, 0);
}







void safeScene() {
  push();
  imageMode(CENTER);
  PImage safe = loadImage("closedSafe.jpg");
  image(safe, width / 2, height / 2);
  if (mySafe.isSafeOpen()) {
    // Check if money hasn't been collected yet
    if (!collectibles[2].collected) {
      // Collect the money
      collectibles[2].collect();
      // Assign the money to the money slot
      slots[2].containedObject = collectibles[2];
    }
  }
  pop();
}

void gameOverScene() {
  // Code for the game over scene
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(150);
  text("Game Over. Click to restart", width / 2, height / 2);
  if (!rwg4.isPlaying()) {
        rwg4.play();
      }
}
int introStartTime;
int endStartTime;
int introDelay = 2000; // set the delay in milliseconds
int endDelay = 2000;

void intro() {
  if (!imusic.isPlaying()) {
    imusic.play();
  }
  if (introStartTime == 0) {
    introStartTime = millis(); // start the timer
  }

  // Calculate elapsed time
  int elapsedMillis = millis() - introStartTime;

  // Display different images based on elapsed time
  if (elapsedMillis < introDelay) {
    image(loadImage("introCS1.jpg"), 0, 0);
  } else if (elapsedMillis < 2 * introDelay) {
    image(loadImage("introCS2.jpg"), 0, 0);
    if (!rwg1.isPlaying()) {
      rwg1.play();
    }
  } else if (elapsedMillis < 3 * introDelay) {
    image(loadImage("introCS3.jpg"), 0, 0);
  } else if (elapsedMillis < 4 * introDelay) {
    image(loadImage("introCS4.jpg"), 0, 0);
    if (!ding.isPlaying()) {
      ding.play();
    }
  } else if (elapsedMillis < 5 * introDelay) {
    image(loadImage("introCS5.jpg"), 0, 0);
    if (!rwg3.isPlaying()) {
      rwg3.play();
    }
  } else if (elapsedMillis < 6 * introDelay) {
    image(loadImage("introCS6.jpg"), 0, 0);
  } else if (elapsedMillis < 7 * introDelay) {
    image(loadImage("introCS7.jpg"), 0, 0);
    if (!grr.isPlaying()) {
      grr.play();
    }
  } else if (elapsedMillis < 8 * introDelay) {
    image(loadImage("introCS8.jpg"), 0, 0);
    if (!rwg4.isPlaying()) {
      rwg4.play();
    }
  } else if (elapsedMillis < 9 * introDelay) {
    image(loadImage("introCS9.jpg"), 0, 0);
    if (!rwg3.isPlaying()) {
      rwg3.play();
    }
  } else if (elapsedMillis < 10 * introDelay) {
    Scene targetScene = getTargetScene(1);
    sceneManager.switchScene(targetScene);
    timer = 15;
    seconds = 0;
    minutes = 3;
    totaltimer = ((minutes * 60 + seconds) * 60 + timer);
    startTime = millis();
    imusic.stop();
  }
}

void end() {
  if (endStartTime == 0) {
    endStartTime = millis(); // start the timer
  }
  music.stop();
  if (!imusic.isPlaying()) {
    imusic.play();
  }
  // Calculate elapsed time
  int elapsedMillis = millis() - endStartTime;

  // Display different images based on elapsed time
  if (elapsedMillis < endDelay) {
    image(loadImage("endingCS1.jpg"), 0, 0);
  } else {
    image(loadImage("endingCS2.jpg"), 0, 0);
    timer = 99999999;
    seconds = 0;
    minutes = 9999999;
  }
}
