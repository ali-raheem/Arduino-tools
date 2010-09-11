#include <LiquidCrystal.h>
#define rows 2
#define cols 16

#include "WProgram.h"
void setup();
void loop();
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup()
{
  lcd.begin(rows, cols);
    lcd.print(printf("%s","lol"));
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

