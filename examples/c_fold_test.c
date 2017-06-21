#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//tests different functions written with fold
//-- max, min, sum, product
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

  Tensor tenOne = fill_tensor(1,dataTestOne,2);
  Tensor tenTwo = fill_tensor(2,dataTestTwo,666);
  Tensor tenThree = fill_tensor(3,dataTestThree,100);
  Tensor tenFour = fill_tensor(0,dataTestFour,1);

  printf("9 2's tensor: \n");
  print_tensor(tenOne,delimiters,10);
  printf("\n");
  printf("9 2's tensor max\n");
  printf("%f",max(tenOne));
  printf("\n9 2's tensor min\n");
  printf("%f",min(tenOne));
  printf("\n9 2's tensor sum\n");
  printf("%f",sum(tenOne));
  printf("\n9 2's tensor product\n");
  printf("%f",product(tenOne));
  printf("\n\n\n");

  printf("3 x 9 666's tensor: \n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n");
  printf("3 x 9 666's tensor max\n");
  printf("%f",max(tenTwo));
  printf("\n3 x 9 666's tensor min\n");
  printf("%f",min(tenTwo));
  printf("\n3 x 9 666's tensor sum\n");
  printf("%f",sum(tenTwo));
  printf("\n3 x 9 666's tensor product (overflows)\n");
  printf("%f",product(tenTwo));
  printf("\n\n\n");

  printf("2 x 3 x 4 100's tensor: \n");
  print_tensor(tenThree,delimiters,10);
  printf("\n");
  printf("2 x 3 x 4 100's tensor max\n");
  printf("%f",max(tenThree));
  printf("\n2 x 3 x 4 100's tensor min\n");
  printf("%f",min(tenThree));
  printf("\n2 x 3 x 4 100's tensor sum\n");
  printf("%f",sum(tenThree));
  printf("\n2 x 3 x 4 100's tensor product (overflows)\n");
  printf("%f",product(tenThree));
  printf("\n\n\n");


  printf("0 dim 1's tensor: \n");
  print_tensor(tenFour,delimiters,10);
  printf("\n");
  printf("0 dim 1's tensor max\n");
  printf("%f",max(tenFour));
  printf("\n9 2's tensor min\n");
  printf("%f",min(tenFour));
  printf("\n0 dim 1's tensor sum\n");
  printf("%f",sum(tenFour));
  printf("\n0 dim 1's tensor product\n");
  printf("%f",product(tenFour));
  printf("\n\n\n");

  Tensor tenFive = create_identity_tensor(2,2);
  printf("\n2 x 2 identity tensor plus 1\n");
  print_tensor(increment(tenFive),delimiters,10);
  printf("\n");

  printf("2 x 2 id tensor + 1's: \n");
  print_tensor(tenFive,delimiters,10);
  printf("\n");
  printf("2 x 2 id tensor + 1's max\n");
  printf("%f",max(tenFive));
  printf("\n2 x 2 id tensor + 1's min\n");
  printf("%f",min(tenFive));
  printf("\n2 x 2 id tensor + 1's sum\n");
  printf("%f",sum(tenFive));
  printf("\n2 x 2 id tensor + 1's product\n");
  printf("%f",product(tenFive));
  printf("\n\n\n");

  printf("again but with tensor_fold\n\n");
  printf("2 x 2 id tensor + 1's: \n");
  print_tensor(tenFive,delimiters,10);
  printf("\n");
  printf("2 x 2 id tensor + 1's max\n");
  print_tensor(tensor_max(tenFive),delimiters,10);
  printf("\n2 x 2 id tensor + 1's min\n");
  print_tensor(tensor_min(tenFive),delimiters,10);
  printf("\n2 x 2 id tensor + 1's sum\n");
  print_tensor(tensor_sum(tenFive),delimiters,10);
  printf("\n2 x 2 id tensor + 1's product\n");
  print_tensor(tensor_product(tenFive),delimiters,10);

  return 0;
}
