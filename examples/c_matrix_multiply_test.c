// #include "tensorsLib.h"
#include "../src/tensorsLib.c"
#include <stdio.h>
#include <stdlib.h>

//create manual tensors boop boop
int main () {
  int dim = 2;

  int *dimSizeOne = malloc(sizeof(int)*2); //3 x 3
  dimSizeOne[0] = 3;
  dimSizeOne[1] = 3;

  int *dimSizeTwo = malloc(sizeof(int)*2); //3 x 5
  dimSizeTwo[0] = 3;
  dimSizeTwo[1] = 5;

  int *dimSizeThree = malloc(sizeof(int)*2); //5 x 4
  dimSizeThree[0] = 5;
  dimSizeThree[1] = 4;

  int *dimSizeFour = malloc(sizeof(int)*2); //4 x 2
  dimSizeFour[0] = 4;
  dimSizeFour[1] = 2;


  int countOne = 9;
  int countTwo = 15;
  int countThree = 20;
  int countFour = 8;

  float dataOne[9] = {9, 10, 21, 32, 53, 12, 43, 4, 10};
  float dataTwo[15] = {12, 43, 65, 34, 23, 6, 7, 2, 45, 20, 40, 21, 65, 7, 69};
  float dataThree[20] = {1, 3, 6, 2, 12, 64, 29, 5, 39, 492, 42, 45, 65, 23, 56, 23, 12, 45, 12, 34};
  float dataFour[8] = {666, 555, 444, 333, 222, 111, 45, 2};

  Tensor tenOne = create_tensor(dim,dimSizeOne,countOne,dataOne);
  Tensor tenTwo = create_tensor(dim,dimSizeTwo,countTwo,dataTwo);
  Tensor tenThree = create_tensor(dim,dimSizeThree,countThree,dataThree);
  Tensor tenFour = create_tensor(dim,dimSizeFour,countFour,dataFour);

  printf("tenOne is: \n");
  print_tensor(tenOne,delimiters,10);
  printf("\n\n\n");

  printf("tenTwo is: \n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n\n\n");

  printf("tenTwo transposed is: \n");
  print_tensor(transpose(tenTwo),delimiters,10);
  printf("\n\n\n");

  printf("tenThree is: \n");
  print_tensor(tenThree,delimiters,10);
  printf("\n");

  printf("tenFour is: \n");
  print_tensor(tenFour,delimiters,10);
  printf("\n\n\n");

  print_tensor(tensor_multiply(tenOne,tenTwo),delimiters,10);
  printf("\n\n\n");

  printf("tenTwo * tenThree is: \n");
  print_tensor(tensor_multiply(tenTwo,tenThree),delimiters,10);
  printf("\n\n\n");

  printf("tenThree * tenFour is: \n");
  print_tensor(tensor_multiply(tenThree,tenFour),delimiters,10);

  return 0;
}
