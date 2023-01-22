#include <Constants.h>
#include <Types.h>

class CommandsRegister {

private :

static DeviceCommand* commandsQueue[MAX_COMMANDS_SIZE];
static CommandHandler commandHandler;

public :

void registerCommand(DeviceCommand* command){
    for ( int i = 0 ; i < MAX_COMMANDS_SIZE ; i++){
        if(commandsQueue[i] == nullptr){
            commandsQueue[i] = command;
            break;
        }
    }
}

void registerCommandHandler(CommandHandler handler){
    commandHandler = handler;
}


void handleCommands(int* maxHandledCommands){
    int handeledCount = 0 ;
    int currIndex = 0 ;
    
    DeviceCommand* command;

    while((currIndex < MAX_COMMANDS_SIZE) && (handeledCount < *maxHandledCommands)){
        command = commandsQueue[currIndex];
        
        if(command!= nullptr){
            commandHandler(command);
            handeledCount++;
        }
        currIndex++;
    }
}

};