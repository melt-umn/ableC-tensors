#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//tests different functions written with tensor_combine
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

  Tensor tenOneF = fill_tensor(1,dataTestOne,2);
  Tensor tenOneS = fill_tensor(1,dataTestOne,5);

  Tensor tenTwoF = fill_tensor(2,dataTestTwo,666);
  Tensor tenTwoS = fill_tensor(2,dataTestTwo,1);

  Tensor tenThreeF = fill_tensor(3,dataTestThree,100);
  Tensor tenThreeS = fill_tensor(3,dataTestThree,101);

  Tensor tenFourF = fill_tensor(0,dataTestFour,1);
  Tensor tenFourS = fill_tensor(0,dataTestFour,9);

  printf("\nadd 1 dim 2's and 5's tensors:\n");
  print_tensor(tensor_elem_add(tenOneF,tenOneS),delimiters,10);
  printf("\n\nsub 1 dim 2's and 5's tensors:\n");
  print_tensor(tensor_elem_subtract(tenOneF,tenOneS),delimiters,10);
  printf("\n\nmul 1 dim 2's and 5's tensors:\n");
  print_tensor(tensor_elem_multiply(tenOneF,tenOneS),delimiters,10);
  printf("\n\ndiv 1 dim 2's and 5's tensors:\n");
  print_tensor(tensor_elem_divide(tenOneF,tenOneS),delimiters,10);
  printf("\n\n\n");

  printf("\nadd 2 dim 666's and 1's tensors:\n");
  print_tensor(tensor_elem_add(tenTwoF,tenTwoS),delimiters,10);
  printf("\n\nsub 2 dim 666's and 1's tensors:\n");
  print_tensor(tensor_elem_subtract(tenTwoF,tenTwoS),delimiters,10);
  printf("\n\nmul 2 dim 666's and 1's tensors:\n");
  print_tensor(tensor_elem_multiply(tenTwoF,tenTwoS),delimiters,10);
  printf("\n\ndiv 2 dim 666's and 1's tensors:\n");
  print_tensor(tensor_elem_divide(tenTwoF,tenTwoS),delimiters,10);
  printf("\n\n\n");

  printf("\nadd 3 dim 100's and 101's tensors:\n");
  print_tensor(tensor_elem_add(tenThreeF,tenThreeS),delimiters,10);
  printf("\n\nsub 3 dim 100's and 101's tensors:\n");
  print_tensor(tensor_elem_subtract(tenThreeF,tenThreeS),delimiters,10);
  printf("\n\nmul 3 dim 100's and 101's tensors:\n");
  print_tensor(tensor_elem_multiply(tenThreeF,tenThreeS),delimiters,10);
  printf("\n\ndiv 3 dim 100's and 101's tensors:\n");
  print_tensor(tensor_elem_divide(tenThreeF,tenThreeS),delimiters,10);
  printf("\n\n\n");

  printf("\nadd 0 dim 1's and 9's tensors:\n");
  print_tensor(tensor_elem_add(tenFourF,tenFourS),delimiters,10);
  printf("\n\nsub 0 dim 1's and 9's tensors:\n");
  print_tensor(tensor_elem_subtract(tenFourF,tenFourS),delimiters,10);
  printf("\n\nmul 0 dim 1's and 9's tensors:\n");
  print_tensor(tensor_elem_multiply(tenFourF,tenFourS),delimiters,10);
  printf("\n\ndiv 0 dim 1's and 9's tensors:\n");
  print_tensor(tensor_elem_divide(tenFourF,tenFourS),delimiters,10);

  return 0;
}
