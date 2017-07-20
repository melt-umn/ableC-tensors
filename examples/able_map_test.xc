#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with map
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

  printf("3 x 9 666 tensor: \n");
  printT(tenTwo);
  printf("\n");

  printf("2 x 3 x 4 100 tensor: \n");
  printT(tenThree);
  printf("\n");

  printf("9 2 tensor incremented\n");
  printT(increment(tenOne));
  printf("\n");

  printf("\n9 3 tensor squared\n");
  printT(square(tenOne));
  printf("\n");

  printf("3 x 9 666 tensor incremented\n");
  printT(increment(tenTwo));
  printf("\n");

  printf("\n3 x 9 667 tensor squared\n");
  printT(square(tenTwo));
  printf("\n");

  printf("2 x 3 x 4 100 tensor incremented\n");
  printT(increment(tenThree));

  printf("\n2 x 3 x 4 101 tensor squared\n");
  printT(square(tenThree));
  printf("\n");

  printf("0 dim 1 tensor incremented\n");
  printT(increment(tenFour));
  printf("\n");

  printf("\n0 dim 2 tensor squared\n");
  printT(square(tenFour));
  printf("\n");

  printf("2 x 2 identity tensor incremented\n");
  printT(increment(tenFive));
  printf("\n");

  printf("2 x 2 identity tensor + 1 squared\n");
  printT(square(tenFive));
  printf("\n");

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);
  freeT(tenFive);

  return 0;
}
