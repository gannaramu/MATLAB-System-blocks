#include <Arduino.h>
#include <Dht.h>

DHT dht;

extern "C" void setDHT(uint8_t pin, uint8_t type) {
    dht.begin(pin, type);
}

extern "C" float readTemp() {
    return dht.readTemperature();
}

extern "C" float readTempF() {
    return dht.readTemperature(true);
}

extern "C" float readHumidity() {
    return dht.readHumidity();
}

