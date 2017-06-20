#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//tests different functions written with tensor_combine
int main () {

  int *dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 3;


  int dim = 1;

  int *dimSize = malloc(sizeof(int)); //1
  dimSize[0] = 3;

  int count = 3;

  int *dataZero = malloc(sizeof(int)*count);
  dataZero[0] = 666;
  dataZero[1] = 662;
  dataZero[2] = 35;

  int *dataOne = malloc(sizeof(int)*count);
  dataOne[0] = 22;
  dataOne[1] = 1234;
  dataOne[2] = 2;

  int *dataTwo = malloc(sizeof(int)*count);
  dataTwo[0] = 32;
  dataTwo[1] = 543;
  dataTwo[2] = 65;

  Tensor tenZero = create_tensor(dim,dimSize,count,dataZero);
  Tensor tenOne = create_tensor(dim,dimSize,count,dataOne);
  Tensor tenTwo = create_tensor(dim,dimSize,count,dataTwo);

  printf("[666 662 35] x* [22 1234 2]:\n");
  print_tensor(cross_product(tenZero,tenOne),delimiters,10);
  printf("\n\n\n");

  printf("[22 1234 2] x* [666 662 35]:\n");
  print_tensor(cross_product(tenOne,tenZero),delimiters,10);
  printf("\n\n\n");

  printf("[666 662 35] x* [32 543 65]:\n");
  print_tensor(cross_product(tenZero,tenTwo),delimiters,10);
  printf("\n\n\n");

  printf("[22 1234 2] x* [32 543 65]:\n");
  print_tensor(cross_product(tenOne,tenTwo),delimiters,10);
  printf("\n\n\n");

  return 0;
}
