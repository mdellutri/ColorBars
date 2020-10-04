HScrollbar hs1, hs2, hs3;  // Two scrollbars
PImage img1, img2;  // Two images to load

void setup() {
  size(271, 300);
  noStroke();
  hs1 = new HScrollbar(0, height-40, width, 16, 16, color(255,0,0));
  hs2 = new HScrollbar(0, height-24, width, 16, 16, color(0,255,0));
  hs3 = new HScrollbar(0, height-8, width, 16, 16, color(0,0,255));
  
  // Load images
}

void draw() {
  background(255);
 
 
  hs1.update();
  hs2.update();
  hs3.update();
  hs1.display();
  hs2.display();
  hs3.display();
  fill(hs1.spos, 0, 0);
  rect(0, 0, width, height*.5);
  fill(0, hs2.spos, 0);
  rect(0, height*.3, width*.7, height*.5);
  fill(0, 0, hs3.spos);
  rect(width*.3, height*.3, width*.7, height*.5);
  fill(hs1.spos, hs2.spos, 0);
  rect(0,height*.25, width*.5, height*.2);
  fill(hs1.spos, 0, hs3.spos);
  rect(width*.5,height*.25, width*.5, height*.2);
  fill(0, hs2.spos, hs3.spos);
  rect(width*.29,height*.45, width*.4, height*.35);
  fill(hs1.spos, hs2.spos, hs3.spos);
  rect(width*.29,height*.25, width*.4, height*.2);
  println(hs1.spos);
  println(hs2.spos);
  println(hs3.spos);
  stroke(0);
  line(0, height-32, width, height-32);
  line(0, height-16, width, height-16);
}


class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  color scolor;

  HScrollbar (float xp, float yp, int sw, int sh, int l, color c) {
    scolor = c;
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(lerpColor(255, scolor, 0.75));
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(scolor);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
  
}
