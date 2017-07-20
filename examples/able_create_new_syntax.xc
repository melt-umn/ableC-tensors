#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//creating tensors with "normal" syntax
int main () {

  Tensor tenZero = [. 666 .]; // 1
  Tensor tenOne = [. [. 666 .] .]; // 1 x 1
  Tensor tenTwo = [. 22, 32 .]; // 2
  Tensor tenThree = [. 22, 32, 42 .]; // 3
  Tensor tenFour = [. [. 22 .], [. 32 .] .]; // 2 x 1
  Tensor tenFive = [. [. 666, 222 .] .]; // 1 x 2
  Tensor tenSix = [. [. 32,1234,2 .],[. 645,-6,43 .],[. -4345,13,0 .] .]; // 3 x 3
  Tensor tenSeven = [. [. [. 3,4,5 .],[. 6,7,8 .] .],[. [. 12,13,14 .],[. 15,16,17 .] .] .];
  // 2 x 3 x 3

  printf("tenZero is: \n");
  printT(tenZero);
  printf("\n\n\n");

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
  printf("\n\n\n");

  printf("tenFive is: \n");
  printT(tenFive);
  printf("\n\n\n");

  printf("tenSix is: \n");
  printT(tenSix);
  printf("\n\n\n");

  printf("tenSeven is: \n");
  printT(tenSeven);
  printf("\n");
  return 0;
}
