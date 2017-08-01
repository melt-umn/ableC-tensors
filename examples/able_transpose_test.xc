#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests the transpose function (print isn't working yet)
int main () {
  Tensor tenOne = [[ [[ 9, 10, 21 ]], [[ 32, 53, 12 ]], [[ 43, 4, 10 ]] ]];
  Tensor tenTwo = [[ [[ 12, 43, 65, 34, 23 ]], [[ 6, 7, 2, 45, 20 ]], [[ 40, 21, 65, 7, 69 ]] ]];

  int *dataTestThree;
  dataTestThree = malloc(sizeof(int)*2);
  dataTestThree[0] = 2;
  dataTestThree[1] = 5;

  int *dataTestFour;
  dataTestFour = malloc(sizeof(int)*2);
  dataTestFour[0] = 1;
  dataTestFour[1] = 6;

  printf("first tensor is: \n");
  printT(tenOne);
  printf("\n");
  printf("first tensor transposed is: \n");
  printT(trans(tenOne));
  printf("\n\n");

  printf("second tensor is: \n");
  printT(tenTwo);
  printf("\n");
  printf("second tensor transposed is: \n");
  printT(trans(tenTwo));
  printf("\n\n");


  Tensor fillThree = ones(2,dataTestThree);
  printf("2 x 5 ones tensor is: \n");
  printT(fillThree);
  printf("\n");
  printf("2 x 5 ones transposed tensor is: \n");
  printT(trans(fillThree));
  printf("\n\n");

  Tensor fillFour = zeros(2,dataTestFour);
  printf("1 x 6 zeros tensor is: \n");
  printT(fillFour);
  printf("\n");
  printf("1 x 6 zeros tranposed tensor is: \n");
  printT(trans(fillFour));
  printf("\n\n");


  return 0;
}
