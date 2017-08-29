#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with map
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

  Tensor tenOne = fill(1,dataTestOne,2);
  Tensor tenTwo = fill(2,dataTestTwo,666);
  Tensor tenThree = fill(3,dataTestThree,100);
  Tensor tenFour = fill(0,dataTestFour,1);
  Tensor tenFive = id(2,2);

  Tensor tenOneIncr = fill(1,dataTestOne,3);
  Tensor tenOneSquare = fill(1,dataTestOne,9);
  Tensor tenOneNeg = fill(1,dataTestOne,-9);

  Tensor tenTwoIncr = fill(2,dataTestTwo,667);
  Tensor tenTwoSquare = fill(2,dataTestTwo,444889);
  Tensor tenTwoNeg = fill(2,dataTestTwo,-444889);

  Tensor tenThreeIncr = fill(3,dataTestThree,101);
  Tensor tenThreeSquare = fill(3,dataTestThree,10201);
  Tensor tenThreeNeg = fill(3,dataTestThree,-10201);

  Tensor tenFourIncr = fill(0,dataTestFour,2);
  Tensor tenFourSquare = fill(0,dataTestFour,4);
  Tensor tenFourNeg = fill(0,dataTestFour,-4);

  Tensor tenFiveIncr = [[ [[ 2, 1 ]] , [[ 1, 2]] ]];
  Tensor tenFiveSquare = [[ [[ 4, 1 ]] , [[ 1, 4]] ]];
  Tensor tenFiveNeg = [[ [[ -4, -1 ]] , [[ -1, -4]] ]];

  if (tenOneIncr != incr(tenOne)) {
    return 1;
  }
  if (tenOneSquare != square(tenOne)) {
    return 1;
  }
  if (tenOneNeg != -tenOne) {
    return 1;
  }

  if (tenTwoIncr != incr(tenTwo)) {
    return 1;
  }
  if (tenTwoSquare != square(tenTwo)) {
    return 1;
  }
  if (tenTwoNeg != -tenTwo) {
    return 1;
  }

  if (tenThreeIncr != incr(tenThree)) {
    return 1;
  }
  if (tenThreeSquare != square(tenThree)) {
    return 1;
  }
  if (tenThreeNeg != -tenThree) {
    return 1;
  }

  if (tenFourIncr != incr(tenFour)) {
    return 1;
  }
  if (tenFourSquare != square(tenFour)) {
    return 1;
  }
  if (tenFourNeg != -tenFour) {
    return 1;
  }

  if (tenFiveIncr != incr(tenFive)) {
    return 1;
  }
  if (tenFiveSquare != square(tenFive)) {
    return 1;
  }
  if (tenFiveNeg != -tenFive) {
    return 1;
  }

  //notice that freeT is only called on the first tensor of each kind
  //this is because freeT frees the dim_size, which, in this document, is
  //dataTest___ (dataTestOne, for example). Because the Incr, Square and Negate
  //version of each tensor includes the same dim_size in memory, once one tensor
  //with the dim_size is freed, no others with the same one can be freed

  freeT(tenOne);
  free(tenOneIncr.data);
  free(tenOneSquare.data);
  free(tenOneNeg.data);
  freeT(tenTwo);
  free(tenTwoIncr.data);
  free(tenTwoSquare.data);
  free(tenTwoNeg.data);
  freeT(tenThree);
  free(tenThreeIncr.data);
  free(tenThreeSquare.data);
  free(tenThreeNeg.data);
  freeT(tenFour);
  free(tenFourIncr.data);
  free(tenFourSquare.data);
  free(tenFourNeg.data);
  freeT(tenFive);
  free(tenFiveIncr.data);
  free(tenFiveSquare.data);
  free(tenFiveNeg.data);

  return 0;
}
