#include "../src/tensorsLib.c"

//tests the normal identity function
int main (int argc, char **argv) {
  Tensor idOne = create_identity_tensor(2,3);
  printf("3 x 3 identity array is: \n");
  print_tensor(idOne);
  printf("\n");

  Tensor idTwo = create_identity_tensor(2,10);
  printf("10 x 10 identity array is: \n");
  print_tensor(idTwo);
  printf("\n");

  //broken
  Tensor idThree = create_identity_tensor(3,5);
  printf("5 x 5 x 5 identity array is: \n");
  print_tensor(idThree);
  printf("\n");

  //broken
  Tensor idFour = create_identity_tensor(5,3);
  printf("3 x 3 x 3 x 3 x 3 identity array is: \n");
  print_tensor(idFour);
  printf("\n");
}
