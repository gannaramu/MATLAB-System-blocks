/*
 * LCd_Example.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "LCd_Example".
 *
 * Model version              : 1.24
 * Simulink Coder version : 9.2 (R2019b) 18-Jul-2019
 * C source code generated on : Tue Jan  7 16:24:31 2020
 *
 * Target selection: ert.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "LCd_Example.h"
#include "LCd_Example_private.h"
#include "LCd_Example_dt.h"

/* Block states (default storage) */
DW_LCd_Example_T LCd_Example_DW;

/* Real-time model */
RT_MODEL_LCd_Example_T LCd_Example_M_;
RT_MODEL_LCd_Example_T *const LCd_Example_M = &LCd_Example_M_;

/* Model step function */
void LCd_Example_step(void)
{
  /* External mode */
  rtExtModeUploadCheckTrigger(1);

  {                                    /* Sample time: [0.001s, 0.0s] */
    rtExtModeUpload(0, (real_T)LCd_Example_M->Timing.taskTime0);
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.001s, 0.0s] */
    if ((rtmGetTFinal(LCd_Example_M)!=-1) &&
        !((rtmGetTFinal(LCd_Example_M)-LCd_Example_M->Timing.taskTime0) >
          LCd_Example_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(LCd_Example_M, "Simulation finished");
    }

    if (rtmGetStopRequested(LCd_Example_M)) {
      rtmSetErrorStatus(LCd_Example_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++LCd_Example_M->Timing.clockTick0)) {
    ++LCd_Example_M->Timing.clockTickH0;
  }

  LCd_Example_M->Timing.taskTime0 = LCd_Example_M->Timing.clockTick0 *
    LCd_Example_M->Timing.stepSize0 + LCd_Example_M->Timing.clockTickH0 *
    LCd_Example_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void LCd_Example_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)LCd_Example_M, 0,
                sizeof(RT_MODEL_LCd_Example_T));
  rtmSetTFinal(LCd_Example_M, 20.0);
  LCd_Example_M->Timing.stepSize0 = 0.001;

  /* External mode info */
  LCd_Example_M->Sizes.checksums[0] = (2131096259U);
  LCd_Example_M->Sizes.checksums[1] = (3233341189U);
  LCd_Example_M->Sizes.checksums[2] = (2495589591U);
  LCd_Example_M->Sizes.checksums[3] = (2856235896U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    LCd_Example_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(LCd_Example_M->extModeInfo,
      &LCd_Example_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(LCd_Example_M->extModeInfo,
                        LCd_Example_M->Sizes.checksums);
    rteiSetTPtr(LCd_Example_M->extModeInfo, rtmGetTPtr(LCd_Example_M));
  }

  /* states (dwork) */
  (void) memset((void *)&LCd_Example_DW, 0,
                sizeof(DW_LCd_Example_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    LCd_Example_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 15;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Start for MATLABSystem: '<Root>/MATLAB System' */
  LCd_Example_DW.objisempty = true;
  LCd_Example_DW.obj.isInitialized = 1L;
  MW_LCD_Init();
}

/* Model terminate function */
void LCd_Example_terminate(void)
{
  /* (no terminate code required) */
}
