#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with tensor_combine
int main () {
  Tensor tenZero = [. 666, 662, 35 .];
  Tensor tenOne = [. 22, 1234, 2 .];
  Tensor tenTwo = [. 32, 543, 65 .];

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
