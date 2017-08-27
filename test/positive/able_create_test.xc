#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//create manual tensors boop boop
int main () {
  int i;

  int dimZero = 0;
  int dimOne = 1;
  int dimTwo = 2;
  int dimThree = 3;

  int *dimSizeZero = NULL;

  int *dimSizeOne = malloc(sizeof(int)); //1
  dimSizeOne[0] = 1;

  int *dimSizeTwo = malloc(sizeof(int)*2); //3 x 3
  dimSizeTwo[0] = 3;
  dimSizeTwo[1] = 3;

  int *dimSizeThree = malloc(sizeof(int)*3); //4 x 5 x 3
  dimSizeThree[0] = 2;
  dimSizeThree[1] = 3;
  dimSizeThree[2] = 3;

  int countZero = 1;
  int countOne = 1;
  int countTwo = 9;
  int countThree = 18;

  float *dataZero = malloc(sizeof(float));
  dataZero[0] = 666;

  float *dataOne = malloc(sizeof(float));
  dataOne[0] = 22;

  float *dataTwo = malloc(sizeof(float)*countTwo);
  dataTwo[0] = 32;
  dataTwo[1] = 1234;
  dataTwo[2] = 2;
  dataTwo[3] = 645;
  dataTwo[4] = -6;
  dataTwo[5] = 43;
  dataTwo[6] = -4345;
  dataTwo[7] = 13;
  dataTwo[8] = 0;

  float *dataThree = malloc(sizeof(float)*countThree);
  for (i = 0; i < countThree; i++) {
    dataThree[i] = i;
  }

  Tensor tenZero = create(dimZero,dimSizeZero,countZero,dataZero);
  Tensor tenOne = create(dimOne,dimSizeOne,countOne,dataOne);
  Tensor tenTwo = create(dimTwo,dimSizeTwo,countTwo,dataTwo);
  Tensor tenThree = create(dimThree,dimSizeThree,countThree,dataThree);

  printf("tenZero is: \n");
  printT(tenZero);
  printf("\n\n\n");

  printf("tenOne is: \n");
  printT(tenOne);
  printf("\n\n\n");

  printf("tenTwo is: \n");
  printT(tenTwo);
  printf("\n\n\n");

  printf("tenThree is: \n");
  printT(tenThree);
  printf("\n");

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);

  return 0;
}
