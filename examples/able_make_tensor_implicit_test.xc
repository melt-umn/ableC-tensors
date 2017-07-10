#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//create manual tensors boop boop
int main () {
  Tensor tenOne = [1];
  Tensor tenTwo = [666];
  Tensor tenThree = [];

  printf("tenOne is: \n");
  printT(tenOne);
  printf("\n\n\n");

  printf("tenTwo is: \n");
  printT(tenTwo);
  printf("\n\n\n");

  printf("tenThree is: \n");
  printT(tenThree);
  printf("\n");

  return 0;
}
