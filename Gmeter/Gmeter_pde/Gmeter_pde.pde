#include <LiquidCrystal.h>
const int x=0;//x-axisADC
const int t=2;//TempADC
const float g=0.00322;//ADCmax/3.3v
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  pinMode(x,INPUT);
  lcd.begin(16, 2);
  Serial.begin(9600);
}

void loop() {
  int v=(g*analogRead(x)-0.5/0.8);
  Serial.println(analogRead(x));
  lcd.print("G-meter: ");
  lcd.print(v);
  lcd.setCursor(0,1);
  lcd.print("Temp: ");
  int T=(g*analogRead(t)-0.424)/0.0625;
  lcd.print(T);
  lcd.print("C");
  lcd.setCursor(0,0);
}

