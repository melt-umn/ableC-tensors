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

  int *dataTestFive;
  dataTestFive = malloc(sizeof(int)*3);
  dataTestFive[0] = 3;
  dataTestFive[1] = 3;
  dataTestFive[2] = 3;

  Tensor fillOne = fill(0,dataTestOne,666);
  Tensor fillTwo = fill(1,dataTestTwo,666);
  Tensor fillThree = fill(2,dataTestThree,1);
  Tensor onesThree = ones(2,dataTestThree);
  Tensor fillFour = fill(2,dataTestFour,0);
  Tensor zerosFour = zeros(2,dataTestFour);
  Tensor fillFive = fill(3,dataTestFive,666);

  //same tensors with new syntax
  Tensor fillOneSyn = [[ 666 ]];
  Tensor fillTwoSyn = [[ 666, 666, 666 ]];
  Tensor fillFiveSyn = [[ [[ [[ 666, 666, 666 ]], [[666, 666, 666]], [[ 666, 666, 666 ]] ]],
                          [[ [[ 666, 666, 666 ]], [[666, 666, 666]], [[ 666, 666, 666 ]] ]],
                          [[ [[ 666, 666, 666 ]], [[666, 666, 666]], [[ 666, 666, 666 ]] ]] ]];

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

  if (fillFive != fillFiveSyn) {
    return 1;
  }

  freeT(fillOne);
  freeT(fillTwo);
  freeT(fillThree);
  freeT(fillFour);
  freeT(fillFive);
  freeT(fillOneSyn);
  freeT(fillTwoSyn);
  freeT(onesThree);
  freeT(zerosFour);
  freeT(fillFiveSyn);


  return 0;
}
