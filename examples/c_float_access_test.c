#include "../src/tensorsLib.c"
#include <stdio.h>
#include <stdlib.h>

//works for getting a single index out of a tensor
int main() {
  int dimOne = 1;
  int *dimSizeOne = malloc(sizeof(int)); //1
  dimSizeOne[0] = 5;
  int countOne = 5;
  float *dataOne = malloc(sizeof(int)*countOne);
  dataOne[0] = 32;
  dataOne[1] = 1234;
  dataOne[2] = 2;
  dataOne[3] = 645;
  dataOne[4] = -6;
  Tensor tenOne = create_tensor(dimOne,dimSizeOne,countOne,dataOne);

  int *intList = malloc(sizeof(int));
  intList[0] = 0;

  int dimTwo = 2;
  int *dimSizeTwo = malloc(sizeof(int)*2); //2
  dimSizeTwo[0] = 3;
  dimSizeTwo[1] = 3;
  int countTwo = 9;
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
  Tensor tenTwo = create_tensor(dimTwo,dimSizeTwo,countTwo,dataTwo);



  int *intListTwo = malloc(sizeof(int)*2);
  intListTwo[0] = 2;
  intListTwo[1] = 2;

  int dimThree = 3;
  int *dimSizeThree = malloc(sizeof(int)*3); //3
  dimSizeThree[0] = 2;
  dimSizeThree[1] = 3;
  dimSizeThree[2] = 4;
  int countThree = 24;
  float *dataThree = malloc(sizeof(int)*countThree);
  for (int i = 1; i <= countThree; i++) {
    dataThree[i-1] = i;
  }
  Tensor tenThree = create_tensor(dimThree,dimSizeThree,countThree,dataThree);

  int *intListThree = malloc(sizeof(int)*3);
  intListThree[0] = 0;
  intListThree[1] = 1;
  intListThree[2] = 2;


	printf("original tensor:\n");
  print_tensor(tenOne,delimiters,10);
  printf("\n\n");
  printf("accessing [0] (should be 32)\n");
	printf("%f\n",float_access_tensor(tenOne,intList));
  printf("\n\n");

  printf("original tensor:\n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n\n");
  printf("accessing [2][2] (should be -53)\n");
  printf("%f\n",float_access_tensor(tenTwo,intListTwo));
  printf("\n\n");

  printf("original tensor:\n");
  print_tensor(tenThree,delimiters,10);
  printf("\n\n");
  printf("accessing from [0][1][2] (should be 7))\n");
  printf("%f\n",float_access_tensor(tenThree,intListThree));
  printf("\n\n");

	return 0;
}
