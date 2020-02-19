/*
 * Encoder_example.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Encoder_example".
 *
 * Model version              : 1.17
 * Simulink Coder version : 9.2 (R2019b) 18-Jul-2019
 * C source code generated on : Mon Dec 23 22:19:29 2019
 *
 * Target selection: ert.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Encoder_example.h"
#include "Encoder_example_private.h"
#include "Encoder_example_dt.h"

/* Block states (default storage) */
DW_Encoder_example_T Encoder_example_DW;

/* Real-time model */
RT_MODEL_Encoder_example_T Encoder_example_M_;
RT_MODEL_Encoder_example_T *const Encoder_example_M = &Encoder_example_M_;

/* Forward declaration for local functions */
static void matlabCodegenHandle_matlabCodeg(Encoder_Sim_Encoder_example_T *obj);
static void matlabCodegenHandle_matlabCodeg(Encoder_Sim_Encoder_example_T *obj)
{
  if (!obj->matlabCodegenIsDeleted) {
    obj->matlabCodegenIsDeleted = true;
  }
}

/* Model step function */
void Encoder_example_step(void)
{
  /* MATLABSystem: '<Root>/MATLAB System' */
  Encoder_init(0.0);

  /* External mode */
  rtExtModeUploadCheckTrigger(1);

  {                                    /* Sample time: [0.001s, 0.0s] */
    rtExtModeUpload(0, (real_T)Encoder_example_M->Timing.taskTime0);
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.001s, 0.0s] */
    if ((rtmGetTFinal(Encoder_example_M)!=-1) &&
        !((rtmGetTFinal(Encoder_example_M)-Encoder_example_M->Timing.taskTime0) >
          Encoder_example_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(Encoder_example_M, "Simulation finished");
    }

    if (rtmGetStopRequested(Encoder_example_M)) {
      rtmSetErrorStatus(Encoder_example_M, "Simulation finished");
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
  if (!(++Encoder_example_M->Timing.clockTick0)) {
    ++Encoder_example_M->Timing.clockTickH0;
  }

  Encoder_example_M->Timing.taskTime0 = Encoder_example_M->Timing.clockTick0 *
    Encoder_example_M->Timing.stepSize0 + Encoder_example_M->Timing.clockTickH0 *
    Encoder_example_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void Encoder_example_initialize(void)
{
  /* Registration code */

  /* initialize real-time model */
  (void) memset((void *)Encoder_example_M, 0,
                sizeof(RT_MODEL_Encoder_example_T));
  rtmSetTFinal(Encoder_example_M, 20.0);
  Encoder_example_M->Timing.stepSize0 = 0.001;

  /* External mode info */
  Encoder_example_M->Sizes.checksums[0] = (4147538964U);
  Encoder_example_M->Sizes.checksums[1] = (227671653U);
  Encoder_example_M->Sizes.checksums[2] = (2865393692U);
  Encoder_example_M->Sizes.checksums[3] = (1057482424U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    Encoder_example_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(Encoder_example_M->extModeInfo,
      &Encoder_example_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(Encoder_example_M->extModeInfo,
                        Encoder_example_M->Sizes.checksums);
    rteiSetTPtr(Encoder_example_M->extModeInfo, rtmGetTPtr(Encoder_example_M));
  }

  /* states (dwork) */
  (void) memset((void *)&Encoder_example_DW, 0,
                sizeof(DW_Encoder_example_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    Encoder_example_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 15;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;
  }

  /* Start for MATLABSystem: '<Root>/MATLAB System' */
  Encoder_example_DW.obj.matlabCodegenIsDeleted = false;
  Encoder_example_DW.objisempty = true;
  Encoder_example_DW.obj.isInitialized = 1L;
  Encoder_init(0.0, 5.0, 6.0);
  Encoder_example_DW.obj.isSetupComplete = true;
}

/* Model terminate function */
void Encoder_example_terminate(void)
{
  /* Terminate for MATLABSystem: '<Root>/MATLAB System' */
  matlabCodegenHandle_matlabCodeg(&Encoder_example_DW.obj);
}
