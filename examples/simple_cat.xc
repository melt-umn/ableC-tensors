/* taken from edu.umn.cs.melt.exts.ableC.matlab */

#include <stdio.h>
#include <stdlib.h>
#include "arraysLib.h"

int main (int argc, char **argv) {

  int B_dim[2] = {4,3};
  int B_incr[2] = {2,3};
  Array B = create_array(2,B_dim,20,B_incr);

  int C_dim[2] = {5,4};
  int C_incr[2] = {5,4};
  Array C = create_array(2,C_dim,20,C_incr);

  printf("Printing out Array C\n");
  print_array(C);

  printf("Printing out Array B\n");
  print_array(B);

  Array D = cat_array (3, B, C);

  printf("Printing out Array D\n");
  print_array(D);

  return 0 ;
}
