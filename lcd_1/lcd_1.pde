#include <LiquidCrystal.h>
#define rows 2
#define cols 16

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup()
{
  pinMode(led_pin, OUTPUT);
  lcd.begin(rows, cols);
}
void loop()
{
}
