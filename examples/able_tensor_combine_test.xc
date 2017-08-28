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

  Tensor tenTwoF = fill(2,dataTestTwo,666);
  Tensor tenTwoS = fill(2,dataTestTwo,1);

  Tensor tenThreeF = fill(3,dataTestThree,100);
  Tensor tenThreeS = fill(3,dataTestThree,101);

  Tensor tenFourF = fill(0,dataTestFour,1);
  Tensor tenFourS = fill(0,dataTestFour,9);

  printf("\nadd 1 dim 2's and 5's tensors:\n");
  printT(tenOneF + tenOneS);
  printf("\n\nsub 1 dim 2's and 5's tensors:\n");
  printT(tenOneF - tenOneS);
  printf("\n\nmul 1 dim 2's and 5's tensors:\n");
  printT(tenOneF * tenOneS);
  printf("\n\ndiv 1 dim 2's and 5's tensors:\n");
  printT(tenOneF /tenOneS);
  printf("\n\n\n");

  printf("\nadd 2 dim 666's and 1's tensors:\n");
  printT(tenTwoF + tenTwoS);
  printf("\n\nsub 2 dim 666's and 1's tensors:\n");
  printT(tenTwoF - tenTwoS);
  printf("\n\nmul 2 dim 666's and 1's tensors:\n");
  printT(tenTwoF * tenTwoS);
  printf("\n\ndiv 2 dim 666's and 1's tensors:\n");
  printT(tenTwoF / tenTwoS);
  printf("\n\n\n");

  printf("\nadd 3 dim 100's and 101's tensors:\n");
  printT(tenThreeF + tenThreeS);
  printf("\n\nsub 3 dim 100's and 101's tensors:\n");
  printT(tenThreeF - tenThreeS);
  printf("\n\nmul 3 dim 100's and 101's tensors:\n");
  printT(tenThreeF * tenThreeS);
  printf("\n\ndiv 3 dim 100's and 101's tensors:\n");
  printT(tenThreeF / tenThreeS);
  printf("\n\n\n");

  printf("\nadd 0 dim 1's and 9's tensors:\n");
  printT(tenFourF + tenFourS);
  printf("\n\nsub 0 dim 1's and 9's tensors:\n");
  printT(tenFourF - tenFourS);
  printf("\n\nmul 0 dim 1's and 9's tensors:\n");
  printT(tenFourF * tenFourS);
  printf("\n\ndiv 0 dim 1's and 9's tensors:\n");
  printT(tenFourF / tenFourS);

  printf("\n\nsome tensors negated:\n");
  printT(-tenThreeF);
  printT(-tenThreeS);
  printT(-tenFourF);
  printT(-tenFourS);

  freeT(tenOneF);
  freeT(tenTwoF);
  freeT(tenThreeF);
  freeT(tenFourF);
  freeT(tenOneS);
  freeT(tenTwoS);
  freeT(tenThreeS);
  freeT(tenFourS);

  return 0;
}
