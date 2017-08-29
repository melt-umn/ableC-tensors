#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with tensor_combine
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

  Tensor tenOneF = fill(1,dataTestOne,2);
  Tensor tenOneS = fill(1,dataTestOne,5);
  Tensor tenOneAdd = fill(1,dataTestOne,7);
  Tensor tenOneSub = fill(1,dataTestOne,-3);
  Tensor tenOneMul = fill(1,dataTestOne,10);
  Tensor tenOneDiv = fill(1,dataTestOne, (2.0/5.0));
  Tensor tenOneNeg = fill(1,dataTestOne,-2);

  Tensor tenTwoF = fill(2,dataTestTwo,666);
  Tensor tenTwoS = fill(2,dataTestTwo,1);
  Tensor tenTwoAdd = fill(1,dataTestTwo,667);
  Tensor tenTwoSub = fill(1,dataTestTwo,665);
  Tensor tenTwoMul = fill(1,dataTestTwo,666);
  Tensor tenTwoDiv = fill(1,dataTestTwo, 666);
  Tensor tenTwoSub = fill(2,dataTestTwo,-666);

  Tensor tenThreeF = fill(3,dataTestThree,100);
  Tensor tenThreeS = fill(3,dataTestThree,101);
  Tensor tenThreeAdd = fill(1,dataTestThree,201);
  Tensor tenThreeSub = fill(1,dataTestThree,-1);
  Tensor tenThreeMul = fill(1,dataTestThree,10100);
  Tensor tenThreeDiv = fill(1,dataTestThree, (100.0/101.0));
  Tensor tenThreeSub = fill(3,dataTestThree,-100);

  Tensor tenFourF = fill(0,dataTestFour,1);
  Tensor tenFourS = fill(0,dataTestFour,9);
  Tensor tenFourAdd = fill(1,dataTestFour,10);
  Tensor tenFourSub = fill(1,dataTestFour,-8);
  Tensor tenFourMul = fill(1,dataTestFour,9);
  Tensor tenFourDiv = fill(1,dataTestFour, (1.0/9.0));
  Tensor tenFourSub = fill(0,dataTestFour,-1);

  if (tenOneAdd != tenOneF + tenOneS) {
    return 1;
  }
  if (tenOneSub != tenOneF - tenOneS) {
    return 1;
  }
  if (tenOneMul != tenOneF * tenOneS) {
    return 1;
  }
  if (tenOneDiv != tenOneF / tenOneS) {
    return 1;
  }
  if (tenOneNeg != -tenOneF) {
   return 1;
  }

  if (tenTwoAdd != tenTwoF + tenTwoS) {
    return 1;
  }
  if (tenTwoSub != tenTwoF - tenTwoS) {
    return 1;
  }
  if (tenTwoMul != tenTwoF * tenTwoS) {
    return 1;
  }
  if (tenTwoDiv != tenTwoF / tenTwoS) {
    return 1;
  }
  if (tenTwoNeg != -tenTwoF) {
   return 1;
  }

  if (tenThreeAdd != tenThreeF + tenThreeS) {
    return 1;
  }
  if (tenThreeSub != tenThreeF - tenThreeS) {
    return 1;
  }
  if (tenThreeMul != tenThreeF * tenThreeS) {
    return 1;
  }
  if (tenThreeDiv != tenThreeF / tenThreeS) {
    return 1;
  }
  if (tenThreeNeg != -tenThreeF) {
   return 1;
  }

  if (tenFourAdd != tenFourF + tenFourS) {
    return 1;
  }
  if (tenFourSub != tenFourF - tenFourS) {
    return 1;
  }
  if (tenFourMul != tenFourF * tenFourS) {
    return 1;
  }
  if (tenFourDiv != tenFourF / tenFourS) {
    return 1;
  }
  if (tenFourNeg != -tenFourF) {
   return 1;
  }

  freeT(tenOneF);
  freeT(tenTwoF);
  freeT(tenThreeF);
  freeT(tenFourF);

  freeT(tenOneS);
  freeT(tenTwoS);
  freeT(tenThreeS);
  freeT(tenFourS);

  freeT(tenOneAdd);
  freeT(tenTwoAdd);
  freeT(tenThreeAdd);
  freeT(tenFourAdd);

  freeT(tenOneSub);
  freeT(tenTwoSub);
  freeT(tenThreeSub);
  freeT(tenFourSub);

  freeT(tenOneMul);
  freeT(tenTwoMul);
  freeT(tenThreeMul);
  freeT(tenFourMul);

  freeT(tenOneDiv);
  freeT(tenTwoDiv);
  freeT(tenThreeDiv);
  freeT(tenFourDiv);

  freeT(tenOneNeg);
  freeT(tenTwoNeg);
  freeT(tenThreeNeg);
  freeT(tenFourNeg);

  return 0;
}
