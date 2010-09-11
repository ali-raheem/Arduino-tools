#include "WProgram.h"
void setup();
void loop();
void setup()
{
  pinMode(13,OUTPUT);
}
void loop()
{
  digitalWrite(13,HIGH);
  delay(100);
  digitalWrite(13,LOW);
  delay(100);
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

