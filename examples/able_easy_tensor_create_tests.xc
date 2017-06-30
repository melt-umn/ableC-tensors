#include "../include/tensorsLib.h"
#include <stdlib.h>
#include <stdio.h>
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
  dataTestFive[1] = 4;
  dataTestFive[2] = 5;

  Tensor fillOne = fill(0,dataTestOne,666);
  printf("0 dim 666 tensor is: \n");
  printT(fillOne);
  printf("\n");

  Tensor fillTwo = fill(1,dataTestTwo,666);
  printf("3 x 1 666 tensor is: \n");
  printT(fillTwo);
  printf("\n");

  Tensor fillThree = onesT(2,dataTestThree);
  printf("2 x 5 ones tensor is: \n");
  printT(fillThree);
  printf("\n");

  Tensor fillFour = zerosT(2,dataTestFour);
  printf("1 x 6 zeros tensor is: \n");
  printT(fillFour);
  printf("\n");

  Tensor fillFive = fill(3,dataTestFive,666);
  printf("3 x 4 x 5 666 tensor is: \n");
  printT(fillFive);

  freeT(fillOne);
  freeT(fillTwo);
  freeT(fillThree);
  freeT(fillFour);
  freeT(fillFive);

  return 0;
}
