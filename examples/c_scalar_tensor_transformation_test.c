#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

int main () {
  int intOne = 5;
  int intTwo = 666;
  int intThree = -12;

  Tensor tenOne = float_to_scalar_tensor(intOne);
  printf("print 5 as tensor:\n");
  print_tensor(tenOne,delimiters,10);
  printf("\n");

  Tensor tenTwo = float_to_scalar_tensor(intTwo);
  printf("print 666 as tensor:\n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n");

  Tensor tenThree = float_to_scalar_tensor(intThree);
  printf("print -12 as tensor:\n");
  print_tensor(tenThree,delimiters,10);
  printf("\n");

  printf("ten 5 to int 5 is: %f\n",scalar_tensor_to_float(tenOne));
  printf("ten 666 to int 666 is: %f\n",scalar_tensor_to_float(tenTwo));
  printf("ten -12 to int -12 is: %f\n\n",scalar_tensor_to_float(tenThree));

  int *dataTestOne = NULL;

  int *dataTestTwo;
  dataTestTwo = malloc(sizeof(int));
  dataTestTwo[0] = 1;

  Tensor tenFour = fill_tensor(0,dataTestOne,1);
  printf("0 dim 1 tensor is: \n");
  print_tensor(tenFour,delimiters,10);
  printf("\n");
  printf("ten 1 to int 1 is: %f\n\n",scalar_tensor_to_float(tenFour));

  Tensor tenFive = fill_tensor(0,dataTestOne,-666);
  printf("0 dim -666 tensor is: \n");
  print_tensor(tenFive,delimiters,10);
  printf("\n");
  printf("ten -666 to int -66 is: %f\n\n",scalar_tensor_to_float(tenFive));

  Tensor tenSix = fill_tensor(1,dataTestTwo,134);
  printf("0 dim 134 tensor is: \n");
  print_tensor(tenSix,delimiters,10);
  printf("\n");
  printf("ten 134 to int 134 is: %f\n",scalar_tensor_to_float(tenSix));

  return 0;
}
