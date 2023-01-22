
struct DeviceCommand
{
    int deviceType;
    int deviceId;
    bool turnOn;
};

typedef void (*CommandHandler)(DeviceCommand*); 
