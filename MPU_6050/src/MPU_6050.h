#include "rtwtypes.h"

#ifdef __cplusplus
extern "C" {
#endif

void MPU_setup();
void MPU_update();
float get_accx_data();
float get_accy_data();
float get_accz_data();

float get_gyroX_data();
float get_gyroY_data();
float get_gyroZ_data();

float get_acc_angle_x_data();
float get_acc_angle_y_data();

float get_gyro_angle_X_data();
float get_gyro_angle_Y_data();
float get_gyro_angle_Z_data();

float get_angle_X_data();
float get_angle_Y_data();
float get_angle_Z_data();

float get_temp_data();

#ifdef __cplusplus
}
#endif

