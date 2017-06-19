#include "../src/tensorsLib.c"

//tests different functions written with copy
int main (int argc, char **argv) {

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
  Tensor tenFive = create_identity_tensor(2,2);

  printf("9 2 tensor: \n");
  print_tensor(tenOne,delimiters,10);
  printf("\n");

  printf("9 2 tensor squared\n");
  print_tensor(square(copy_tensor(tenOne)),delimiters,10);
  printf("\n");

  printf("9 2 tensor: \n");
  print_tensor(tenOne,delimiters,10);
  printf("\n\n\n");

  printf("3 x 9 666 tensor: \n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n");

  printf("3 x 9 666 tensor squared\n");
  print_tensor(square(copy_tensor(tenTwo)),delimiters,10);
  printf("\n");

  printf("3 x 9 666 tensor: \n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n\n\n");

  printf("2 x 3 x 4 100 tensor: \n");
  print_tensor(tenThree,delimiters,10);
  printf("\n");

  printf("2 x 3 x 4 100 tensor squared\n");
  print_tensor(square(copy_tensor(tenThree)),delimiters,10);
  printf("\n");

  printf("2 x 3 x 4 100 tensor: \n");
  print_tensor(tenThree,delimiters,10);
  printf("\n\n\n");

  printf("0 dim 1 tensor 1: \n");
  print_tensor(tenFour,delimiters,10);
  printf("\n");

  printf("\n0 dim 1 tensor squared\n");
  print_tensor(square(copy_tensor(tenFour)),delimiters,10);
  printf("\n");

  printf("0 dim 1 tensor 1: \n");
  print_tensor(tenFour,delimiters,10);
  printf("\n\n\n");

  printf("2 x 2 identity tensor\n");
  print_tensor(tenFive,delimiters,10);
  printf("\n");

  printf("2 x 2 identity tensor squared\n");
  print_tensor(square(copy_tensor(tenFive)),delimiters,10);
  printf("\n");

  printf("2 x 2 identity tensor\n");
  print_tensor(tenFive,delimiters,10);
  printf("\n");

  return 0;
}
