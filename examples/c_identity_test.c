#include "tensorsLib.h"

//tests the normal identity function
//ankit, can you add the asymmetric identity function is as a test please?
int main (int argc, char **argv) {
  Tensor idOne = create_identity_tensor(2,3);
  printf("3 x 3 identity tensor is: \n");
  print_tensor(idOne,delimiters,10);
  printf("\n");

  Tensor idTwo = create_identity_tensor(2,10);
  printf("10 x 10 identity tensor is: \n");
  print_tensor(idTwo,delimiters,10);
  printf("\n");

  //broken
  Tensor idThree = create_identity_tensor(3,5);
  printf("5 x 5 x 5 identity tensor is: \n");
  print_tensor(idThree,delimiters,10);
  printf("\n");

  //broken
  Tensor idFour = create_identity_tensor(5,3);
  printf("3 x 3 x 3 x 3 x 3 identity tensor is: \n");
  print_tensor(idFour,delimiters,10);

  return 0;
}
