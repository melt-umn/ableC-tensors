#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {
  int intOne = 5;
  int intTwo = 666;
  int intThree = -12;

  Tensor tenOne = [[ intOne ]];
  printf("print 5 as tensor:\n");
  printT(tenOne);
  printf("\n");

  Tensor tenTwo = [[ intTwo ]];
  printf("print 666 as tensor:\n");
  printT(tenTwo);
  printf("\n");

  Tensor tenThree = [[ intThree ]];
  printf("print -12 as tensor:\n");
  printT(tenThree);
  printf("\n");

  printf("ten 5 to int 5 is: %f\n",ten_to_float(tenOne));
  printf("ten 666 to int 666 is: %f\n",ten_to_float(tenTwo));
  printf("ten -12 to int -12 is: %f\n\n",ten_to_float(tenThree));

  int *dataTestOne = NULL;

  int *dataTestTwo;
  dataTestTwo = malloc(sizeof(int));
  dataTestTwo[0] = 1;

  Tensor tenFour = fill(0,dataTestOne,1);
  printf("0 dim 1 tensor is: \n");
  printT(tenFour);
  printf("\n");
  printf("ten 1 to int 1 is: %f\n\n",ten_to_float(tenFour));

  Tensor tenFive = fill(0,dataTestOne,-666);
  printf("0 dim -666 tensor is: \n");
  printT(tenFive);
  printf("\n");
  printf("ten -666 to int -66 is: %f\n\n",ten_to_float(tenFive));

  Tensor tenSix = fill(1,dataTestTwo,134);
  printf("0 dim 134 tensor is: \n");
  printT(tenSix);
  printf("\n");
  printf("ten 134 to int 134 is: %f\n",ten_to_float(tenSix));

  return 0;
}
