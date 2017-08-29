#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//create manual tensors boop boop
int main () {
  Tensor tenOne = [[ [[ 9, 10, 21 ]], [[ 32, 53, 12 ]], [[ 43, 4, 10 ]] ]];
  Tensor tenTwo = [[ [[ 12, 43, 65, 34, 23 ]], [[ 6, 7, 2, 45, 20 ]], [[ 40, 21, 65, 7, 69 ]] ]];
  Tensor tenThree = [[ [[ 1, 3, 6, 2 ]], [[ 12, 64, 29, 5 ]], [[ 39, 492, 42, 45 ]], [[ 65, 23, 56, 23 ]], [[ 12, 45, 12, 34 ]] ]];
  Tensor tenFour = [[ [[ 666, 555 ]], [[ 444, 333 ]], [[ 222, 111 ]], [[ 45, 2 ]] ]];

  Tensor tenOneTwo = [[ [[ 1008,	898,	1970,	903,	1856 ]],
                        [[ 1182,	1999,	2966,	3557,	2624]],
                        [[ 940,	2087,	3453,	1712,ß	1759]] ]];
  Tensor tenTwoThree = [[ [[ 5549,	36585,	6229,	4728 ]],
                          [[	3333,	3385,	3083,	1852 ]] ,
                          [[ 4110,	36710,	4799,	5617]] ]]
  Tensor tenThreeFour = [[ [[ 3420,	2224 ]],
	                         [[ 43071,	31201 ]],
	                         [[ 255771,	190233 ]],
	                         [[ 66969,	49996 ]],
	                         [[ 32166,	23045 ]] ]]

  if (tenOne ** tenTwo != tenOneTwo) {
    return 1;
  }
  if (tenTwo ** tenThree != tenTwoThree) {
    return 1;
  }
  if (tenThree ** tenFour != tenThreeFour) {
    return 1;
  }

  freeT(tenOne);
  freeT(tenTwo);
  freeT(tenThree);
  freeT(tenFour);
  freeT(tenOneTwo);
  freeT(tenTwoThree);
  freeT(tenThreeFour);

  return 0;
}
