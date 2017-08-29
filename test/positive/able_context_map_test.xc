#include "../include/tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//this documents tests map functions that take in context, useful in cases
//where the function needs potentially unknown data from the programmer

typedef struct {
  float to_add;
} FloatToAdd;

float add_to_elem(float i, void *context) {
  FloatToAdd *ctx = (FloatToAdd*) context;
  return i + ctx->to_add;
}

Tensor add_first_to_all(Tensor ten) {
  FloatToAdd elem_to_add = (FloatToAdd) { .to_add = ten.data[0] };
  map_with_context(add_to_elem,ten,&elem_to_add); //function,tensor,context
  return ten;
}

int main () {
  Tensor tenOne = [[ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]];
  Tensor tenOneAdd = [[ 2, 3, 4, 5, 6, 7, 8, 9, 10 ]];

  Tensor tenTwo = [[ [[ 3, 4, 5]],[[ 6, 7, 8 ]],[[ 9, 8, 7 ]] ]];
  Tensor tenTwoAdd = [[ [[ 6, 7, 8]],[[ 9, 10, 11 ]],[[ 12, 11, 10]] ]];

  Tensor tenThree = [[ [[ [[ 0 ]], [[ 0 ]] ]], [[ [[ 1 ]] , [[ 1 ]] ]] ]];
  Tensor tenThreeAdd = [[ [[ [[ 0 ]], [[ 0 ]] ]], [[ [[ 1 ]] , [[ 1 ]] ]] ]];

  if (add_first_to_all(tenOne) != tenOneAdd) {
    return 1;
  }

  if (add_first_to_all(tenTwo) != tenTwoAdd) {
    return 1;
  }

  if (add_first_to_all(tenThree) != tenThreeAdd) {
    return 1;
  }

  freeT(tenOne);
  freeT(tenOneAdd);
  freeT(tenTwo);
  freeT(tenTwoAdd);
  freeT(tenThree);
  freeT(tenThreeAdd);

  return 0;
}
