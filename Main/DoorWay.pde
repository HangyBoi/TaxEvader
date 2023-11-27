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
    strokeWeight(5);
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(xpos, ypos, rwidth, rheight);
  }

  boolean isMouseInsideDoor(float mouseX, float mouseY) {
    return ((mouseX >= xpos - rwidth / 2) && (mouseX <= xpos + rwidth / 2) && (mouseY >= ypos - rheight / 2) && (mouseY <= ypos + rheight / 2));
  }
}
