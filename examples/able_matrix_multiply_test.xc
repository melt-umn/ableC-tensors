#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//create manual tensors boop boop
int main () {
  Tensor tenOne = [[ [[ 9, 10, 21 ]], [[ 32, 53, 12 ]], [[ 43, 4, 10 ]] ]];
  Tensor tenTwo = [[ [[ 12, 43, 65, 34, 23 ]], [[ 6, 7, 2, 45, 20 ]], [[ 40, 21, 65, 7, 69 ]] ]];
  Tensor tenThree = [[ [[ 1, 3, 6, 2 ]], [[ 12, 64, 29, 5 ]], [[ 39, 492, 42, 45 ]], [[ 65, 23, 56, 23 ]], [[ 12, 45, 12, 34 ]] ]];
  Tensor tenFour = [[ [[ 666, 555 ]], [[ 444, 333 ]], [[ 222, 111 ]], [[ 45, 2 ]] ]];

  printf("tenOne is: \n");
  printT(tenOne);
  printf("\n\n\n");

  printf("tenTwo is: \n");
  printT(tenTwo);
  printf("\n\n\n");

  printf("tenTwo transposed is: \n");
  printT(trans(tenTwo));
  printf("\n\n\n");

  printf("tenThree is: \n");
  printT(tenThree);
  printf("\n");

  printf("tenFour is: \n");
  printT(tenFour);
  printf("\n\n\n");

  printT(tenOne ** tenTwo);
  printf("\n\n\n");

  printf("tenTwo * tenThree is: \n");
  printT(tenTwo ** tenThree);
  printf("\n\n\n");

  printf("tenThree * tenFour is: \n");
  printT(tenThree ** tenFour);

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);

  return 0;
}
