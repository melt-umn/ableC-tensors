#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests cross product

int main () {
  Tensor tenZero = [[ 666, 662, 35 ]];
  Tensor tenOne = [[ 22, 1234, 2 ]];
  Tensor tenTwo = [[ 32, 543, 65 ]];

  Tensor crossZeroOne = [[-41866, -562, 807280]];
  Tensor crossOneZero = [[41866, 562, -807280]];
  Tensor crossZeroTwo = [[24025, -42170, 340454]];
  Tensor crossOneTwo = [[79124, -1366, -27542]];

  if (crossZeroOne != tenZero x* tenOne) {
    return 1;
  }

  if (crossOneZero != tenOne x* tenZero) {
    return 1;
  }

  if (crossZeroTwo != tenZero x* tenTwo) {
    return 1;
  }

  if (crossOneTwo != tenOne x* tenTwo) {
    return 1;
  }

  freeT(tenZero);
  freeT(tenOne);
  freeT(tenTwo);
  freeT(crossZeroOne);
  freeT(crossOneZero);
  freeT(crossZeroTwo);
  freeT(crossOneTwo);

  return 0;
}
