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

  Tensor tenTwoF = fill(2,dataTestTwo,666);
  Tensor tenTwoS = fill(2,dataTestTwo,1);
  Tensor tenTwoAdd = fill(2,dataTestTwo,667);
  Tensor tenTwoSub = fill(2,dataTestTwo,665);
  Tensor tenTwoMul = fill(2,dataTestTwo,666);
  Tensor tenTwoDiv = fill(2,dataTestTwo, 666);

  Tensor tenThreeF = fill(3,dataTestThree,100);
  Tensor tenThreeS = fill(3,dataTestThree,101);
  Tensor tenThreeAdd = fill(3,dataTestThree,201);
  Tensor tenThreeSub = fill(3,dataTestThree,-1);
  Tensor tenThreeMul = fill(3,dataTestThree,10100);
  Tensor tenThreeDiv = fill(3,dataTestThree, (100.0/101.0));

  Tensor tenFourF = fill(0,dataTestFour,1);
  Tensor tenFourS = fill(0,dataTestFour,9);
  Tensor tenFourAdd = fill(0,dataTestFour,10);
  Tensor tenFourSub = fill(0,dataTestFour,-8);
  Tensor tenFourMul = fill(0,dataTestFour,9);
  Tensor tenFourDiv = fill(0,dataTestFour, (1.0/9.0));

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

  freeT(tenOneF);
  freeT(tenTwoF);
  freeT(tenThreeF);
  freeT(tenFourF);

  //each tensor points to the same spot in memory as the other tensors that
  //match (tenNumber***), so once you freeT one of the tensors, that memory
  //has already been freed. all that's left is to free the data

  free(tenOneS.data);
  free(tenTwoS.data);
  free(tenThreeS.data);
  free(tenFourS.data);

  free(tenOneAdd.data);
  free(tenTwoAdd.data);
  free(tenThreeAdd.data);
  free(tenFourAdd.data);

  free(tenOneSub.data);
  free(tenTwoSub.data);
  free(tenThreeSub.data);
  free(tenFourSub.data);

  free(tenOneMul.data);
  free(tenTwoMul.data);
  free(tenThreeMul.data);
  free(tenFourMul.data);

  free(tenOneDiv.data);
  free(tenTwoDiv.data);
  free(tenThreeDiv.data);
  free(tenFourDiv.data);

  return 0;
}
