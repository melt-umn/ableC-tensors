#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with fold
//max, min, sum, prod, maxT, minT, sumT, prodT
//also tests one tensor with tensor_fold
int main () {

  int *dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 9;

  int *dataTestTwo = malloc(sizeof(int) * 2);
  dataTestTwo[0] = 3;
  dataTestTwo[1] = 9;

  int *dataTestThree = malloc(sizeof(int)*3);
  dataTestThree[0] = 2;
  dataTestThree[1] = 3;
  dataTestThree[2] = 4;

  int *dataTestFour = NULL;

  Tensor tenOne = fill(1,dataTestOne,2);
  Tensor tenTwo = fill(2,dataTestTwo,666);
  Tensor tenThree = fill(3,dataTestThree,100);
  Tensor tenFour = fill(0,dataTestFour,1);
  Tensor tenFive = [[ 1, 2, 3, 4, 5, -1, 2, 2, 95 ]];

  if (max(tenOne) != 2) {
    return 1;
  }
  if (min(tenOne) != 2) {
    return 1;
  }
  if (sum(tenOne) != 18) {
    return 1;
  }
  if (prod(tenOne) != 512) {
    return 1;
  }

  if (max(tenTwo) != 666) {
    return 1;
  }
  if (min(tenTwo) != 666) {
    return 1;
  }
  if (sum(tenTwo) != 17982) {
    return 1;
  } //prod would be too large

  if (max(tenThree) != 100) {
    return 1;
  }
  if (min(tenThree) != 100) {
    return 1;
  }
  if (sum(tenThree) != 2400) {
    return 1;
  } //prod would be too large

  if (max(tenFour) != 1) {
    return 1;
  }
  if (min(tenFour) != 1) {
    return 1;
  }
  if (sum(tenFour) != 1) {
    return 1;
  }
  if (prod(tenFour) != 1) {
    return 1;
  }

  if (max(tenFive) != 95) {
    return 1;
  }
  if (min(tenFive) != -1) {
    return 1;
  }
  if (sum(tenFive) != 113) {
    return 1;
  }
  if (prod(tenFive) != -45,600) {
    return 1;
  }

  Tensor tenFiveMax = [[ 95 ]];
  Tensor tenFiveMin = [[ -1 ]];
  Tensor tenFiveSum = [[ 113 ]];
  Tensor tenFiveProd = [[ -45,600 ]];

  if (ten_max(tenFive) != tenFiveMax) {
    return 1;
  }
  if (ten_min(tenFive) != tenFiveMin) {
    return 1;
  }
  if (ten_sum(tenFive) != tenFiveSum) {
    return 1;
  }
  if (ten_prod(tenFive) != tenFiveProd) {
    return 1;
  }

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);
  freeT(tenFive);

  freeT(tenFiveMax);
  freeT(tenFiveMin);
  freeT(tenFiveSum);
  freeT(tenFiveProd);

  return 0;
}
