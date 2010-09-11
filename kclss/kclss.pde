/*
*Name: Operation Game
*Date: Sat 5 June 2010
*Desc: Arduino 168 code for 
*      operation style game.
*
*/

#define BUZZ 9 //Buzzer PWM pin
#define MISS 8 //tweezer
#define START 7 //start stop button
#define PEN 10 //second penality for a miss
#define MINTIME 20

#include <LiquidCrystal.h>
#include <stdlib.h>

int misses;
long time;
long offset;

long hiscores[3]={350,400,450};

int notes[] = {10,20,30,40,50,100};
char intro[] = {'A', 'A','F','A','F','A','E','F','B','A','B','D'};
char win[] = {'A', 'A','A','E','E','E','D','D','D'};

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  lcd.begin(16, 2);
  lcd.clear();
  if(digitalRead(START))
    command();
  lcd.print("KCL Surgical Soc");
  lcd.setCursor(0,1);
  lcd.print(" Operation Game");
  pinMode(10,OUTPUT);
  pinMode(BUZZ,OUTPUT);
//  play(intro);
}

void loop() {
  if(millis()%1000<50)
    digitalWrite(10,HIGH);
  if(millis()%2000<50)
    digitalWrite(10,LOW);
  if(digitalRead(START))
    game();
}

void play(char score[])
{
  for( int note=0; note<sizeof(intro)/sizeof(char); note++){
    int index = score[note]-'A';
    analogWrite(BUZZ, notes[index]);
    delay(1000);
    analogWrite(BUZZ, 0);
    delay(100);
  } 
}

void game()
{
  lcd.clear();
  lcd.print(" New game in...");
  for(int i=3;i>0;i--){
    lcd.setCursor(7,1);
    lcd.print(i);
    delay(1000);
  }
  buzz();
  lcd.clear();
  
  misses=0;
  offset=millis();
  time=0;
  while (1){
    if(digitalRead(START))
      finished();
    time=(millis()-offset)/1000;
    time+= misses*PEN;
    lcd.setCursor(0,0);
    lcd.print(misses);
    lcd.setCursor(8,0);
    lcd.print(" misses.");
    lcd.setCursor(0,1);
    lcd.print("Time:   ");
    displayTime(time);
    if(digitalRead(MISS)){
      misses+=1;
      buzz();
    }
  }
}

void buzz()
{
  analogWrite(BUZZ,127);
  delay(1000);
  analogWrite(BUZZ,0);
}
void finished()
{
  lcd.clear();
  lcd.print("   GAME OVER!   ");
  delay(1000);
  lcd.clear();
  lcd.print("Final Time: ");
  displayTime(time);
  lcd.setCursor(0,1);
  lcd.print("With ");
  lcd.print(misses);
  lcd.print(" misses!");
  buzz();
  delay(5000);
  hiscore();
}

void displayTime(long time)
{
    lcd.print((time-(time%60))/60);
    lcd.print(":");
    if(time%60<10)
      lcd.print("0");
    lcd.print(time%60);
}

void hiscore()
{
  lcd.clear();
  int best=0;
  //AIDSful new hiscore code.  
  long buffer,buffer1;
  for(int i=0;i<sizeof(hiscores)/sizeof(long);i++){
    if((hiscores[i]>time) && !best){
      buffer=hiscores[i];
      hiscores[i]=time;
      best=1;
    }else if (best){
      buffer1=hiscores[i];
      hiscores[i]=buffer;
      buffer=buffer1;
    }
  }
  if( best && (time>MINTIME) ){
    lcd.print(" NEW HIGHSCORE! ");
  }else if(time<=MINTIME){
    lcd.print(" Time invalid!");
  }else{
    lcd.print("   Highscore    ");
  }
  //Scrolling higscore code aka teh AIDS
  lcd.setCursor(0,1);
  lcd.print("1:");
  lcd.setCursor(6,1);
  displayTime(hiscores[0]);
  delay(1000);
  for (int i=0; i<sizeof(hiscores)/sizeof(long); i++){
    lcd.clear();
    lcd.print(i+1);
    lcd.print(":");
    lcd.setCursor(6,0);
    displayTime(hiscores[i]);
      if(i+1<sizeof(hiscores)/sizeof(long)){
      lcd.setCursor(0,1);
      lcd.print(i+2);
      lcd.print(":");
      lcd.setCursor(6,1);
      displayTime(hiscores[i+1]);
    }
    delay(1000);
    lcd.clear();
  }
  delay(3000);
  while(1){
    if(START)
      game();
  }
}

void command()
{
  lcd.print("START held down.");
  lcd.setCursor(0,1);
  lcd.print("In command mode!");
  Serial.begin(9600);
  Serial.println("KCL Surgical Society");
  Serial.println("Operation Game v0.1");
  Serial.println("h for help.");
  Serial.print(">");
  while(1){
    if(Serial.available()){
      char cmd=Serial.read();
      Serial.println(cmd);
      Serial.print(">");
      switch (cmd){
        case 'h':
          help();
          break;
        case 'i':
          command();
          break;
        case 'q':
            hiscore();
            break;
        case 'd':
            Serial.println("Sat 5 June 2010");
            Serial.print("Highscore - ");
           // Serial.println(best);
            break;
        case 'l':
            load();
            break;
        default:
          Serial.println(">");
      }
    }
  }
}
void help()
{
  Serial.println("Options:");
  Serial.println("h - This help list.");
  Serial.println("i - Restart the Serial connection.");
  Serial.println("q - Quit to game mode.");
  Serial.println("d - Output data.");
  Serial.println("l - Pre-load a highscore. l <time>s");
  Serial.print(">");
}
void load()
{
          char string[10];
          char letter;
          int i=0;
          Serial.read();
            while (letter!='s'){
              letter = Serial.read();
              if(letter>='0' && letter <='9'){
                string[i++]=letter;
              }
            }
            Serial.print("Setting highscore to: ");
      //      best=atoi(string);
     //       time=best+1;
            Serial.print(string);
}
