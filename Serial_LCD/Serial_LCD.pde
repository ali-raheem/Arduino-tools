#include <LiquidCrystal.h>
#include <string.h>

const int rows = 2;
const int cols = 16;
int x,y;

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup()
{
  lcd.begin(rows, cols);
 }

void loop()
{
  output("LOL");
}

void output(string msg)
{
  int i=0;
  while(i<strlen(msg)){
    c=msg[i++];
    if(x==cols){
      x=0;
      y++; 
    }
    if(y==rows){
      x=0;
      y=0;
    }
    lcd.setCursor(x++,y);
    lcd.print(c),BYTE);
  }
}
