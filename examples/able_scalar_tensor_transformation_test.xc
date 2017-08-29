#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {
  int intOne = 5;
  int intTwo = 666;
  int intThree = -12;

  Tensor tenOne = float_to_ten(intOne);
  Tensor tenOneTensor = [[ 5 ]];

  if (tenOne != tenOneTensor) {
    return 1;
  }

  Tensor tenTwo = float_to_ten(intTwo);
  Tensor tenTwoTensor = [[ 666 ]];

  if (tenTwo != tenTwoTensor) {
    return 1;
  }

  Tensor tenThree = float_to_ten(intThree);
  Tensor tenThreeTensor = [[ -12 ]];

  if (tenThree != tenThreeTensor) {
    return 1;
  }

  if (ten_to_float(tenOne) != 5) {
    return 1;
  }

  if (ten_to_float(tenTwo) != 666) {
    return 1;
  }

  if (ten_to_float(tenThree) != -12) {
    return 1;
  }

  int *dataTestOne = NULL;

  int *dataTestTwo;
  dataTestTwo = malloc(sizeof(int));
  dataTestTwo[0] = 1;

  Tensor tenFour = fill(0,dataTestOne,1);
  Tensor tenFive = fill(0,dataTestOne,-666);
  Tensor tenSix = fill(1,dataTestTwo,134);

  if (ten_to_float(tenFour) != 1) {
    return 1;
  }
  if (ten_to_float(tenFive) != -666) {
    return 1;
  }
  if (ten_to_float(tenSix) != 134) {
    return 1;
  }


  freeT(tenOne);
  freeT(tenOne);
  freeT(tenTwoTensor);
  freeT(tenTwo);
  freeT(tenThreeTensor);
  freeT(tenThree);
  freeT(tenFourTensor);
  freeT(tenFive);
  freeT(tenSix);

  return 0;
}
