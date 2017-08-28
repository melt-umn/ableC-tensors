#include "../include/tensorsLib.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
  int *dataTestOne;
  dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 1;

  int *dataTestTwo;
  dataTestTwo = malloc(sizeof(int));
  dataTestTwo[0] = 3;

  int *dataTestThree;
  dataTestThree = malloc(sizeof(int)*2);
  dataTestThree[0] = 2;
  dataTestThree[1] = 5;

  int *dataTestFour;
  dataTestFour = malloc(sizeof(int)*2);
  dataTestFour[0] = 1;
  dataTestFour[1] = 6;

  Tensor fillOne = fill(1,dataTestOne,666);
  Tensor fillTwo = fill(1,dataTestTwo,666);
  Tensor fillThree = fill(2,dataTestThree,1);
  Tensor onesThree = ones(2,dataTestThree);
  Tensor fillFour = fill(2,dataTestFour,0);
  Tensor zerosFour = zeros(2,dataTestFour);

  //same tensors with new syntax
  Tensor fillOneSyn = [[ 666 ]];
  Tensor fillTwoSyn = [[ 666, 666, 666 ]];

  if (fillOne != fillOneSyn) {
    return 1;
  }

  if (fillTwo != fillTwoSyn) {
    return 1;
  }

  if (onesThree != fillThree) {
    return 1;
  }

  if (zerosFour != fillFour) {
    return 1;
  }


  freeT(fillOne);
  freeT(fillTwo);
  freeT(fillThree);
  freeT(fillFour);
  freeT(fillOneSyn);
  freeT(fillTwoSyn);
  freeT(onesThree);
  freeT(zerosFour);


  return 0;
}
