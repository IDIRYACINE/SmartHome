
struct DeviceCommand
{
    int deviceType;
    int deviceId;
    bool turnOn;
};

typedef unsigned int size_t;
typedef void (*CommandHandler)(DeviceCommand*); 
