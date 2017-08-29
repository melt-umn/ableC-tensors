#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests different functions written with tensor_combine
int main () {
  Tensor tenZero = [[ 666, 662, 35 ]];
  Tensor tenOne = [[ 22, 1234, 2 ]];
  Tensor tenTwo = [[ 32, 543, 65 ]];


  //there's a slight rounding error with the triple product formula
  Tensor tenZeroOneTwoScalar = [[ 50828320 ]]; //should be 50828322
  Tensor tenOneZeroTwoScalar = [[ -50828324 ]]; //" " -50828322
  Tensor tenTwoZeroOneScalar = [[ 50828320 ]]; //" " 50828322

  float tenZeroOneTwoFloat = 50828320; //same as above ^
  float tenOneZeroTwoFloat = -50828324; //" "
  float tenTwoZeroOneFloat = 50828320; //" "

  Tensor tenZeroOneTwoVector = [[ -18184994, 21112312, -53289844 ]];
  Tensor tenOneZeroTwoVector = [[ 420204576, -7441938, -30574590 ]];
  Tensor tenTwoZeroOneVector = [[ 438389568, -28554250, 22715254 ]];

  if (tenZeroOneTwoScalar != scalar_triple_product(tenZero,tenOne,tenTwo)) {
    return 1;
  }
  if (tenOneZeroTwoScalar != scalar_triple_product(tenOne,tenZero,tenTwo)) {
    return 1;
  }
  if (tenTwoZeroOneScalar != scalar_triple_product(tenTwo,tenZero,tenOne)) {
    return 1;
  }

  if (tenZeroOneTwoFloat != float_triple_product(tenZero,tenOne,tenTwo)) {
    return 1;
  }
  if (tenOneZeroTwoFloat != float_triple_product(tenOne,tenZero,tenTwo)) {
    return 1;
  }
  if (tenTwoZeroOneFloat != float_triple_product(tenTwo,tenZero,tenOne)) {
    return 1;
  } 

  if (tenZeroOneTwoVector != vector_triple_product(tenZero,tenOne,tenTwo)) {
    return 1;
  }
  if (tenOneZeroTwoVector != vector_triple_product(tenOne,tenZero,tenTwo)) {
    return 1;
  }
  if (tenTwoZeroOneVector != vector_triple_product(tenTwo,tenZero,tenOne)) {
    return 1;
  }

  freeT(tenZero);
  freeT(tenOne);
  freeT(tenTwo);

  freeT(tenZeroOneTwoScalar);
  freeT(tenOneZeroTwoScalar);
  freeT(tenTwoZeroOneScalar);

  freeT(tenZeroOneTwoVector);
  freeT(tenOneZeroTwoVector);
  freeT(tenTwoZeroOneVector);

  return 0;
}
