/*
Sega Megadrive (genisis) controller interface.
_____________
\D0|D1| D3|+/
 \D4|S|-|D5/
pin out. 
*/
const int sel_pin = 13;
int data_pins[] = {2,3,4,5,6,7};
char buttons[] = {'U', 'D', 'L','R','B','C','A','S','Z','Y','X','M'};
int buttons_state[] = {1,1,1,1,1,1,1,1,1,1,1,1};
void setup(){
  for(int data_pin=0;data_pin<6;data_pin++)
    pinMode(data_pins[data_pin], INPUT);
  pinMode(sel_pin, OUTPUT);
  Serial.begin(4800);
  Serial.println("Sega MegaDrive controller interface");
}
void loop(){
  delay(1); //This cleans up the output from the D pad
  digitalWrite(sel_pin, HIGH);//U,D,L,R,B,C
  for(int data_pin=0;data_pin<6;data_pin++){
    int state=digitalRead(data_pins[data_pin]);
    int old_state=buttons_state[data_pin];
    char button=buttons[data_pin];
    if(old_state>state){
      Serial.print(button);
      Serial.println(" pressed.");
    }else if (old_state<state){
      Serial.print(button);
      Serial.println(" released.");      
    }
    buttons_state[data_pin]=state;
  }
  digitalWrite(sel_pin, LOW);//A,START
  for(int data_pin=4;data_pin<6;data_pin++){
    int state=digitalRead(data_pins[data_pin]);
    int old_state=buttons_state[data_pin+2];
    char button=buttons[data_pin+2];
    if(old_state>state){
      Serial.print(button);
      Serial.println(" pressed.");
    }else if (old_state<state){
      Serial.print(button);
      Serial.println(" released.");      
    }
    buttons_state[data_pin+2]=state;
  }
//  digitalWrite(sel_pin, HIGH);
//  delay(1);
//  digitalWrite(sel_pin, LOW);
//  delay(1);
//  digitalWrite(sel_pin, HIGH);
//  delay(1);
//  digitalWrite(sel_pin, LOW);
//  delay(1);
//  digitalWrite(sel_pin, HIGH);
//  delay(1);
//  digitalWrite(sel_pin, LOW);
//  delay(1);
//  digitalWrite(sel_pin, HIGH);  
//  for(int data_pin=0;data_pin<4;data_pin++){
//    int state=digitalRead(data_pins[data_pin]);
//    int old_state=buttons_state[data_pin+6];
//    char button=buttons[data_pin+6];
//    if(old_state>state){
//      Serial.print(button);
//      Serial.println(" pressed.");
//    }else if (old_state<state){
//      Serial.print(button);
//      Serial.println(" released.");      
//    }
//    buttons_state[data_pin+6]=state;
//  }
}
