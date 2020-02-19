#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif
    void MW_LCD_Init(); //unsigned int rs, unsigned int en, unsigned int d0, unsigned int d1, unsigned int d2, unsigned int d3);
    
    //Print a message to the LCD screen
    void MW_Print_LCD(char s[],char up[]);
    
    
#ifdef __cplusplus
}
#endif