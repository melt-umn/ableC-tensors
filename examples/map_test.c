#include "../src/tensorsLib.c"

//yo we gotta write legit test files soon lol
int main (int argc, char **argv) {

  int *dataTestOne = malloc(sizeof(int));
  dataTestOne[0] = 9;

	int *dataTestTwo = malloc(sizeof(int) * 2);
	dataTestTwo[0] = 3;
	dataTestTwo[1] = 3;

  int *dataTestThree = malloc(sizeof(int)*3);
  dataTestThree[0] = 2;
  dataTestThree[1] = 3;
  dataTestThree[2] = 4;

  int *dataTestFour = NULL;

  Tensor tenOne = fill_tensor(1,dataTestOne,2);
  Tensor tenTwo = fill_tensor(2,dataTestTwo,666);
  Tensor tenThree = fill_tensor(3,dataTestThree,100);
  Tensor tenFour = fill_tensor(0,dataTestFour,1);

  printf("9 2 tensor: \n");
  print_tensor(tenOne);
  printf("\n");

  printf("3 x 9 666 tensor: \n");
  print_tensor(tenTwo);
  printf("\n");

  printf("2 x 3 x 4 100 tensor: \n");
  print_tensor(tenThree);
  printf("\n");

  printf("9 2 tensor times 4\n");
  print_tensor(map(scalar_multiply,4,tenOne));
  printf("\n9 8 tensor divide 2\n");
  print_tensor(map(scalar_divide,2,tenOne));
  printf("\n9 4 tensor plus 662\n");
  print_tensor(map(scalar_add,662,tenOne));
  printf("\n9 666 tensor minus 666\n");
  print_tensor(map(scalar_subtract,666,tenOne));

  printf("\n\n\n");

  printf("3 x 9 666 tensor divide 666\n");
  print_tensor(map(scalar_divide,666,tenTwo));
  printf("\n3 x 9 1 tensor multiply 3\n");
  print_tensor(map(scalar_multiply,3,tenTwo));
  printf("\n3 x 9 3 tensor plus 6\n");
  print_tensor(map(scalar_add,6,tenTwo));
  printf("\n3 x 9 9 tensor minus 10\n");
  print_tensor(map(scalar_subtract,10,tenTwo));

  printf("\n\n\n");

  printf("2 x 3 x 4 100 tensor divide 10\n");
  print_tensor(map(scalar_divide,10,tenThree));
  printf("\n2 x 3 x 4 10 tensor multiply 3\n");
  print_tensor(map(scalar_multiply,3,tenThree));
  printf("\n2 x 3 x 4 30 tensor plus 6\n");
  print_tensor(map(scalar_add,6,tenThree));
  printf("\n2 x 3 x 4 36 tensor minus 10\n");
  print_tensor(map(scalar_subtract,10,tenThree));

  printf("\n\n\n");

  printf("0 dim 1 tensor divide 1\n");
  print_tensor(map(scalar_divide,1,tenFour));
  printf("\n0 dim 1 tensor multiply 3\n");
  print_tensor(map(scalar_multiply,3,tenFour));
  printf("\n0 dim 3 tensor plus 6\n");
  print_tensor(map(scalar_add,6,tenFour));
  printf("\n0 dim 9 tensor minus 10\n");
  print_tensor(map(scalar_subtract,10,tenFour));

  Tensor tenFive = create_identity_tensor(2,2);
  printf("\n2 x 2 identity tensor plus 1\n");
  print_tensor(map(scalar_add,1,tenFive));
  printf("\n");
}
