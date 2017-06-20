#include "tensorsLib.h"

//tests different functions written with tensor_combine
int main (int argc, char **argv) {

  int *dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 3;

  Tensor tenOneF = fill_tensor(1,dataTestOne,2);
  Tensor tenOneS = fill_tensor(1,dataTestOne,5);

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

  printf("scalar triple product of: [666 662 35], [22 1234 2], and [32 543 65]:\n");
  print_tensor(scalar_triple_product(tenZero,tenOne,tenTwo),delimiters,10);
  printf("int version: %d",int_scalar_triple_product(tenZero,tenOne,tenTwo));
  printf("\n\n\n");

  printf("scalar triple product of: [22 1234 2], [666 662 35], and [32 543 65]:\n");
  print_tensor(scalar_triple_product(tenOne,tenZero,tenTwo),delimiters,10);
  printf("int version: %d",int_scalar_triple_product(tenOne,tenZero,tenTwo));
  printf("\n\n\n");

  printf("scalar triple product of: [32 543 65], [666 662 35], and [22 1234 2]:\n");
  print_tensor(scalar_triple_product(tenTwo,tenZero,tenOne),delimiters,10);
  printf("int version: %d",int_scalar_triple_product(tenTwo,tenZero,tenOne));
  printf("\n\n\n\n\n");


  printf("vector triple product of: [666 662 35], [22 1234 2], and [32 543 65]:\n");
  print_tensor(vector_triple_product(tenZero,tenOne,tenTwo),delimiters,10);
  printf("\n\n");

  printf("vector triple product of: [22 1234 2], [666 662 35], and [32 543 65]:\n");
  print_tensor(vector_triple_product(tenOne,tenZero,tenTwo),delimiters,10);
  printf("\n\n");

  printf("vector triple product of: [32 543 65], [666 662 35], and [22 1234 2]:\n");
  print_tensor(vector_triple_product(tenTwo,tenZero,tenOne),delimiters,10);

  return 0;
}
