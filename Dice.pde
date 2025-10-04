int numTotal = 0;
int numDots1 = 0, numDots2 = 0, numDots3 = 0, numDots4 = 0, numDots5 = 0, numDots6 = 0;
int diceCount = 0;

void setup()
{
  size(1200, 1000);
  noLoop();
}

void draw()
{
  numTotal = 0;
  numDots1 = 0; 
  numDots2 = 0;
  numDots3 = 0; 
  numDots4 = 0; 
  numDots5 = 0; 
  numDots6 = 0;
  diceCount = 0;
  
  background(240, 240, 255);
  
  int diceSize = 12;
  int spacing = 2;
  int cols = (width - 20) / (diceSize + spacing);
  int rows = (height - 300) / (diceSize + spacing);
  
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      Die die = new Die(10 + i * (diceSize + spacing), 280 + j * (diceSize + spacing));
      die.show();
      die.roll();
      diceCount++;
    }
  }
  
  drawBarGraph();
  
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(28);
  text("Dice Roll Total: " + numTotal + " (from " + diceCount + " dice)", width/2, 30);
  
  textSize(16);
  text("Average: " + String.format("%.2f", diceCount > 0 ? (float)numTotal/diceCount : 0), width/2, 55);
  
  textSize(14);
  text("1s: " + numDots1, width/2 - 150, 250);
  text("2s: " + numDots2, width/2 - 90, 250);
  text("3s: " + numDots3, width/2 - 30, 250);
  text("4s: " + numDots4, width/2 + 30, 250);
  text("5s: " + numDots5, width/2 + 90, 250);
  text("6s: " + numDots6, width/2 + 150, 250);
  
  textSize(12);
  fill(100);
  text("Click to roll once | Hold SPACEBAR for continuous rolling", width/2, 270);
}

void drawBarGraph()
{
  int graphWidth = 600;
  int graphHeight = 80;
  int graphX = (width - graphWidth) / 2;
  int graphY = 120;
  int barWidth = graphWidth / 6;
  
  int maxCount = max(numDots1, max(numDots2, max(numDots3, max(numDots4, max(numDots5, numDots6)))));
  
  int[] counts = {numDots1, numDots2, numDots3, numDots4, numDots5, numDots6};
  color[] colors = {color(255, 100, 100), color(100, 255, 100), color(100, 100, 255), 
                   color(255, 255, 100), color(255, 100, 255), color(100, 255, 255)};
  
  for(int i = 0; i < 6; i++) {
    fill(colors[i]);
    int barHeight = maxCount > 0 ? (int)((float)counts[i] / maxCount * graphHeight) : 0;
    rect(graphX + i * barWidth, graphY + graphHeight - barHeight, barWidth - 2, barHeight);
    
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(str(i + 1), graphX + i * barWidth + barWidth/2, graphY + graphHeight + 15);
  }
  
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(14);
  text("Dice Distribution", width/2, graphY - 25);
}

void mousePressed()
{
  redraw();
}

void keyPressed()
{
  if (key == ' ') {
    if (looping) {
      noLoop();
    } else {
      loop();
    }
  }
}

class Die
{
  int myX, myY, numDots;
  
  Die(int x, int y)
  {
    myX = x;
    myY = y;
    numDots = (int)(Math.random() * 6) + 1;
    numTotal += numDots;
  }
  
  void roll()
  {
    fill(255, 0, 0);
    noStroke();
    
    int centerX = myX + 6;
    int centerY = myY + 6;
    int dotSize = 2;
    
    if (numDots == 1) {
      ellipse(centerX, centerY, dotSize, dotSize);
    }
    else if (numDots == 2) {
      ellipse(myX + 3, myY + 3, dotSize, dotSize);
      ellipse(myX + 9, myY + 9, dotSize, dotSize);
    }
    else if (numDots == 3) {
      ellipse(myX + 3, myY + 3, dotSize, dotSize);
      ellipse(centerX, centerY, dotSize, dotSize);
      ellipse(myX + 9, myY + 9, dotSize, dotSize);
    }
    else if (numDots == 4) {
      ellipse(myX + 3, myY + 3, dotSize, dotSize);
      ellipse(myX + 9, myY + 3, dotSize, dotSize);
      ellipse(myX + 3, myY + 9, dotSize, dotSize);
      ellipse(myX + 9, myY + 9, dotSize, dotSize);
    }
    else if (numDots == 5) {
      ellipse(myX + 3, myY + 3, dotSize, dotSize);
      ellipse(myX + 9, myY + 3, dotSize, dotSize);
      ellipse(centerX, centerY, dotSize, dotSize);
      ellipse(myX + 3, myY + 9, dotSize, dotSize);
      ellipse(myX + 9, myY + 9, dotSize, dotSize);
    }
    else if (numDots == 6) {
      ellipse(myX + 3, myY + 3, dotSize, dotSize);
      ellipse(myX + 9, myY + 3, dotSize, dotSize);
      ellipse(myX + 3, myY + 6, dotSize, dotSize);
      ellipse(myX + 9, myY + 6, dotSize, dotSize);
      ellipse(myX + 3, myY + 9, dotSize, dotSize);
      ellipse(myX + 9, myY + 9, dotSize, dotSize);
    }
  }
  
  void show()
  {
    fill(255);
    stroke(0);
    strokeWeight(1);
    rect(myX, myY, 12, 12, 1);
    
    switch(numDots) {
      case 1: numDots1++; break;
      case 2: numDots2++; break;
      case 3: numDots3++; break;
      case 4: numDots4++; break;
      case 5: numDots5++; break;
      case 6: numDots6++; break;
    }
  }
}
