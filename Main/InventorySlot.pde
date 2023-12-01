class InventorySlot {

  float xpos, ypos;
  CollectableObject containedObject;

  InventorySlot (float xpos, float ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }

  void appear() {
    if (containedObject != null) {
      push();
      imageMode(CENTER);
      if (sceneManager.currentScene != Scene.END){
      image(containedObject.sprite, xpos, ypos);
      }
      pop();
    }
  }
}
