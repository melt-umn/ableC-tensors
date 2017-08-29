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
  Tensor tenOneSquare = fill(1,dataTestOne,4);

  Tensor tenTwoIncr = fill(2,dataTestTwo,667);
  Tensor tenTwoSquare = fill(2,dataTestTwo,443556);

  Tensor tenThreeIncr = fill(3,dataTestThree,101);
  Tensor tenThreeSquare = fill(3,dataTestThree,10000);

  Tensor tenFourIncr = fill(0,dataTestFour,2);
  Tensor tenFourSquare = fill(0,dataTestFour,1);

  Tensor tenFiveIncr = [[ [[ 2, 1 ]] , [[ 1, 2]] ]];
  Tensor tenFiveSquare = [[ [[ 1, 0 ]] , [[ 0, 1]] ]];

  if (tenOneIncr != incr(tenOne)) {
    return 1;
  }
  if (tenOneSquare != square(tenOne)) {
    return 1;
  }

  if (tenTwoIncr != incr(tenTwo)) {
    return 1;
  }
  if (tenTwoSquare != square(tenTwo)) {
    return 1;
  }

  if (tenThreeIncr != incr(tenThree)) {
    return 1;
  }
  if (tenThreeSquare != square(tenThree)) {
    return 1;
  }

  if (tenFourIncr != incr(tenFour)) {
    return 1;
  }
  if (tenFourSquare != square(tenFour)) {
    return 1;
  }

  if (tenFiveIncr != incr(tenFive)) {
    return 1;
  }
  if (tenFiveSquare != square(tenFive)) {
    return 1;
  }

  freeT(tenOne);
  freeT(tenOneIncr);
  freeT(tenOneSquare);
  freeT(tenTwo);
  freeT(tenTwoIncr);
  freeT(tenTwoSquare);
  freeT(tenThree);
  freeT(tenThreeIncr);
  freeT(tenThreeSquare);
  freeT(tenFour);
  freeT(tenFourIncr);
  freeT(tenFourSquare);
  freeT(tenFive);
  freeT(tenFiveIncr);
  freeT(tenFiveSquare);

  return 0;
}
