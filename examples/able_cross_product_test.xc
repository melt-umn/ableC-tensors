#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//tests different functions written with tensor_combine
int main () {

  float *dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 3;


  int dim = 1;

  int *dimSize = malloc(sizeof(int)); //1
  dimSize[0] = 3;

  int count = 3;

  float *dataZero = malloc(sizeof(int)*count);
  dataZero[0] = 666;
  dataZero[1] = 662;
  dataZero[2] = 35;

  float *dataOne = malloc(sizeof(int)*count);
  dataOne[0] = 22;
  dataOne[1] = 1234;
  dataOne[2] = 2;

  float *dataTwo = malloc(sizeof(int)*count);
  dataTwo[0] = 32;
  dataTwo[1] = 543;
  dataTwo[2] = 65;

  Tensor tenZero = create(dim,dimSize,count,dataZero);
  Tensor tenOne = create(dim,dimSize,count,dataOne);
  Tensor tenTwo = create(dim,dimSize,count,dataTwo);

  printf("([666 662 35] x* [22 1234 2]:\n");
  printT(tenZero x* tenOne);
  printf("\n\n\n");

  printf("([22 1234 2] x* [666 662 35]:\n");
  printT(tenOne x* tenZero);
  printf("\n\n\n");

  printf("([666 662 35] x* [32 543 65]:\n");
  printT(tenTwo x* tenTwo);
  printf("\n\n\n");

  printf("[22 1234 2] x* [32 543 65]:\n");
  printT(tenOne x* tenTwo);

  return 0;
}
