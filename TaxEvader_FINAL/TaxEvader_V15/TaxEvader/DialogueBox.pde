class DialogueBox extends InteractObject {
  int messanger;
  String message;
  float x, y, owidth, oheight, iwidth, iheight;
  boolean displayText = false;
  boolean mouseIsHovering = false;
  boolean ready = false;
  float currentY; // Added to keep track of the vertical position for the text
  boolean dialogueActive = false;

  DialogueBox(float xpos, float ypos, float rwidth, float rheight, int messanger) {
    super(xpos, ypos, rwidth, rheight);
    this.messanger = messanger;
    x = width/2;
    y = height/2;
    owidth = 1000;
    oheight = 1000;
    iwidth = width;
    iheight = height/2;
    currentY = this.y + 390; // Initialize currentY to the starting y position for text
  }

  void display() {
    int maxWidth = 500; // Maximum width for the text
    int lineHeight = 50; // Line height for the text

    // Draw the dialogue box background
    if (displayText == true) {
      dialogueActive = true;
      //PImage img = (loadImage("text.png"));
      //image(img, 0, height/2);
      PImage img = (loadImage("textbox.png"));
      image(img, 50, 693, 850, 450);

      if (messanger == 1) {
        message = "I should buy a new one...";
        if (!rwg2.isPlaying()) {
          rwg2.play();
        }
      }
      if (messanger == 2) {
        message = "They never get my nose right...";
        if (!rwg2.isPlaying()) {
          rwg2.play();
        }
      }
      if (messanger == 3) {
        if (!plant.isPlaying()) {
          plant.play();
          //noLoop();
        }
        message = "I hope he eats enough when I'm gone...";
      }
      if (messanger == 4) {
        message = "I should get out of here before the IRS breaks my door open...";
        if (!rwg4.isPlaying()) {
          rwg4.play();
        }
      }
      if (messanger == 5) {
        message = "That money isn't done laundering yet, I should leave it...";
        if (!rwg2.isPlaying()) {
          rwg2.play();
        }
      }
      if (messanger == 6) {
        message = "I wonder if this is a Pixar reference...";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }
      if (messanger == 7) {
        message = "Sorry Stephen but i have to get out of here...";
        if (!stephen.isPlaying()) {
          stephen.play();
        }
      }
      if (messanger == 8) {
        message = "I shouldn't take these, they are not done drying";
        if (!rwg2.isPlaying()) {
          rwg2.play();
        }
      }
      if (messanger == 9) {
        message = "I can't leave without money";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }
      if (messanger == 10) {
        message = "I can't leave without cat!";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }
      if (messanger == 11) {
        message = "I can't leave without my Plane tickets...";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }
      if (messanger == 12) {
        message = "I'm quite high up.. i need something to break my fall!";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }
      if (messanger == 13) {
        message = "I should make him asleep somehow..";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }
      if (messanger == 14) {
        message = "I can't just take him like that...";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }
      if (messanger == 15) {
        message = "It's locked..";
        if (!rwg3.isPlaying()) {
          rwg3.play();
        }
      }





      String[] words = message.split(" ");
      StringBuilder lineBuilder = new StringBuilder();
      //float startY = this.y + 390; // Initial y position for the text
      float startY = this.y + 340; // Initial y position for the text

      for (String word : words) {
        // Check the width of the line with the new word
        if (textWidth(lineBuilder.toString() + " " + word) <= maxWidth) {
          // If it fits, add the word to the line
          lineBuilder.append(word).append(" ");
        } else {
          // If it doesn't fit, display the current line and start a new one
          push();
          //fill(255);
          fill(0);
          textSize(50);
          textAlign(LEFT);
          //rotate(radians(-3.5));
          //text(lineBuilder.toString(), this.x - 700, startY);
          //startY += lineHeight; // Update startY for the next line
          //lineBuilder = new StringBuilder(word + " ");
          text(lineBuilder.toString(), this.x - 625, startY);
          startY += lineHeight; // Update startY for the next line
          lineBuilder = new StringBuilder(word + " ");
          pop();
        }
      }

      // Display the last line
      //push();
      //fill(255);
      //textSize(50);
      //textAlign(LEFT);
      push();
      //fill(255);
      fill(0);
      textSize(50);
      textAlign(LEFT);
      text(lineBuilder.toString(), this.x - 625, startY);
      pop();
    } else {
      super.render();
    }
  }


  void update() {
    // Check if the mouse is inside the dialogue box
    mouseIsHovering = (mouseX > x && mouseX < x + owidth &&
      mouseY > y && mouseY < y + oheight);

    // If the mouse is hovering and clicked, do something (e.g., set displayText to false)
    if (mousePressed) {
      displayText = false;
      rwg2.stop();
      rwg3.stop();
      rwg4.stop();
    }
  }

  void mouseClicked() {
    if (this.isMouseInsideObject(mouseX, mouseY) == true) {
      displayText = true;
      currentY = this.y + 390; // Reset currentY when displaying text
    }
  }

  public void mouseMoved() {
    if (mouseX >= x && mouseX <= x + iwidth &&
      mouseY >= y && mouseY <= y + iheight) {
      mouseIsHovering = true;
    }
  }
}
