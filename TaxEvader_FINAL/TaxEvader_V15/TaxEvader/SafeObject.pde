class SafeObject extends InteractObject {

  PImage closedSafe, openSafeMoney, openSafeEmpty;

  ArrayList<Numpad> buttons = new ArrayList<Numpad>();

  //ArrayList<Block> blocks;

  SafeObject(float xpos, float ypos, int rwidth, int rheight) {
    super(xpos, ypos, rwidth, rheight);

    safeIsOpen = false;

    closedSafe = loadImage("closedSafe.jpg");
    closedSafe.resize(int(rwidth), int(rheight));
    openSafeMoney = loadImage("safeOpen.jpg");

    buttons = new ArrayList<Numpad>();

    for (int j = 3; -1 < j; j--) {
      for (int i = 3; 0 < i; i--) {
        Numpad button = new Numpad( (i * 37) + width / 7 + 25, (36.5*j) + height / 3 - 30, str(i + 3 * j) );
        buttons.add(button);
      }
    }
  }

  //void render() {
  //  super.render();
  //}

  void update() {
    if (!safeIsOpen) {
      push();
      scale(2);
      for (Numpad button : buttons) {
        button.update();
      }
      pop();
      String codeAsString = arrayListToString(code);
      fill(255, 200, 0);
      push();
      textAlign(CENTER, CENTER);
      textSize(80);
      //text("Code: ", width/2, 80);
      
      rotate(- PI / 50);
      text(codeAsString, width/2 - 250, height / 2 + 35);
      pop();
    } else {
      image(openSafeMoney, 0, 0);
    }
  }
  
  boolean isSafeOpen() {
    return safeIsOpen;
  }

  void checkingCode() {
    // Check conditions to open the safe
    if (!safeIsOpen && code.size() == 4) {
      String codeAsString = arrayListToString(code);
      if (codeAsString.equals("7403")) {
        unlock.play();
        safeIsOpen = true;
        
      }
      if (codeAsString.equals("1983")) {
        if (!easter.isPlaying()) {
          easter.play();
          music.stop();
        }
        code.clear();
      } else {
        code.clear();
      }
    }
  }

  void mousePressedSafe(float mouseX, float mouseY) {
    // Handle mouse press inside the safe
    for (Numpad button : buttons) {
      float scaledMouseX = mouseX / 2 + 10;
      float scaledMouseY = mouseY / 2 + 10;
      //println("sl;dkfds" + blocks.size());
      button.checkMouse(scaledMouseX, scaledMouseY);
    }
  }

  String arrayListToString(ArrayList<Integer> list) {
    StringBuilder result = new StringBuilder();
    for (Integer value : list) {
      result.append(value);
    }
    return result.toString();
  }
}
