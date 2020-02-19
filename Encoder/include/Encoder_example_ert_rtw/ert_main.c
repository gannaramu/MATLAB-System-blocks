#include "Encoder_example.h"
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

  Encoder_example_step();

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
  rtmSetErrorStatus(Encoder_example_M, 0);

  /* initialize external mode */
  rtParseArgsForExtMode(0, NULL);
  Encoder_example_initialize();
  sei();

  /* External mode */
  rtSetTFinalForExtMode(&rtmGetTFinal(Encoder_example_M));
  rtExtModeCheckInit(1);

  {
    boolean_T rtmStopReq = false;
    rtExtModeWaitForStartPkt(Encoder_example_M->extModeInfo, 1, &rtmStopReq);
    if (rtmStopReq) {
      rtmSetStopRequested(Encoder_example_M, true);
    }
  }

  rtERTExtModeStartMsg();
  cli();
  configureArduinoAVRTimer();
  runModel =
    (rtmGetErrorStatus(Encoder_example_M) == (NULL)) && !rtmGetStopRequested
    (Encoder_example_M);

#ifndef _MW_ARDUINO_LOOP_

  sei();

#endif;

  sei();
  while (runModel) {
    /* External mode */
    {
      boolean_T rtmStopReq = false;
      rtExtModeOneStep(Encoder_example_M->extModeInfo, 1, &rtmStopReq);
      if (rtmStopReq) {
        rtmSetStopRequested(Encoder_example_M, true);
      }
    }

    stopRequested = !(
                      (rtmGetErrorStatus(Encoder_example_M) == (NULL)) &&
                      !rtmGetStopRequested(Encoder_example_M));
    runModel = !(stopRequested);
    MW_Arduino_Loop();
  }

  /* Disable rt_OneStep() here */

  /* Terminate model */
  Encoder_example_terminate();
  rtExtModeShutdown(1);
  cli();
  return 0;
}
