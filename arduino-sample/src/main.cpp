#include <Arduino.h>
#include <constants.h>


void setup()
{
  pinMode(ARDUINO_LED_PIN,OUTPUT) ; 	//Set pin 2 as output
}

void loop()
{
  analogWrite(ARDUINO_LED_PIN,ARDUINO_ON_LED_POWER) ; 		 //setting pwm to 25 
  delay(1000) ; // delay 1s
	analogWrite(ARDUINO_LED_PIN,ARDUINO_OFF_LED_POWER); 		
}