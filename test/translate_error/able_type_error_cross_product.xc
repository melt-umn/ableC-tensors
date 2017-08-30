#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//silver error if any function takes the wrong type, such as dot product
//taking a float and a Tensor
int main() {
  float floatOne = 100;
  Tensor tenOne = [[ 1, 2, 3 ]];

  Tensor tenTwo = floatOne x* tenOne;

  //freeing but it isn't necessary b/c will crash
  freeT(tenOne);
  freeT(tenTwo);

  return 0;
}
