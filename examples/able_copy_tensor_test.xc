#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with copy
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
  Tensor tenFive = id(2,2);

  printf("9 2 tensor: \n");
  printT(tenOne);
  printf("\n");

  printf("9 2 tensor squared\n");
  printT(squareT(copy_tensor(tenOne)));
  printf("\n");

  printf("9 2 tensor: \n");
  printT(tenOne);
  printf("\n\n\n");

  printf("3 x 9 666 tensor: \n");
  printT(tenTwo);
  printf("\n");

  printf("3 x 9 666 tensor squared\n");
  printT(squareT(copy_tensor(tenTwo)));
  printf("\n");

  printf("3 x 9 666 tensor: \n");
  printT(tenTwo);
  printf("\n\n\n");

  printf("2 x 3 x 4 100 tensor: \n");
  printT(tenThree);
  printf("\n");

  printf("2 x 3 x 4 100 tensor squared\n");
  printT(squareT(copy_tensor(tenThree)));
  printf("\n");

  printf("2 x 3 x 4 100 tensor: \n");
  printT(tenThree);
  printf("\n\n\n");

  printf("0 dim 1 tensor 1: \n");
  printT(tenFour);
  printf("\n");

  printf("\n0 dim 1 tensor squared\n");
  printT(squareT(copy_tensor(tenFour)));
  printf("\n");

  printf("0 dim 1 tensor 1: \n");
  printT(tenFour);
  printf("\n\n\n");

  printf("2 x 2 identity tensor\n");
  printT(tenFive);
  printf("\n");

  printf("2 x 2 identity tensor squared\n");
  printT(squareT(copy_tensor(tenFive)));
  printf("\n");

  printf("2 x 2 identity tensor\n");
  printT(tenFive);
  printf("\n");

  return 0;
}
