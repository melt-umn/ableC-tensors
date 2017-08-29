#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {
  int intOne = 5;
  int intTwo = 666;
  int intThree = -12;

  Tensor tenOne = [[ intOne ]];
  Tensor tenOneTensor = [[ 5 ]];

  if (tenOne != tenOneTensor) {
    return 1;
  }

  Tensor tenTwo = [[ intTwo ]];
  Tensor tenTwoTensor = [[ 666 ]];

  if (tenTwo != tenTwoTensor) {
    return 1;
  }

  Tensor tenThree = [[ intThree ]];
  Tensor tenThreeTensor = [[ -12 ]];

  if (tenThree != tenThreeTensor) {
    return 1;
  }

  freeT(tenOne);
  freeT(tenOneTensor);
  freeT(tenTwo);
  freeT(tenTwoTensor);
  freeT(tenThree);
  freeT(tenThreeTensor);

  return 0;
}
