#include "../src/tensorsLib.c"

//create manual tensors boop boop
int main (int argc, char **argv) {
  int i;

  int dimZero = 0;
  int dimOne = 1;
  int dimTwo = 2;
  int dimThree = 3;

  int *dimSizeZero = NULL;

  int *dimSizeOne = malloc(sizeof(int)); //1
  dimSizeOne[0] = 1;

  int *dimSizeTwo = malloc(sizeof(int)*2); //3 x 3
  dimSizeTwo[0] = 3;
  dimSizeTwo[1] = 3;

  int *dimSizeThree = malloc(sizeof(int)*3); //4 x 5 x 3
  dimSizeThree[0] = 2;
  dimSizeThree[1] = 3;
  dimSizeThree[2] = 3;

  int countZero = 1;
  int countOne = 1;
  int countTwo = 9;
  int countThree = 18;

  int *dataZero = malloc(sizeof(int));
  dataZero[0] = 666;

  int *dataOne = malloc(sizeof(int));
  dataOne[0] = 22;

  int *dataTwo = malloc(sizeof(int)*countTwo);
  dataTwo[0] = 32;
  dataTwo[1] = 1234;
  dataTwo[2] = 2;
  dataTwo[3] = 645;
  dataTwo[4] = -6;
  dataTwo[5] = 43;
  dataTwo[6] = -4345;
  dataTwo[7] = 13;
  dataTwo[8] = 0;

  int *dataThree = malloc(sizeof(int)*countThree);
  for (i = 0; i < countThree; i++) {
    dataThree[i] = i;
  }


  Tensor tenZero = create_tensor(dimZero,dimSizeZero,countZero,dataZero);
  Tensor tenOne = create_tensor(dimOne,dimSizeOne,countOne,dataOne);
  Tensor tenTwo = create_tensor(dimTwo,dimSizeTwo,countTwo,dataTwo);
  Tensor tenThree = create_tensor(dimThree,dimSizeThree,countThree,dataThree);

  printf("tenZero is: \n");
  print_tensor(tenZero,delimiters,10);
  printf("\n\n\n");

  printf("tenOne is: \n");
  print_tensor(tenOne,delimiters,10);
  printf("\n\n\n");

  printf("tenTwo is: \n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n\n\n");

  printf("tenThree is: \n");
  print_tensor(tenThree,delimiters,10);
  printf("\n\n\n");

}
