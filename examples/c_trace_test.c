#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//tests the trace function
int main () {
  Tensor idOne = create_identity_tensor(2,3);
  printf("3 x 3 identity tensor is: \n");
  print_tensor(idOne,delimiters,10);
  printf("Trace (Tensor) is:\n");
  print_tensor(tensor_trace(idOne),delimiters,10);
  printf("Trace (int) is: %f",trace(idOne));
  printf("\n\n");

  Tensor idTwo = create_identity_tensor(2,10);
  printf("10 x 10 identity tensor is: \n");
  print_tensor(idTwo,delimiters,10);
  printf("Trace (Tensor) is:\n");
  print_tensor(tensor_trace(idTwo),delimiters,10);
  printf("Trace (int) is: %f",trace(idTwo));
  printf("\n\n");

  int *dataTest;
  dataTest = malloc(sizeof(int)*2);
  dataTest[0] = 5;
  dataTest[1] = 5;
  Tensor testThree = fill_tensor(2,dataTest,666);
  printf("5 x 5 666 tensor is: \n");
  print_tensor(testThree,delimiters,10);
  printf("Trace (Tensor) is:\n");
  print_tensor(tensor_trace(testThree),delimiters,10);
  printf("Trace (int) is: %f",trace(testThree));

  return 0;
}
