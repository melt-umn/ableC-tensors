#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  Tensor tenOne = [[ 32, 1234, 2, 645, -6 ]];

  Tensor tenTwo = [[ [[ 32, 1234, 2, 645 ]], [[ -6, 24, 2341, -3123 ]], [[ -53, 123, -432, -56 ]] ]];

  Tensor tenThree = [[ [[ [[  1, 2, 3 ]], [[  4, 5, 6 ]], [[  7, 8, 9 ]] ]],
					   [[ [[ 10,11,12 ]], [[ 13,14,15 ]], [[ 16,17,18 ]] ]] ,
                       [[ [[ 19,20,21 ]], [[ 22,23,24 ]], [[ 25,26,27 ]] ]] ]];

  Tensor tenOneAccessed = <.>tenOne<(<(*)>)>; // test star
  Tensor tenOneAccessedExt = <.>tenOne<(<(*,-,*)>)>; //test star to star, this one looks like a vampire
  Tensor tenTwoAccessed = <.>tenTwo<(<(0,-,1)>,<(*,-,1)>)>; //test number to number, star to num
  Tensor tenThreeAccessed = <.>tenThree<(<( 0 )> , <( 0 )> , <( 0 )>)>; //test single number

  if (tenOneAccessed != tenOne) {
    return 1;
  }

  if (tenOneAccessedExt != tenOne) {
    return 1;
  }

  Tensor tenCompareTwo = [[ [[ 32, 1234 ]] , [[ -6, 24 ]] ]];

  if (tenTwoAccessed != tenCompareTwo) {
    return 1;
  }

  Tensor tenCompareThree = [[ [[ [[ 1 ]] ]] ]];

  if (tenThreeAccessed != tenCompareThree) {
    return 1;
  }


  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);

  freeT(tenOneAccessed);
  freeT(tenOneAccessedExt);
  freeT(tenTwoAccessed);
  freeT(tenThreeAccessed);

  freeT(tenCompareTwo);
  freeT(tenCompareThree);

  return 0;
}
