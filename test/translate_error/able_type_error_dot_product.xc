#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//silver error if function, such as dot product, takes two wrong types
//(such as float)
int main() {
  float floatOne = 100;
  float floatTwo = 230;

  Tensor tenOne = floatOne .* floatTwo;

  //freeing but it isn't necessary b/c will crash
  freeT(tenOne);

  return 0;
}
