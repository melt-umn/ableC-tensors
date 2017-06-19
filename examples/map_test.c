#include "../src/tensorsLib.c"

//tests different functions written with map
//-- scalar_add, scalar_subtract, scalar_multiply, scalar_divide, scalar_mod
//also tests one function for tensor_map just to have something :)
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

  printf("9 2 tensor: \n");
  print_tensor(tenOne,delimiters,10);
  printf("\n");

  printf("3 x 9 666 tensor: \n");
  print_tensor(tenTwo,delimiters,10);
  printf("\n");

  printf("2 x 3 x 4 100 tensor: \n");
  print_tensor(tenThree,delimiters,10);
  printf("\n");

  printf("9 2 tensor times 4\n");
  print_tensor(map(scalar_multiply,4,tenOne),delimiters,10);
  printf("\n9 8 tensor divide 2\n");
  print_tensor(map(scalar_divide,2,tenOne),delimiters,10);
  printf("\n9 4 tensor plus 662\n");
  print_tensor(map(scalar_add,662,tenOne),delimiters,10);
  printf("\n9 666 tensor minus 666\n");
  print_tensor(map(scalar_subtract,666,tenOne),delimiters,10);

  printf("\n\n\n");

  printf("3 x 9 666 tensor divide 666\n");
  print_tensor(map(scalar_divide,666,tenTwo),delimiters,10);
  printf("\n3 x 9 1 tensor multiply 3\n");
  print_tensor(map(scalar_multiply,3,tenTwo),delimiters,10);
  printf("\n3 x 9 3 tensor plus 6\n");
  print_tensor(map(scalar_add,6,tenTwo),delimiters,10);
  printf("\n3 x 9 9 tensor minus 10\n");
  print_tensor(map(scalar_subtract,10,tenTwo),delimiters,10);

  printf("\n\n\n");

  printf("2 x 3 x 4 100 tensor mod 8\n");
  print_tensor(map(scalar_mod,8,tenThree),delimiters,10);
  printf("\n2 x 3 x 4 10 tensor multiply 3\n");
  print_tensor(map(scalar_multiply,3,tenThree),delimiters,10);
  printf("\n2 x 3 x 4 30 tensor plus 6\n");
  print_tensor(map(scalar_add,6,tenThree),delimiters,10);
  printf("\n2 x 3 x 4 36 tensor minus 10\n");
  print_tensor(map(scalar_subtract,10,tenThree),delimiters,10);

  printf("\n\n\n");

  printf("0 dim 1 tensor divide 1\n");
  print_tensor(map(scalar_divide,1,tenFour),delimiters,10);
  printf("\n0 dim 1 tensor multiply 3\n");
  print_tensor(map(scalar_multiply,3,tenFour),delimiters,10);
  printf("\n0 dim 3 tensor plus 6\n");
  print_tensor(map(scalar_add,6,tenFour),delimiters,10);
  printf("\n0 dim 9 tensor minus 10\n");
  print_tensor(map(scalar_subtract,10,tenFour),delimiters,10);

  Tensor tenFive = create_identity_tensor(2,2);
  printf("\n2 x 2 identity tensor plus 1\n");
  print_tensor(map(scalar_add,1,tenFive),delimiters,10);
  printf("\n");

  printf("\n2 x 2 identity tensor plus 1 times -1 with tensor_map\n");
  print_tensor(tensor_map(scalar_multiply,tenFour,tenFive),delimiters,10);

  return 0;
}
