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

  printf("original tensor:\n");
  printT(tenOne);
  printf("\n\n");
  printf("accessing from 0 - 4 (should be 32, 1234, 2, 645, -6)\n");


  printT(<.> tenOne<( <( * )> )>);
  printf("\n\n");

  printf("original tensor:\n");
  printT(tenTwo);
  printf("\n\n");
  printf("accessing from 0 - 1, 0 - 1 (should be 32, 1234 // -6, 24)\n");
  printT(<.>tenTwo<( <( 0 ,-, 1 )> , <( * ,-, 1 )> )>);
  printf("\n\n");

  printf("original tensor:\n");
  printT(tenThree);
  printf("\n\n");
  printf("accessing from [0-1][1-2][1-2](should be 5 6 8 9 14 15 17 18)\n");
  printT(<.>tenThree<( <( 0 ,-, 1 )> , <( 1 ,-, 2 )> , <( 1 ,-, * )> )>);
  printf("\n\n");

  return 0;
}
