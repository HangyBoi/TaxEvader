// A superclass of all interactable Objects in the game

class InteractObject {

  float xpos, ypos, rwidth, rheight;

  InteractObject(float xpos, float ypos, float rwidth, float rheight) {
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
    //rect(xpos, ypos, rwidth, rheight);
  }

  boolean isMouseInsideObject(float mouseX, float mouseY) {
    return ((mouseX >= xpos - rwidth / 2) && (mouseX <= xpos + rwidth / 2) && (mouseY >= ypos - rheight / 2) && (mouseY <= ypos + rheight / 2));
  }
}
