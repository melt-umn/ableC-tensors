#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
  int dimOne = 1;
  int *dimSizeOne = malloc(sizeof(int)); //1
  dimSizeOne[0] = 5;
  int countOne = 5;
  int *dataOne = malloc(sizeof(int)*countOne);
  dataOne[0] = 32;
  dataOne[1] = 1234;
  dataOne[2] = 2;
  dataOne[3] = 645;
  dataOne[4] = -6;
  Tensor tenOne = create_tensor(dimOne,dimSizeOne,countOne,dataOne);

  Interval interOne;
  interOne.lBound = 1;
  interOne.rBound = 3;
  Interval *interList = malloc(sizeof(Interval));
  interList[0] = interOne;

  int dimTwo = 2;
  int *dimSizeTwo = malloc(sizeof(int)*2); //2
  dimSizeTwo[0] = 3;
  dimSizeTwo[1] = 3;
  int countTwo = 9;
  int *dataTwo = malloc(sizeof(int)*countTwo);
  dataTwo[0] = 32;
  dataTwo[1] = 1234;
  dataTwo[2] = 2;
  dataTwo[3] = 645;
  dataTwo[4] = -6;
  dataTwo[5] = 23;
  dataTwo[6] = 2341;
  dataTwo[7] = -3123;
  dataTwo[8] = -53;
  Tensor tenTwo = create_tensor(dimTwo,dimSizeTwo,countTwo,dataTwo);

  Interval interTwo;
  interTwo.lBound = 0;
  interTwo.rBound = 1;
  Interval interThree;
  interThree.lBound = 0;
  interThree.rBound = 1;
  Interval *interListTwo = malloc(sizeof(Interval)*2);
  interListTwo[0] = interTwo;
  interListTwo[1] = interThree;

	printf("original tensor:\n");
  print_tensor(tenOne,delimiters,10);
  printf("\n\n");
  printf("accessing from 1 - 3 (should be 1234, 2, 645)\n");
	print_tensor(access_tensor_vtwo(tenOne,interList),delimiters,10);
  printf("\n\n");

  printf("original tensor:\n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n\n");
  printf("accessing from 0 - 1, 0 - 1 (should be 32, 1234 // 645, -6)\n");
	print_tensor(access_tensor_vtwo(tenTwo,interListTwo),delimiters,10);
  printf("\n\n");

	return 0;
}
