#include "../src/tensorsLib.c"

//tests the normal identity function
int main (int argc, char **argv) {
  int *dataTestOne;
  dataTestOne = malloc(sizeof(int)*1);
  dataTestOne[0] = 1;

  int *dataTestTwo;
  dataTestTwo = malloc(sizeof(int)*1);
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
  print_tensor(fillOne);
  printf("\n");
  printf("0 dim 666 transposed tensor is: \n");
  print_tensor(transpose(fillOne));
  printf("\n\n");


  Tensor fillTwo = fill_tensor(1,dataTestTwo,666);
  printf("3 x 1 666 tensor is: \n");
  print_tensor(fillTwo);
  printf("\n");
  printf("3 x 1 666 transposed tensor is: \n");
  print_tensor(transpose(fillTwo));
  printf("\n\n");

  Tensor fillThree = ones(2,dataTestThree);
  printf("2 x 5 ones tensor is: \n");
  print_tensor(fillThree);
  printf("\n");
  printf("2 x 5 ones transposed tensor is: \n");
  print_tensor(transpose(fillThree));
  printf("\n\n");

  Tensor fillFour = zeros(2,dataTestFour);
  printf("1 x 6 zeros tensor is: \n");
  print_tensor(fillFour);
  printf("\n");
  printf("1 x 6 zeros tranposed tensor is: \n");
  print_tensor(transpose(fillFour));
  printf("\n\n");

  Tensor fillFive = fill_tensor(3,dataTestFive,666);
  printf("3 x 4 x 5 666 tensor is: \n");
  print_tensor(fillFive);
  printf("\n");
  printf("3 x 4 x 5 666 tranposed tensor (should break) is: \n");
  print_tensor(transpose(fillFive));
  printf("\n\n");



}
