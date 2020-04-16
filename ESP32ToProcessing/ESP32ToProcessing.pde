/*
ESP32 To Processing
by Ashley Woon
*/

// Importing the serial library to communicate with the Arduino 
import processing.serial.*;    

// Initializing a vairable named 'myPort' for serial communication
Serial myPort;      

// Data coming in from the data fields
String [] data;
int switchValue = 0;    // index from data fields
int potValue = 1;

// Change to appropriate index in the serial list — YOURS MIGHT BE DIFFERENT
int serialIndex = 0;

// animated ball
int minPotValue = 0;
int maxPotValue = 4095; 

int xPos, yPos;
float h = 10;
float w = 10;
int lastSwitchValue;

void setup() 
{
  size(800, 600);
  printArray(Serial.list());
  myPort = new Serial (this, Serial.list()[serialIndex], 9600);
  xPos = 50;
  yPos = 50;
}

// We call this to get the data 
void checkSerial() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readString();  
    
    print(inBuffer);
    
    // This removes the end-of-line from the string AND casts it to an integer
    inBuffer = (trim(inBuffer));
    
    data = split(inBuffer, ',');
 
    // do an error check here?
    switchValue = int(data[0]);
    potValue = int(data[0]);
  }
} 

void draw() 
{
  checkSerial();
  drawBackground();
  drawObjects();
  drawTexts();
 
}

void drawBackground()
{
  float speed = map(potValue, minPotValue, maxPotValue, 0, 255);
 //background changes color based on potentiometer input
  if(speed <= 1365)
    background(255,0,0);
  else if(speed > 1365 && speed <=2730)
    background(0,255,0);
  else if(speed > 2730 && speed <= 4095)
    background(0,0,255);
  
}
void drawObjects() 
{
  fill(255,255,0);
  ellipse(xPos, yPos, w,h);
  fill(0,255,255);
  ellipse(xPos/2, yPos/2, h, w);
  
  //animating balls and changing size
  if(switchValue != lastSwitchValue)
  {
    if(switchValue == 1)
    {
      h+=1;
      w+=1;
      if(yPos < 600)
      {
        xPos+=5;
        yPos+=5;
      }
      else
      {
        xPos-=5;
        yPos-=1;
      }
    }
  }
  lastSwitchValue = switchValue;
}

void drawTexts() 
{
  if(switchValue == 0)
  {
    fill(0);
    textSize(30);
    text("Hello", width/2, height/2);
  }
  else
  {
    fill(0,0,100);
    textSize(60);
    text("I'm working on it", width/8, height/3);
  }
}
