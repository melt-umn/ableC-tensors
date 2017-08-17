#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with tensor_combine
int main () {
  Tensor tenZero = [[ 666, 662, 35 ]];
  Tensor tenOne = [[ 22, 1234, 2 ]];
  Tensor tenTwo = [[ 32, 543, 65 ]];

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

  freeT(tenZero);
  freeT(tenOne);
  freeT(tenTwo);

  return 0;
}
