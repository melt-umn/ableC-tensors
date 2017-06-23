#include "../src/tensorsLib.c"
#include <stdio.h>

int main (int argc, char **argv) {
	Tensor toDecompose;
	toDecompose.dim = 2;
	toDecompose.count = 4;
	int data[] = {1, 2, 3, 4};
	int dim_size[] = {2, 2};

	Tensor L;
	Tensor U;
	
	LU_Decomp(toDecompose, &L, &U);
	return 0;
}	
