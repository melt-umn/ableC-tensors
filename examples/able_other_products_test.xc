#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//tests different functions written with tensor_combine
int main () {

  float *dataTestOne = malloc(sizeof(float));
  dataTestOne[0] = 3;

  int dim = 1;

  int *dimSize = malloc(sizeof(int)); //1
  dimSize[0] = 3;

  int count = 3;

  float *dataZero = malloc(sizeof(float)*count);
  dataZero[0] = 666;
  dataZero[1] = 662;
  dataZero[2] = 35;

  float *dataOne = malloc(sizeof(float)*count);
  dataOne[0] = 22;
  dataOne[1] = 1234;
  dataOne[2] = 2;

  float *dataTwo = malloc(sizeof(float)*count);
  dataTwo[0] = 32;
  dataTwo[1] = 543;
  dataTwo[2] = 65;

  Tensor tenZero = create(dim,dimSize,count,dataZero);
  Tensor tenOne = create(dim,dimSize,count,dataOne);
  Tensor tenTwo = create(dim,dimSize,count,dataTwo);

  printf("scalar triple product of: [666 662 35], [22 1234 2], and [32 543 65]:\n");
  printT(scalar_triple_productT(tenZero,tenOne,tenTwo));
  printf("int version: %f",float_triple_productT(tenZero,tenOne,tenTwo));
  printf("\n\n\n");

  printf("scalar triple product of: [22 1234 2], [666 662 35], and [32 543 65]:\n");
  printT(scalar_triple_productT(tenOne,tenZero,tenTwo));
  printf("int version: %f",float_triple_productT(tenOne,tenZero,tenTwo));
  printf("\n\n\n");

  printf("scalar triple product of: [32 543 65], [666 662 35], and [22 1234 2]:\n");
  printT(scalar_triple_productT(tenTwo,tenZero,tenOne));
  printf("int version: %f",float_triple_productT(tenTwo,tenZero,tenOne));
  printf("\n\n\n\n\n");


  printf("vector triple product of: [666 662 35], [22 1234 2], and [32 543 65]:\n");
  printT(vector_triple_productT(tenZero,tenOne,tenTwo));
  printf("\n\n");

  printf("vector triple product of: [22 1234 2], [666 662 35], and [32 543 65]:\n");
  printT(vector_triple_productT(tenOne,tenZero,tenTwo));
  printf("\n\n");

  printf("vector triple product of: [32 543 65], [666 662 35], and [22 1234 2]:\n");
  printT(vector_triple_productT(tenTwo,tenZero,tenOne));

  return 0;
}
