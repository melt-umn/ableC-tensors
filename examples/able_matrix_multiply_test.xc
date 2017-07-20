#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

  Tensor tenOne = create(dim,dimSizeOne,countOne,dataOne);
  Tensor tenTwo = create(dim,dimSizeTwo,countTwo,dataTwo);
  Tensor tenThree = create(dim,dimSizeThree,countThree,dataThree);
  Tensor tenFour = create(dim,dimSizeFour,countFour,dataFour);

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

  return 0;
}
