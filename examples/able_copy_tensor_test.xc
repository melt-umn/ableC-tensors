#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with copy
int main () {

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

  Tensor tenOneSquared;
  Tensor tenTwoSquared;
  Tensor tenThreeSquared;
  Tensor tenFourSquared;

  Tensor tenOne = fill(1,dataTestOne,2);
  Tensor tenOneOrig = fill(1,dataTestOne,2);

  Tensor tenTwo = fill(2,dataTestTwo,666);
  Tensor tenTwoOrig = fill(2,dataTestTwo,666);

  Tensor tenThree = fill(3,dataTestThree,100);
  Tensor tenThreeOrig = fill(3,dataTestThree,100);

  Tensor tenFour = fill(0,dataTestFour,2);
  Tensor tenFourOrig = fill(0,dataTestFour,2);

  //each test will make sure the original tensor is not modified after having
  //a copy of it squared (tests will result in a tensor that is different than
  //the original in value when squared)

  //don't need to save to a value, but doing just so they can be freed
  tenOneSquared = square(copy(tenOne));
  tenTwoSquared = square(copy(tenTwo));
  tenThreeSquared = square(copy(tenThree));
  tenFourSquared = square(copy(tenFour));

  if (tenOne != tenOneOrig) {
    return 1;
  }

  if (tenTwo != tenTwoOrig) {
    return 1;
  }

  if (tenThree != tenThreeOrig) {
    return 1;
  }

  if (tenFour != tenFourOrig) {
    return 1;
  }

  freeT(tenOne);
  free(tenOneOrig.data); //ten___Orig uses same dim_size as ten___, therefore can't cal freeT on it
  freeT(tenOneSquared);

  freeT(tenTwo);
  free(tenTwoOrig.data);
  freeT(tenTwoSquared);

  freeT(tenThree);
  free(tenThreeOrig.data);
  freeT(tenThreeSquared);

  freeT(tenFour);
  free(tenFourOrig.data);
  freeT(tenFourSquared);

  return 0;
}
