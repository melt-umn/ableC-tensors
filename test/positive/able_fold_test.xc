#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with fold
//-- maxT, minT, sumT, prodT
//also tests one function for tensor_fold just to have something :)
int main () {

  int *dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 9;

  int *dataTestTwo = malloc(sizeof(int) * 2);
  dataTestTwo[0] = 3;
  dataTestTwo[1] = 9;

  int *dataTestThree = malloc(sizeof(int)*3);
  dataTestThree[0] = 2;
  dataTestThree[1] = 3;
  dataTestThree[2] = 4;

  int *dataTestFour = NULL;

  Tensor tenOne = fill(1,dataTestOne,2);
  Tensor tenTwo = fill(2,dataTestTwo,666);
  Tensor tenThree = fill(3,dataTestThree,100);
  Tensor tenFour = fill(0,dataTestFour,1);

  printf("9 2's tensor: \n");
  printT(tenOne);
  printf("\n");
  printf("9 2's tensor max\n");
  printf("%f",max(tenOne));
  printf("\n9 2's tensor min\n");
  printf("%f",min(tenOne));
  printf("\n9 2's tensor sum\n");
  printf("%f",sum(tenOne));
  printf("\n9 2's tensor product\n");
  printf("%f",prod(tenOne));
  printf("\n\n\n");

  printf("3 x 9 666's tensor: \n");
  printT(tenTwo);
  printf("\n");
  printf("3 x 9 666's tensor max\n");
  printf("%f",max(tenTwo));
  printf("\n3 x 9 666's tensor min\n");
  printf("%f",min(tenTwo));
  printf("\n3 x 9 666's tensor sum\n");
  printf("%f",sum(tenTwo));
  printf("\n3 x 9 666's tensor product (overflows)\n");
  printf("%f",prod(tenTwo));
  printf("\n\n\n");

  printf("2 x 3 x 4 100's tensor: \n");
  printT(tenThree);
  printf("\n");
  printf("2 x 3 x 4 100's tensor max\n");
  printf("%f",max(tenThree));
  printf("\n2 x 3 x 4 100's tensor min\n");
  printf("%f",min(tenThree));
  printf("\n2 x 3 x 4 100's tensor sum\n");
  printf("%f",sum(tenThree));
  printf("\n2 x 3 x 4 100's tensor product (overflows)\n");
  printf("%f",prod(tenThree));
  printf("\n\n\n");


  printf("0 dim 1's tensor: \n");
  printT(tenFour);
  printf("\n");
  printf("0 dim 1's tensor max\n");
  printf("%f",max(tenFour));
  printf("\n9 2's tensor min\n");
  printf("%f",min(tenFour));
  printf("\n0 dim 1's tensor sum\n");
  printf("%f",sum(tenFour));
  printf("\n0 dim 1's tensor product\n");
  printf("%f",prod(tenFour));
  printf("\n\n\n");

  Tensor tenFive = id(2,2);
  printf("\n2 x 2 identity tensor plus 1\n");
  printT(incr(tenFive));
  printf("\n");

  printf("2 x 2 id tensor + 1's: \n");
  printT(tenFive);
  printf("\n");
  printf("2 x 2 id tensor + 1's max\n");
  printf("%f",max(tenFive));
  printf("\n2 x 2 id tensor + 1's min\n");
  printf("%f",min(tenFive));
  printf("\n2 x 2 id tensor + 1's sum\n");
  printf("%f",sum(tenFive));
  printf("\n2 x 2 id tensor + 1's product\n");
  printf("%f",prod(tenFive));
  printf("\n\n\n");

  printf("again but with tensor_fold\n\n");
  printf("2 x 2 id tensor + 1's: \n");
  printT(tenFive);
  printf("\n");
  printf("2 x 2 id tensor + 1's max\n");
  printT(ten_max(tenFive));
  printf("\n2 x 2 id tensor + 1's min\n");
  printT(ten_min(tenFive));
  printf("\n2 x 2 id tensor + 1's sum\n");
  printT(ten_sum(tenFive));
  printf("\n2 x 2 id tensor + 1's product\n");
  printT(ten_prod(tenFive));

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);
  freeT(tenFive);

  return 0;
}
