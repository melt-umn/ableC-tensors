#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//silver error if function, such as float dot product, takes one wrong type
//(Tensor and float)
int main() {
  Tensor tenOne = [[1, 2, 3]];
  float floatTwo = 230;

  float tenTwo = floatOne f.* floatTwo;

  //freeing but it isn't necessary b/c will crash
  freeT(tenOne);
  freeT(tenTwo);

  return 0;
}
