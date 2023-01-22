#include <Arduino.h>
#include <Constants.h>
#include <MqttServer.cpp>
#include <CommandsRegister.cpp>
#include <Types.h>


CommandsRegister commandsRegister;
int max_handeled_commands_per_loop;

void setupOutputPins(){
  pinMode(ARDUINO_LED_PIN,OUTPUT) ; 	//Set pin 2 as output
}

void dummyCommandHandler(DeviceCommand* command){
  analogWrite(ARDUINO_LED_PIN,ARDUINO_ON_LED_POWER) ; 		 //setting pwm to 25 
  delay(1000) ; // delay 1s
	analogWrite(ARDUINO_LED_PIN,ARDUINO_OFF_LED_POWER); 		
}


void setup()
{
  setupOutputPins();
  connectToMqttBroker();
  max_handeled_commands_per_loop = MAX_HANDLED_COMMANDS_PER_LOOP;
  commandsRegister.registerCommandHandler(dummyCommandHandler);
}

void loop()
{
  commandsRegister.handleCommands(&max_handeled_commands_per_loop);
}
