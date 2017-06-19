#include "../src/tensorsLib.c"

//tests basic tensor creations; fill_tensor(),ones(),zeros()
int main (int argc, char **argv) {
  int *dataTestOne;
  dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 1;

  int *dataTestTwo;
  dataTestTwo = malloc(sizeof(int));
  dataTestTwo[0] = 3;

  int *dataTestThree;
  dataTestThree = malloc(sizeof(int)*2);
  dataTestThree[0] = 2;
  dataTestThree[1] = 5;

  int *dataTestFour;
  dataTestFour = malloc(sizeof(int)*2);
  dataTestFour[0] = 1;
  dataTestFour[1] = 6;

  int *dataTestFive;
  dataTestFive = malloc(sizeof(int)*3);
  dataTestFive[0] = 3;
  dataTestFive[1] = 4;
  dataTestFive[2] = 5;

  Tensor fillOne = fill_tensor(0,dataTestOne,666);
  printf("0 dim 666 tensor is: \n");
  print_tensor(fillOne,delimiters,10);
  printf("\n");

  Tensor fillTwo = fill_tensor(1,dataTestTwo,666);
  printf("3 x 1 666 tensor is: \n");
  print_tensor(fillTwo,delimiters,10);
  printf("\n");

  Tensor fillThree = ones(2,dataTestThree);
  printf("2 x 5 ones tensor is: \n");
  print_tensor(fillThree,delimiters,10);
  printf("\n");

  Tensor fillFour = zeros(2,dataTestFour);
  printf("1 x 6 zeros tensor is: \n");
  print_tensor(fillFour,delimiters,10);
  printf("\n");

  Tensor fillFive = fill_tensor(3,dataTestFive,666);
  printf("3 x 4 x 5 666 tensor is: \n");
  print_tensor(fillFive,delimiters,10);
  printf("\n");
}
