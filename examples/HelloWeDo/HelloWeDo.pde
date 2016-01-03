/**
 * HelloWeDo
 * An example using Lego WeDo in Processing.
 * by Tero Avellan
 */

WeDo wedo;
float angle = 0.5;
float radius = 125;
float speed = 0.5;

void setup() {
  size(500,500);
  wedo = new WeDo(this);
}

void draw() {
  background(color(255));
  fill(color(225,0,0));
  if (mousePressed && (dist(width/2, height/2, mouseX, mouseY)<125)) { 
       fill(color(0,255,60));
       if(wedo.getDirection(false) == "BACKWARD") { 
         speed = -0.5;
         wedo.setMotor(true,-50); 
       }
       else { 
         speed = 0.5;
         wedo.setMotor(true,50); 
       }
  } else {
    speed = 0;
    wedo.reset();
  }
  ellipse(width/2,height/2,250,250);
  
  float pallo_x = width/2 + cos(radians(angle))*(radius);
  float pallo_y = height/2 + sin(radians(angle))*(radius);
  
  if (angle<360) {
    angle = angle + speed;
  } else {
    angle = 0;
  }
  
  fill(0);
  strokeWeight(10);
  line(width/2,height/2,pallo_x, pallo_y);
  strokeWeight(3);
  ellipse(pallo_x, pallo_y, 30, 30);
  println(wedo.getTilt(false));
  strokeWeight(6);
  line(10,height-50,10+cos(radians(90-wedo.getTilt(false)))*50, (height-50)+sin(radians(270-wedo.getTilt(false)))*50);
  fill(255);
  rectMode(CENTER);
  rect(10+cos(radians(90-wedo.getTilt(false)))*50, (height-50)+sin(radians(270-wedo.getTilt(false)))*50, 30, 30);
}