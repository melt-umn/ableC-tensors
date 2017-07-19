#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//creating tensors with "normal" syntax
int main () {

  Tensor tenZero = [. 666 .];
  Tensor tenOne = [. [. 666 .] .];
  Tensor tenTwo = [. 22, 32 .];
  Tensor tenThree = [. [. 22 .], [. 32 .] .];
  Tensor tenFour = [. [. 666, 222 .] .];


  //Tensor tenTwo = [. [. 32,1234,2 .],[. 645,-6,43 .],[. -4345,13,0 .] .];
  //Tensor tenThree = [. [. [. 0,1,2 .],[. 3,4,5 .],[. 6,7,8 .] .],[. [. 9,10,11 .],[. 12,13,14 .],[. 15,16,17 .] .] .];

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
*/
  return 0;
}
