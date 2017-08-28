#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {
  Tensor idOne = id(2,3);
  Tensor fillOne = [[ [[ 1, 0, 0]], [[ 0, 1, 0 ]], [[ 0, 0, 1]] ]];

  Tensor idTwo = id(1,1);
  Tensor fillTwo = [[ 1 ]];

  Tensor idThree = id(3,3);
  Tensor fillThree = [[ [[ [[ 0, 0, 0]], [[ 0, 0, 0 ]], [[ 0, 0, 0 ]] ]],
                        [[ [[ 0, 0, 0]], [[ 0, 0, 0 ]], [[ 0, 0, 0 ]] ]],
                        [[ [[ 0, 0, 0]], [[ 0, 0, 0 ]], [[ 0, 0, 0 ]] ]] ]];


  if (idOne != fillOne) {
    return 1;
  }

  if (idTwo != fillTwo) {
    return 1;
  }

  if (idThree != fillThree) {
    printT(idThree);
    return 1;
  }

  freeT(idOne);
  freeT(fillOne);
  freeT(idTwo);
  freeT(fillTwo);
  freeT(idThree);
  freeT(fillThree);

  return 0;
}
