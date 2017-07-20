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

  printf("1 dim 2's tensor .* 1 dim 5's tensor (Tensor):\n");
  printT(tenOneF .* tenOneS);
  printf("\n(Int): ");
  printf("%f",tenOneF f.* tenOneS);
  printf("\n\n\n");

  printf("2 dim 666's tensor .* 2 dim 1's tensor (Tensor):\n");
  printT(tenTwoF .* tenTwoS);
  printf("\n(Int): ");
  printf("%f",tenTwoF f.* tenTwoS );
  printf("\n\n\n");

  printf("3 dim 100's tensor .* 3 dim 101's tensor (Tensor):\n");
  printT(tenThreeF .* tenThreeS);
  printf("\n(Int): ");
  printf("%f",tenThreeF f.* tenThreeS);
  printf("\n\n\n");

  printf("0 dim 1's tensor .* 0 dim 9's tensor (Tensor):\n");
  printT(tenFourF .* tenFourS);
  printf("\n(Int): ");
  printf("%f",tenFourF f.* tenFourS);
  printf("\n");
  return 0;
}
