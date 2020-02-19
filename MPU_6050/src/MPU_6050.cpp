#include <Arduino.h>
#include "MPU_6050.h" 
#include "MPU6050_tockn.cpp" 
#include "MPU6050_tockn.h" 
#include <Wire.cpp>
#include <Wire.h>
#include <twi.h>
#include <twi.c>

MPU6050 mpu6050(Wire);

extern "C" void MPU_setup()
{
    Wire.begin();
    mpu6050.begin(); 

    mpu6050.calcGyroOffsets(true);

}
extern "C" void MPU_update()
{
  mpu6050.begin(); 
  mpu6050.update();

}

// Write a logic value to pin 


// Temp
extern "C" float get_temp_data() 
{ 
  return mpu6050.getTemp();
}
//
extern "C" float get_accx_data() 
{ 
  return mpu6050.getAccX();
}
extern "C" float get_accy_data() 
{ 
  return mpu6050.getAccY();
}
extern "C" float get_accz_data() 
{ 
  return mpu6050.getAccZ();
}

// gyro 
extern "C" float get_gyroX_data() 
{ 
  return mpu6050.getGyroX();
}
extern "C" float get_gyroY_data() 
{ 
  return mpu6050.getGyroY();
}
extern "C" float get_gyroZ_data() 
{ 
  return mpu6050.getGyroZ();
}

// Acceleration Angle

extern "C" float get_acc_angle_x_data() 
{ 
  return mpu6050.getAccAngleX();
}
extern "C" float get_acc_angle_y_data() 
{ 
  return mpu6050.getAccAngleY();
}

// Gyro Angle

extern "C" float get_gyro_angle_X_data() 
{ 
  return mpu6050.getGyroAngleX();
}
extern "C" float get_gyro_angle_Y_data() 
{ 
  return mpu6050.getGyroAngleY();
}
extern "C" float get_gyro_angle_Z_data() 
{ 
  return mpu6050.getGyroAngleZ();
}

// Angles
extern "C" float get_angle_X_data() 
{ 
  return mpu6050.getAngleX();
}
extern "C" float get_angle_Y_data() 
{ 
  return mpu6050.getAngleY();
}
extern "C" float get_angle_Z_data() 
{ 
  return mpu6050.getAngleZ();
}
