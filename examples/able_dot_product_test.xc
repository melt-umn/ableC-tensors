#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//tests dot product

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

  Tensor tenOneF = fill(1,dataTestOne,2);
  Tensor tenOneS = fill(1,dataTestOne,5);

  Tensor tenTwoF = fill(2,dataTestTwo,666);
  Tensor tenTwoS = fill(2,dataTestTwo,1);

  Tensor tenThreeF = fill(3,dataTestThree,100);
  Tensor tenThreeS = fill(3,dataTestThree,101);

  Tensor tenFourF = fill(0,dataTestFour,1);
  Tensor tenFourS = fill(0,dataTestFour,9);

  //check tensor dot product first
  Tensor dotOne, dotTwo, dotThree, dotFour;

  /*dotOne = [[ 90 ]];
  dotTwo = [[ 17982 ]];
  dotThree = [[ 242400 ]];
  dotFour = [[ 9 ]];*/

  Tensor dotOne = tenOneF .* tenOneS;
  Tensor dotTwo = tenTwoF .* tenTwoS;
  Tensor dotThree = tenThreeF .* tenThreeS;
  Tensor dotFour = tenFourF .* tenFourS;

  printf("%f\n",dotOne);
  printf("%f\n",dotTwo);
  printf("%f\n",dotThree);
  printf("%f\n",dotFour);


  if (dotOne != tenOneF .* tenOneS) {
    printf("one is %f\n",tenOneF .* tenOneS);
    return 1;
  }

  if (dotTwo != tenTwoF .* tenTwoS) {
    printf("two is %f\n",tenTwoF .* tenTwoS);
    return 1;
  }

  if (dotThree != tenThreeF .* tenThreeS) {
    printf("three is %f\n",tenThreeF .* tenThreeS);
    return 1;
  }

  if (dotFour != tenFourF .* tenFourS) {
    printf("four is %f\n",tenFourF .* tenFourS);
    return 1;
  }

  //then test float dot product

  if ( 90 != tenOneF f.* tenOneS) {
    return 1;
  }

  if ( 17982 != tenTwoF f.* tenTwoS) {
    return 1;
  }

  if ( 242400 != tenThreeF f.* tenThreeS) {
    return 1;
  }

  if ( 9 != tenFourF f.* tenFourS) {
    return 1;
  }

  freeT(tenOneS);
  freeT(tenTwoS);
  freeT(tenThreeS);
  freeT(tenFourS);
  freeT(tenOneF);
  freeT(tenTwoF);
  freeT(tenThreeF);
  freeT(tenFourF);

  freeT(dotOne);
  freeT(dotTwo);
  freeT(dotThree);
  freeT(dotFour);

  return 0;
}
