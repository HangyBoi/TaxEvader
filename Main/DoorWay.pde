// A class to represent the doorway zone which allows moving between the scenes.

class DoorWay {

  float xpos, ypos, rwidth, rheight;

  DoorWay(float xpos, float ypos, float rwidth, float rheight) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.rwidth = rwidth;
    this.rheight = rheight;
  }
  
  void render() {
    noFill();
    rectMode(CENTER);
    rect(xpos, ypos, rwidth, rheight);
  }
  
  void changeColor() {
  }

  boolean isMouseInsideDoor(float mouseX, float mouseY, float rectX, float rectY, float rectWidth, float rectHeight) {
    return ((mouseX >= rectX - rectWidth / 2) && (mouseX <= rectX + rectWidth / 2) && (mouseY >= rectY - rectHeight / 2) && (mouseY <= rectY + rectHeight / 2));
  }
}
