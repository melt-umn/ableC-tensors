/* taken from edu.umn.cs.melt.exts.ableC.matlab */

#include <stdio.h>
#include <stdlib.h>
#include "../artifact/arraysLib.h"

int main (int argc, char **argv) {

  int B_dim[3] = {4,3,2};
  int B_incr[3] = {2,3,3};
  Array B = create_array(3,B_dim,20,B_incr);

  int C_dim[10] = {5,4,3,2,1,5,4,3,2,1};
  int C_incr[10] = {5,4,3,2,1,5,4,3,2,1};
  Array C = create_array(10,C_dim,20,C_incr);

  printf("Printing out Array B\n");
  print_array(B);

  Array D = cat (3, B, B);

  printf("Printing out Array D\n");
  print_array(D);

  return 0 ;
}
