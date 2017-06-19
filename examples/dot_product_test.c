#include "../src/tensorsLib.c"

//tests different functions written with tensor_combine
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

  Tensor tenOneF = fill_tensor(1,dataTestOne,2);
  Tensor tenOneS = fill_tensor(1,dataTestOne,5);

  Tensor tenTwoF = fill_tensor(2,dataTestTwo,666);
  Tensor tenTwoS = fill_tensor(2,dataTestTwo,1);

  Tensor tenThreeF = fill_tensor(3,dataTestThree,100);
  Tensor tenThreeS = fill_tensor(3,dataTestThree,101);

  Tensor tenFourF = fill_tensor(0,dataTestFour,1);
  Tensor tenFourS = fill_tensor(0,dataTestFour,9);

  printf("1 dim 2's tensor .* 1 dim 5's tensor (Tensor):\n");
  print_tensor(dot_product(tenOneF,tenOneS),delimiters,10);
  printf("\n(Int): ");
  printf("%d",int_dot_product(tenOneF,tenOneS));
  printf("\n(Shortcut int): ");
  printf("%d",int_dot_product_vtwo(tenOneF,tenOneS));
  printf("\n\n\n");

  printf("2 dim 666's tensor .* 2 dim 1's tensor (Tensor):\n");
  print_tensor(dot_product(tenTwoF,tenTwoS),delimiters,10);
  printf("\n(Int): ");
  printf("%d",int_dot_product(tenTwoF,tenTwoS));
  printf("\n(Shortcut int): ");
  printf("%d",int_dot_product_vtwo(tenTwoF,tenTwoS));
  printf("\n\n\n");

  printf("3 dim 100's tensor .* 3 dim 101's tensor (Tensor):\n");
  print_tensor(dot_product(tenThreeF,tenThreeS),delimiters,10);
  printf("\n(Int): ");
  printf("%d",int_dot_product(tenThreeF,tenThreeS));
  printf("\n(Shortcut int): ");
  printf("%d",int_dot_product_vtwo(tenThreeF,tenThreeS));
  printf("\n\n\n");

  printf("0 dim 1's tensor .* 0 dim 9's tensor (Tensor):\n");
  print_tensor(dot_product(tenFourF,tenFourS),delimiters,10);
  printf("\n(Int): ");
  printf("%d",int_dot_product(tenFourF,tenFourS));
  printf("\n(Shortcut int): ");
  printf("%d",int_dot_product_vtwo(tenFourF,tenFourS));
  printf("\n");
  return 0;
}
