#include <LiquidCrystal.h>

//LCD Screen properties
#define rows 2
#define cols 16

//LED
#define led_pin 0

#include "WProgram.h"
void setup();
void loop();
void barGraph();
void stats();
void about();
int led_input;
int led_output;
int led_max=0;
int led_min=1024;

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup()
{
  pinMode(led_pin, OUTPUT);
  lcd.begin(cols, rows);
  lcd.print("-=Light Sensor=-");
}

void loop()
{
  led_input = analogRead(led_pin);
  if( led_input > led_max )
    led_max = led_input;
  if( led_input < led_min )
    led_min = led_input; 
  led_output = map(led_input, led_min, led_max, 0, cols-2);
  lcd.setCursor(0,1);
  int time = millis()/1000;
  
  if( time%27 < 3){
     stats();
  //}else if(time%13 < 7){
    about();
  }else{
    barGraph();
  }
  lcd.print("         ");
}

void barGraph()
{
  lcd.print('[', BYTE);
  int i=0;
  while( i<led_output){
    lcd.print('X', BYTE);
    i++;
  }
  while( i < cols-2 ){
    lcd.print(' ', BYTE);
    i++;
  }
  lcd.print(']', BYTE);
}

void stats()
{
  lcd.print("MAX: ");
  lcd.print(led_max);
  lcd.print(" MIN: ");
  lcd.print(led_min);
}

void about()
{
  lcd.print("By Ali Raheem");
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

