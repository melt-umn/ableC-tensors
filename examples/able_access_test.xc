#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
  int dimOne = 1;
  int *dimSizeOne = malloc(sizeof(int)); //1
  dimSizeOne[0] = 5;
  int countOne = 5;
  float *dataOne = malloc(sizeof(float)*countOne);
  dataOne[0] = 32;
  dataOne[1] = 1234;
  dataOne[2] = 2;
  dataOne[3] = 645;
  dataOne[4] = -6;
  Tensor tenOne = create(dimOne,dimSizeOne,countOne,dataOne);

  Interval interOne = <. 1 - 3 .>;
  Interval *interList = malloc(sizeof(Interval));
  interList[0] = interOne;

  int dimTwo = 2;
  int *dimSizeTwo = malloc(sizeof(int)*2); //2
  dimSizeTwo[0] = 3;
  dimSizeTwo[1] = 4;
  int countTwo = 12;
  float *dataTwo = malloc(sizeof(int)*countTwo);
  dataTwo[0] = 32;
  dataTwo[1] = 1234;
  dataTwo[2] = 2;
  dataTwo[3] = 645;
  dataTwo[4] = -6;
  dataTwo[5] = 23;
  dataTwo[6] = 2341;
  dataTwo[7] = -3123;
  dataTwo[8] = -53;
  dataTwo[9] = 123;
  dataTwo[10] = -432;
  dataTwo[11] = -56;
  Tensor tenTwo = create(dimTwo,dimSizeTwo,countTwo,dataTwo);

  int *intListTwo = malloc(sizeof(int)*2);
  intListTwo[0] = 1;
  intListTwo[1] = 0;

  Interval interTwo = <. 0 - 1 .>;
  Interval interThree = <. 0 - 1 .>;
  Interval *interListTwo = malloc(sizeof(Interval)*2);
  interListTwo[0] = interTwo;
  interListTwo[1] = interThree;

  int dimThree = 3;
  int *dimSizeThree = malloc(sizeof(int)*3); //2
  dimSizeThree[0] = 3;
  dimSizeThree[1] = 3;
  dimSizeThree[2] = 3;
  int countThree = 27;
  float *dataThree = malloc(sizeof(float)*countThree);
  for (int i = 1; i <= countThree; i++) {
    dataThree[i-1] = i;
  }
  Tensor tenThree = create(dimThree,dimSizeThree,countThree,dataThree);

  Interval interFour = <. 0 - 1 .>;
  Interval interFive = <. 1 - 2 .>;
  Interval interSix = <. 1 - 2 .>;
  Interval *interListThree = malloc(sizeof(Interval)*3);
  interListThree[0] = interFour;
  interListThree[1] = interFive;
  interListThree[2] = interSix;

	printf("original tensor:\n");
  printT(tenOne);
  printf("\n\n");
  printf("accessing from 1 - 3 (should be 1234, 2, 645)\n");
	printT(access_tensor(tenOne,interList));
  printf("\n\n");

  printf("original tensor:\n");
  printT(tenTwo);
  printf("\n\n");
  printf("accessing from 0 - 1, 0 - 1 (should be 32, 1234 // -6, 23)\n");
	printT(access_tensor(tenTwo,interListTwo));
  printf("\n\n");

  printf("original tensor:\n");
  printT(tenThree);
  printf("\n\n");
  printf("accessing from [0-1][1-2][1-2](should be 5 6 8 9 14 15 17 18)\n");
  printT(access_tensor(tenThree,interListThree));
  printf("\n\n");

	return 0;
}
