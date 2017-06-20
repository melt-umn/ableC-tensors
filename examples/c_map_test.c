#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//tests different functions written with map
//-- scalar_add, scalar_subtract, scalar_multiply, scalar_divide, scalar_mod
//also tests one function for tensor_map just to have something :)
int main (int argc, char **argv) {

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

  Tensor tenOne = fill_tensor(1,dataTestOne,2);
  Tensor tenTwo = fill_tensor(2,dataTestTwo,666);
  Tensor tenThree = fill_tensor(3,dataTestThree,100);
  Tensor tenFour = fill_tensor(0,dataTestFour,1);
  Tensor tenFive = create_identity_tensor(2,2);

  printf("9 2 tensor: \n");
  print_tensor(tenOne,delimiters,10);
  printf("\n");

  printf("3 x 9 666 tensor: \n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n");

  printf("2 x 3 x 4 100 tensor: \n");
  print_tensor(tenThree,delimiters,10);
  printf("\n");

  printf("9 2 tensor incremented\n");
  print_tensor(increment(tenOne),delimiters,10);
  printf("\n9 3 tensor squared\n");
  print_tensor(square(tenOne),delimiters,10);

  printf("\n\n\n");

  printf("3 x 9 666 tensor incremented\n");
  print_tensor(increment(tenTwo),delimiters,10);
  printf("\n3 x 9 667 tensor squared\n");
  print_tensor(square(tenTwo),delimiters,10);
  printf("\n\n\n");

  printf("2 x 3 x 4 100 tensor incremented\n");
  print_tensor(increment(tenThree),delimiters,10);
  printf("\n2 x 3 x 4 101 tensor squared\n");
  print_tensor(square(tenThree),delimiters,10);
  printf("\n\n\n");

  printf("0 dim 1 tensor incremented\n");
  print_tensor(increment(tenFour),delimiters,10);
  printf("\n0 dim 2 tensor squared\n");
  print_tensor(square(tenFour),delimiters,10);
  printf("\n\n\n");

  printf("2 x 2 identity tensor incremented\n");
  print_tensor(increment(tenFive),delimiters,10);
  printf("\n");
  printf("2 x 2 identity tensor + 1 squared\n");
  print_tensor(square(tenFive),delimiters,10);
  printf("\n");



  return 0;
}
