#ifndef _ENCODER_ARDUINO_H
#define _ENCODER_ARDUINO_H
#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif

void Encoder_init(int enc, int pinA, int pinB);
int Encoder_step(int enc);

#ifdef __cplusplus
}
#endif
#endif //_ENCODER_ARDUINO_H

