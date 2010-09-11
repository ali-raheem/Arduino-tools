#include <LiquidCrystal.h>

//LCD Screen properties
#define rows 2
#define cols 16

//LED
#define led_pin 6

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup()
{
  pinMode(led_pin, OUTPUT);
  lcd.begin(rows, cols);
  lcd.print("  Light Sensor  ");
  char output = printf("[%-14s]","XXX");
  lcd.print(output);}

void loop()
{
  int led_input = analogRead(led_pin);
  int led_output = map(led_input, 0, 1023, 0, cols-2);

}
