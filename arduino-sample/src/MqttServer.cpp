#include <ArduinoMqttClient.h>
#include <WiFiNINA.h>
#include <Secrets.h>
#include <MQTTConstants.h>
#include <Constants.h>

WiFiClient wifiClient;

MqttClient mqttClient(wifiClient);

boolean connectToMqttBroker()
{
    int wifiRetires = MAX_WIFI_RETRIES;

    connectToWifi(&wifiRetires);

    boolean connectedToBroker = mqttClient.connect(MQTT_BROKER, MQTT_PORT);

    if (!connectedToBroker)
    {
        Serial.print("Couldn't connect to MQTT broker, retrying in 5 seconds");
        delay(5000);
        return false;
    }

    mqttClient.onMessage(onMessageReceived);
    mqttClient.subscribe(MQTT_COMMANDS_TOPIC);

    return true;
}

void connectToWifi(int *maxRetries)
{

    if (WiFi.status() == WL_CONNECTED)
    {
        return;
    }

    int retriesCount = 0;

    Serial.print("Connecting to WiFi");

    WiFi.begin(WIFI_SSID, WIFI_PASS);
    boolean wifiConnected;

    isConnectedToWifi(&wifiConnected);

    while ((!wifiConnected) && (retriesCount < *maxRetries))
    {

        Serial.print("Couldn't connect to WiFi, retrying in 5 seconds");

        WiFi.begin(WIFI_SSID, WIFI_PASS);
        isConnectedToWifi(&wifiConnected);
        retriesCount++;
        delay(5000);
    }
}

void isConnectedToWifi(boolean *isConnected)
{
    *isConnected = WiFi.status() == WL_CONNECTED;
}

void onMessageReceived(int messageSize)
{
    Serial.println("Received a message with topic '");

    Serial.print(mqttClient.messageTopic());

    Serial.print("', length ");

    Serial.print(messageSize);

    Serial.println(" bytes:");

    while (mqttClient.available())
    {
        Serial.print((char)mqttClient.read());
    }

    Serial.println();

    Serial.println();
}