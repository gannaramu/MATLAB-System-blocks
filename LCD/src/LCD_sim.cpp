#include <Arduino.h>
#include "rtwtypes.h"
#include "LCD_sim.h"
#include <Wire.cpp>
#include <Wire.h>
#include <twi.h>
#include <twi.c>
#include "LiquidCrystal_I2C.h"

LiquidCrystal_I2C *lcd ; //(0x27, 16, 2);

extern "C" void MW_LCD_Init(){
//     lcd = new LiquidCrystal(50,3,4,51,5,48);
    lcd = new LiquidCrystal_I2C(0x27, 16, 2);
//     unsigned int cols = 16;
//     unsigned int rows = 2;
    lcd->begin();
    lcd->print("Welcome");
}

extern "C" void MW_Print_LCD(char up[],char s[]){
    
//     unsigned int d4 = 100;
    lcd->clear();
    unsigned int cols = 0;
    unsigned int rows = 0;
    lcd->setCursor(cols,rows);
    lcd->print(up);
    rows = rows + 1;
    lcd->setCursor(cols,rows);
    lcd->print(s);
}
