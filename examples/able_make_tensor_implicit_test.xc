#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//create manual tensors boop boop
int main () {
  Tensor tenOne = [[ 1 ]];
  Tensor tenTwo = [[ 666, 5 ]];
  Tensor tenThree = [[ [[ 1,2 ]], [[ 3,4 ]] ]];
  Tensor tenFour = [[ [[ 1 ]], [[ 1 ]] ]];

  printf("tenOne is: \n");
  printT(tenOne);
  printf("\n\n\n");

  printf("tenTwo is: \n");
  printT(tenTwo);
  printf("\n\n\n");

  printf("tenThree is: \n");
  printT(tenThree);
  printf("\n");

  printf("tenFour is: \n");
  printT(tenFour);
  printf("\n");

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);

  return 0;
}
