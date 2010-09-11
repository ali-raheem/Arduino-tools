#include <LiquidCrystal.h>
#include <string.h>

#include "WProgram.h"
void setup();
void loop();
const int rows = 2;
const int cols = 16;
int x,y;

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup()
{
  lcd.begin(rows, cols);
    lcd.print("HAI!!!");
 }

void loop()
{

}


int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

