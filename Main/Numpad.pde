class Numpad {
  float x, y;
  String n;
  color colour;
  Numpad (float xPos, float yPos, String numb) {
    x = xPos;
    y = yPos;
    n = numb;
    colour = color(255);
  }

  void update() {
    if (n.equals("11")) {
      n = "0";
    }
    if (n.equals("10")) {
      n = "*";
    }
    if (n.equals("12")) {
      n = "#";
    }
    if (code.size() < 1) {
      changeColour(2);
    }
    if (safeIsOpen == false) {
      push();
      fill(colour);
      strokeWeight(3);
      stroke(0);
      textSize(24);
      rectMode(CENTER);
      textAlign(CENTER, CENTER);
      rect(x, y, 28, 28);
      fill(0);
      text(n, x, y);
      rectMode(CORNER);
      pop();
    }
  }

  void checkMouse(float mx, float my) {
    float rectWidth = 30; // Width of the rectangle
    float rectHeight = 30; // Height of the rectangle

    // Check if the mouse coordinates are within the bounds of the rectangle
    if (sceneManager.currentScene == Scene.SAFE) {
      if (mx > x && mx < x + rectWidth && my > y && my < y + rectHeight) {
        int value = (int(n) - '0') + 48;
        code.add(value);
        beep.play();
        changeColour(1);
      }
    }
  }

  void changeColour(int col) {
    // Change the color of the block when it is clicked
    if (col == 1) {
      colour = color(255, 0, 0); // Change to red color, for example
    }
    if (col == 2) {
      colour = color(255); // Change to red color, for example
    }
  }
}
