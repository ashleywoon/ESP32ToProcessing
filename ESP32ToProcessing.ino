/*
 * ESP32 To Processing
 * by Ashley Woon
 * 
 * Designed for ESP32 and hardware connections to a push button, LED, and potentiometer
 */

//LED pin
int blueLED = 15;

//button pin and variables
int button = 12;
int buttonState;
int lastButtonState;
int pushCount = 0;

//potentiometer pin
int pot = A2;
int potValue = 0;

void setup() {
  //initializing inputs, and output
  pinMode(blueLED, OUTPUT);
  pinMode(button, INPUT);
  pinMode(pot, INPUT);

  Serial.begin(9600);
}

void loop() {
  potValue = analogRead(pot);
  buttonState = digitalRead(button);
  
  if(buttonState != lastButtonState)
  {
    if(buttonState == HIGH)
    {
      pushCount++;
      digitalWrite(blueLED, HIGH);
    }
    else if(pushCount == 2)
    {
       pushCount = 0;
       digitalWrite(blueLED,LOW);
    }
  }
  lastButtonState = buttonState;

  Serial.println(pushCount);
}
