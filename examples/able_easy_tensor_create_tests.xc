#include "../include/tensorsLib.h"
#include <stdlib.h>
#include <stdio.h>
int main() {
  int *dataTestThree;
  dataTestThree = malloc(sizeof(int)*2);
  dataTestThree[0] = 2;
  dataTestThree[1] = 5;
  Tensor fillThree = onesT(2,dataTestThree);
  printf("2 x 5 ones tensor is: \n");
  printT(fillThree);
  printf("\n");

  return 0;
}
