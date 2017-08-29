#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {
  Tensor idOne = id(2,3);
  Tensor idOneTrace = [[ 3 ]];
  float idOneTraceF = 3;

  Tensor idTwo = id(2,10);
  Tensor idTwoTrace = [[ 10 ]];
  float idTwoTraceF = 10;

  int *dataTest;
  dataTest = malloc(sizeof(int)*2);
  dataTest[0] = 5;
  dataTest[1] = 5;

  Tensor testThree = fill(2,dataTest,666);
  Tensor testThreeTrace = [[ 3330 ]];
  float testThreeTraceF = 3330;

  if (ten_trace(idOne) != idOneTrace) {
    return 1;
  }
  if (trace(idOne) != idOneTraceF) {
    return 1;
  }

  if (ten_trace(idTwo) != idTwoTrace) {
    return 1;
  }
  if (trace(idTwo) != idTwoTraceF) {
    return 1;
  }

  if (ten_trace(testThree) != testThreeTrace) {
    return 1;
  }
  if (trace(testThree) != testThreeTraceF) {
    return 1;
  }

  freeT(idOne);
  freeT(idOneTrace);

  freeT(idTwo);
  freeT(idTwoTrace);

  freeT(testThree);
  freeT(testThreeTrace);

  return 0;
}
