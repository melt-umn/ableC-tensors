#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests the transpose function (print isn't working yet)
int main () {
  Tensor tenOne = [[ [[ 9, 10, 21 ]], [[ 32, 53, 12 ]], [[ 43, 4, 10 ]] ]];
  Tensor tenTwo = [[ [[ 12, 43, 65, 34, 23 ]], [[ 6, 7, 2, 45, 20 ]], [[ 40, 21, 65, 7, 69 ]] ]];

  Tensor tenOneTrans = [[ [[ 9, 32, 43 ]], [[ 19, 53, 4 ]], [[ 21, 12, 10 ]] ]];
  Tensor tenTwoTrans = [[ [[ 12, 6, 40 ]], [[ 43, 7, 21 ]], [[ 65, 2, 65 ]] ,
                          [[ 34, 45, 7 ]], [[ 23, 20, 69]] ]];

  if (trans(tenOne) != tenOneTrans) {
    return 1;
  }

  if (trans(tenTwo) != tenTwoTrans) {
    return 1;
  }

  int *dataTestThree;
  dataTestThree = malloc(sizeof(int)*2);
  dataTestThree[0] = 2;
  dataTestThree[1] = 5;

  int *dataTestThreeTrans;
  dataTestThreeTrans = malloc(sizeof(int)*2);
  dataTestThreeTrans[0] = 5;
  dataTestThreeTrans[1] = 2;

  int *dataTestFour;
  dataTestFour = malloc(sizeof(int)*2);
  dataTestFour[0] = 1;
  dataTestFour[1] = 6;

  int *dataTestFourTrans;
  dataTestFourTrans = malloc(sizeof(int)*2);
  dataTestFourTrans[0] = 6;
  dataTestFourTrans[1] = 1;

  Tensor fillThree = ones(2,dataTestThree);
  Tensor fillThreeTrans = ones(2,dataTestThreeTrans);

  if (trans(fillThree) != fillThreeTrans) {
    return 1;
  }

  Tensor fillFour = zeros(2,dataTestFour);
  Tensor fillFourTrans = zeros(2,dataTestFourTrans);

  if (trans(fillFour) != fillFourTrans) {
    return 1;
  }


  freeT(tenOne);
  freeT(tenOneTrans);
  freeT(tenTwo);
  freeT(tenTwoTrans);
  freeT(fillThree);
  freeT(fillThreeTrans);
  freeT(fillFour);
  freeT(fillFourTrans);

  return 0;
}
