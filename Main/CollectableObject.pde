class CollectableObject extends InteractObject {

  PImage sprite;
  boolean collected, interacted;
  int resizingValue;

  CollectableObject(float xpos, float ypos, float rwidth, float rheight) {
    super(xpos, ypos, rwidth, rheight);
    this.interacted = false;
    this.collected = false;
  }

  CollectableObject(float xpos, float ypos, float rwidth, float rheight, String spritePath, String newSpritePath, int resizing) {
    this(xpos, ypos, rwidth, rheight);
    this.resizingValue = resizing;
    setSprite(spritePath, newSpritePath, resizing);
  }

  void render() {
    if (!collected) {
      super.render();
    }
  }

  void display() {
    if (!collected) {
      push();
      imageMode(CENTER);
      //sprite.resize(180, 180);
      image(sprite, xpos, ypos);
      pop();
    }
  }

  void collect() {
    collected = true;
  }

  void interact() {
    interacted = true;
  }
  

  void setSprite(String spritePath, String newSpritePath, int resizing) {
    if (!interacted) {
      this.sprite = loadImage(spritePath);
      this.sprite.resize(resizing, resizing);
    } else if (interacted) {
      this.sprite = loadImage(newSpritePath);
    }
  }
}
