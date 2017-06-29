#include <stdio.h>
#include <stdlib.h>

int main() {
  int *dataTestThree;
  dataTestThree = malloc(sizeof(int)*2);
  dataTestThree[0] = 2;
  dataTestThree[1] = 5;

  Tensor fillThree = ones(2,dataTestThree);
  printf("2 x 5 ones tensor is: \n");
  print_tensor(fillThree,delimiters,10);
  printf("\n");

  return 0;
}
