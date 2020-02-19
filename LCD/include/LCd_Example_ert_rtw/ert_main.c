#include "LCd_Example.h"
#include "rtwtypes.h"
#include <ext_svr.h>
#include <ext_share.h>
#include <updown.h>

volatile int IsrOverrun = 0;
static boolean_T OverrunFlag = 0;
void rt_OneStep(void)
{
  /* Check for overrun. Protect OverrunFlag against preemption */
  if (OverrunFlag++) {
    IsrOverrun = 1;
    OverrunFlag--;
    return;
  }

#ifndef _MW_ARDUINO_LOOP_

  sei();

#endif;

  LCd_Example_step();

  /* Get model outputs here */
#ifndef _MW_ARDUINO_LOOP_

  cli();

#endif;

  OverrunFlag--;
  rtExtModeCheckEndTrigger();
}

volatile boolean_T stopRequested = false;
volatile boolean_T runModel = false;
int main(void)
{
  float modelBaseRate = 0.001;
  float systemClock = 0;

  /* Initialize variables */
  stopRequested = false;
  runModel = false;
  init();
  MW_Arduino_Init();
  rtmSetErrorStatus(LCd_Example_M, 0);

  /* initialize external mode */
  rtParseArgsForExtMode(0, NULL);
  LCd_Example_initialize();
  sei();

  /* External mode */
  rtSetTFinalForExtMode(&rtmGetTFinal(LCd_Example_M));
  rtExtModeCheckInit(1);

  {
    boolean_T rtmStopReq = false;
    rtExtModeWaitForStartPkt(LCd_Example_M->extModeInfo, 1, &rtmStopReq);
    if (rtmStopReq) {
      rtmSetStopRequested(LCd_Example_M, true);
    }
  }

  rtERTExtModeStartMsg();
  cli();
  configureArduinoAVRTimer();
  runModel =
    (rtmGetErrorStatus(LCd_Example_M) == (NULL)) && !rtmGetStopRequested
    (LCd_Example_M);

#ifndef _MW_ARDUINO_LOOP_

  sei();

#endif;

  sei();
  while (runModel) {
    /* External mode */
    {
      boolean_T rtmStopReq = false;
      rtExtModeOneStep(LCd_Example_M->extModeInfo, 1, &rtmStopReq);
      if (rtmStopReq) {
        rtmSetStopRequested(LCd_Example_M, true);
      }
    }

    stopRequested = !(
                      (rtmGetErrorStatus(LCd_Example_M) == (NULL)) &&
                      !rtmGetStopRequested(LCd_Example_M));
    runModel = !(stopRequested);
    MW_Arduino_Loop();
  }

  /* Disable rt_OneStep() here */

  /* Terminate model */
  LCd_Example_terminate();
  rtExtModeShutdown(1);
  cli();
  return 0;
}
