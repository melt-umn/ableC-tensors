#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  Tensor tenOne = [. 32, 1234, 2, 645, -6 .];

  Tensor tenTwo = [. [. 32, 1234, 2, 645 .], [. -6, 24, 2341, -3123 .], [. -53, 123, -432, -56 .] .]; 

  Tensor tenThree = [. [. [.  1, 2, 3 .], [.  4, 5, 6 .], [.  7, 8, 9 .] .],
					   [. [. 10,11,12 .], [. 13,14,15 .], [. 16,17,18 .] .] ,
                       [. [. 19,20,21 .], [. 22,23,24 .], [. 25,26,27 .] .] .];

  Interval interOne = <. * .>;
  Interval *interList = malloc(sizeof(Interval));
  interList[0] = interOne;

  Interval interTwo = <. 0 .-. 1 .>;
  Interval interThree = <. * .-. 1 .>;
  Interval *interListTwo = malloc(sizeof(Interval)*2);
  interListTwo[0] = interTwo;
  interListTwo[1] = interThree;

  Interval interFour = <. 0 .-. 1 .>;
  Interval interFive = <. 1 .-. 2 .>;
  Interval interSix = <. 1 .-. * .>;
  Interval *interListThree = malloc(sizeof(Interval)*3);
  interListThree[0] = interFour;
  interListThree[1] = interFive;
  interListThree[2] = interSix;


  printf("original tensor:\n");
  printT(tenOne);
  printf("\n\n");
  printf("accessing from 0 - 4 (should be 32, 1234, 2, 645, -6)\n");
  printT(tenOne<.>interList);
  printf("\n\n");

  printf("original tensor:\n");
  printT(tenTwo);
  printf("\n\n");
  printf("accessing from 0 - 1, 0 - 1 (should be 32, 1234 // -6, 23)\n");
  printT(tenTwo<.>interListTwo);
  printf("\n\n");

  printf("original tensor:\n");
  printT(tenThree);
  printf("\n\n");
  printf("accessing from [0-1][1-2][1-2](should be 5 6 8 9 14 15 17 18)\n");
  printT(tenThree<.>interListThree);
  printf("\n\n");

  return 0;
}
