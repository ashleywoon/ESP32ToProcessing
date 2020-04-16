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
int minBallSpeed = 0;
int maxBallSpeed = 50;
int xPos, yPos;
float h = 10;
float w = 10;

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
 //background changes color based on button input)
  if(switchValue == 1)
    background(0);
  else
    background(200, 0, 255); 
}
void drawObjects() 
{
  fill(255,0,0);
  ellipse(xPos, yPos, 10,10);
  fill(0,0,255);
  ellipse(xPos/2, yPos/2, h, w);
  float speed = map(potValue, minPotValue, maxPotValue, minBallSpeed, maxBallSpeed);
  println(speed);
  if(switchValue == 1)
  {
    xPos+=1;
    yPos+=5;
  }
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
