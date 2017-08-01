#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {
  Tensor idOne = id(2,3);
  printf("3 x 3 identity tensor is: \n");
  printT(idOne);
  printf("Trace (Tensor) is:\n");
  printT(ten_trace(idOne));
  printf("Trace (int) is: %f",trace(idOne));
  printf("\n\n");

  Tensor idTwo = id(2,10);
  printf("10 x 10 identity tensor is: \n");
  printT(idTwo);
  printf("Trace (Tensor) is:\n");
  printT(ten_trace(idTwo));
  printf("Trace (int) is: %f",trace(idTwo));
  printf("\n\n");

  int *dataTest;
  dataTest = malloc(sizeof(int)*2);
  dataTest[0] = 5;
  dataTest[1] = 5;
  Tensor testThree = fill(2,dataTest,666);
  printf("5 x 5 666 tensor is: \n");
  printT(testThree);
  printf("Trace (Tensor) is:\n");
  printT(ten_trace(testThree));
  printf("Trace (int) is: %f",trace(testThree));

  return 0;
}
