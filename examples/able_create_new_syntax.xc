#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//creating tensors with "normal" syntax
int main () {

  Tensor tenZero = [[ 666 ]];
  Tensor tenOne = [[ [[ 666 ]] ]]; 
  Tensor tenTwo = [[ 22, 32 ]];
  Tensor tenThree = [[ 22, 32, 42 ]];
  Tensor tenFour = [[ [[ 22 ]], [[ 32 ]] ]]; 
  Tensor tenFive = [[ [[ 666, 222 ]] ]]; 
  Tensor tenSix = [[ [[ 32,1234,2 ]],[[ 645,-6,43 ]],[[ -4345,13,0 ]] ]]; 
  Tensor tenSeven = [[ [[ [[ 1,2,3 ]],[[ 4,5,6 ]] ]],[[ [[ 7,8,9 ]],[[ 10,11,12 ]] ]] ]];

/*
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
*/
  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);
  freeT(tenFive);
  freeT(tenSix);
  freeT(tenSeven);

  return 0;
}
