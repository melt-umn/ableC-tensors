#include "../include/tensorsLib.h"
#include <stdio.h>
#include <string.h>

int main () {
  Tensor idOne = id(2,3);
  printf("3 x 3 identity tensor is: \n");
  printT(idOne);
  printf("\n");

  Tensor idTwo = id(2,10);
  printf("10 x 10 identity tensor is: \n");
  printT(idTwo);
  printf("\n");

  Tensor idThree = id(3,5);
  printf("5 x 5 x 5 identity tensor is: \n");
  printT(idThree);
  printf("\n");

  Tensor idFour = id(5,3);
  printf("3 x 3 x 3 x 3 x 3 identity tensor is: \n");
  printT(idFour);

  return 0;
}
