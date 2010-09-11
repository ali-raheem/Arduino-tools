#include <LiquidCrystal.h>
const int x=0;
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  pinMode(x,INPUT);
  lcd.begin(16, 2);
  lcd.print("   -=Gmeter=-   ");
}

void loop() {
  int v=map(analogRead(x),0,1023,1,16);
  int i=0;
  if(v<8){
    while(i<v){
      lcd.print(" ");
      i++;
    }
    while(i<8){
      lcd.print("#");
      i++;  
    }
    lcd.print("        ");
  }else if(v>8){
    i=8;
    lcd.print("        ");    
    while(i<v){
      lcd.print("#");
      i++;
    }
    while(i<8){
      lcd.print(" ");
      i++;
    }
  }
  delay(100);
  lcd.setCursor(0,1);
  lcd.print("                ");
  lcd.setCursor(0,1);
}

