#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//creating and comparing tensors for equality
int main () {

  Tensor tenZero = [[ 666 ]];
  Tensor tenOne = [[ [[ 666 ]] ]];
  Tensor tenTwo = [[ 22, 32 ]];
  Tensor tenThree = [[ 22, 32, 42 ]];
  Tensor tenFour = [[ [[ 22 ]], [[ 32 ]] ]];
  Tensor tenFive = [[ [[ 666, 222 ]] ]];
  Tensor tenSix = [[ [[ 32,1234,2 ]],[[ 645,-6,43 ]],[[ -4345,13,0 ]] ]];
  Tensor tenSeven = [[ [[ [[ 1,2,3 ]],[[ 4,5,6 ]] ]],[[ [[ 7,8,9 ]],[[ 10,11,12 ]] ]] ]];
  Tensor tenEight = [[ [[ [[ 1,2,3 ]],[[ 4,5,6 ]] ]],[[ [[ 7,8,9 ]],[[ 10,11,12 ]] ]] ]];

  //tensor should be equal to copy of itself
  if (tenZero != copy(tenZero)) {
    return 1;
  }
  //identical tenors should be equal
  if (tenSeven != tenEight) {
    return 1;
  }
  //tensor should be equal to itself
  if (tenSix != tenSix) {
    return 1;
  }
  //tensors with same data but diff dimensions should not be equal
  if (tenZero == tenOne) {
    return 1;
  }
  if (tenTwo == tenFour) {
    return 1;
  }
  //two random tensors should not be equal
  if (tenThree == tenFive) {
    return 1;
  }

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);
  freeT(tenFive);
  freeT(tenSix);
  freeT(tenSeven);
  freeT(tenEight);

  return 0;
}
