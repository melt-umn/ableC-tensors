#include "tensorsLib.h"
#include <stdio.h>

int main(int argc, char **argv) {
	printf("\n\nAccess Tensor test:\n");

	//Constructing tensor
	int dimSizes[] = {2, 2};
	int data[] = {1, 2, 3, 4};

	Tensor test;
	test.dim = 2;
	test.data = data;
	test.dim_size = dimSizes;
    test.count = 4;

	printf("\n%i", test.dim);

	printf("\n\nConstructed tensor is: \n");
	print_tensor(test, delimiters, 10);
	//Tensor constructed

	//Costructing aux data structures for access
	struct Interval *intervalList;
	struct Interval inOne;
	struct Interval inTwo;

	inOne.lBound = 1;
	inOne.rBound = 1;



	printf("\n%i", test.dim);
	print_tensor(access_tensor(test, intervalList, 2), delimiters, 10);

	return 0;
}
