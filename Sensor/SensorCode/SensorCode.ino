#include <Ultrasonic.h>

#include "Ultrasonic.h"

int pinoTrigger = 12;
int pinoEcho = 13;
HC_SR04 sensor(pinoTrigger, pinoEcho);

void setup() {
// put your setup code here, to run once:
Serial.begin(9600);
}

void loop() {
// put your main code here, to run repeatedly:
float distancia = sensor.distance();

if(distancia > 0 && distancia < 10){
Serial.println(1);
} else{
Serial.println(0);
}
delay(1000);
}