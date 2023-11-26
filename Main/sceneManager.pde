import java.util.HashMap;

// Enum for different scenes
enum Scene {
  START, WINDOW_ROOM, DOOR_ROOM, HALLWAY, KITCHEN, BATHROOM, GAME_OVER
}

// SceneManager class
class SceneManager {
  HashMap<Scene, Runnable> scenes;

  Scene currentScene;

  SceneManager() {
    scenes = new HashMap<Scene, Runnable>();
    currentScene = Scene.START;  // Set the initial scene
  }

  // Add scenes to the manager
  void addScene(Scene scene, Runnable sceneFunction) {
    scenes.put(scene, sceneFunction);
  }

  // Switch to a new scene
  void switchScene(Scene newScene) {
    currentScene = newScene;
  }

  // Update and draw the current scene
  void update() {
    if (scenes.containsKey(currentScene)) {
      scenes.get(currentScene).run();
    } else {
      println("Scene not found: " + currentScene);
    }
  }
}
