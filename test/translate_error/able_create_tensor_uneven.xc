#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//syntax error if matching dimensions of Tensor do not match with each other
int main() {
  Tensor tenOne = [[ [[ 32, 33, 34 ]] , [[ 1 ]] ]];
  //3 elements in first part, only 1 in second part

  //freeing but it isn't necessary b/c will crash
  freeT(tenOne);

  return 0;
}
