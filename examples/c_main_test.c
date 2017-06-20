#include "tensorsLib.h"
#include <stdio.h>
#include <stdlib.h>

//a melting pot of different tensor functions
int main () {

	int intTest = 5;
	Tensor intToScalarTest = int_to_scalar_tensor(intTest);
	int scalarToIntTest = scalar_tensor_to_int(intToScalarTest);

	int *dataTestOne = malloc(sizeof(int) * 2);
	dataTestOne[0] = 3;
	dataTestOne[1] = 3;

	int *dataTestTwo = malloc(sizeof(int) * 2);
	dataTestTwo[0] = 6;
	dataTestTwo[1] = 2;

	int *dataTestThree = malloc(sizeof(int));
	dataTestThree[0] = 9;

	int *dataTestFour = malloc(sizeof(int));
	dataTestFour[0] = 3;

	Tensor fillTensorTest = fill_tensor(2,dataTestOne,666);
	Tensor onesTest = ones(2,dataTestTwo);
	Tensor zerosTest = zeros(1,dataTestThree);
	Tensor dotProductTestOne = fill_tensor(1,dataTestThree,666);
	Tensor dotProductTestTwo = fill_tensor(1,dataTestThree,-666);
	Tensor crossProductTestOne = fill_tensor(1,dataTestFour,6);
	Tensor crossProductTestTwo = fill_tensor(1,dataTestFour,2);

	printf("\nIdentity matrix is:\n");
	Tensor identity = create_identity_tensor(2, 8);
	print_tensor(identity,delimiters,10);
	printf("\n");

	printf("intToScalarTest Tensor:\n");
	print_tensor(intToScalarTest,delimiters,10);
	printf("\n");

	printf("\nThe intTest was %d\n\n",scalarToIntTest);

	printf("The tensor full of the devil is: \n");
	print_tensor(fillTensorTest,delimiters,10);
	printf("\n");

	printf("The ones tensor is: \n");
	print_tensor(onesTest,delimiters,10);
	printf("\n");

	printf("The transposed ones tensor is: \n");
	print_tensor(transpose(onesTest),delimiters,10);
	printf("\n");

	printf("The zeros tensor is: \n");
	print_tensor(zerosTest,delimiters,10);
	printf("\n");

	printf("first array to dot:\n");
	print_tensor(dotProductTestOne,delimiters,10);
	printf("\n");

	printf("second array to dot:\n");
	print_tensor(dotProductTestTwo,delimiters,10);
	printf("\n");

	printf("when dotted together (tensor):\n");
	print_tensor(dot_product(dotProductTestOne,dotProductTestTwo),delimiters,10);
	printf("\n");

	printf("when dotted together (int):\n");
	printf("%d",int_dot_product(dotProductTestOne,dotProductTestTwo));
	printf("\n\n");

	printf("when dotted together (int) v2 (tensor combine and fold):\n");
	printf("%d",int_dot_product_vtwo(dotProductTestOne,dotProductTestTwo));
	printf("\n\n");

	printf("first array to cross:\n");
	print_tensor(crossProductTestOne,delimiters,10);
	printf("\n");

	printf("second array to cross:\n");
	print_tensor(crossProductTestTwo,delimiters,10);
	printf("\n");

	printf("when crossed together:\n");
	print_tensor(cross_product(crossProductTestOne,crossProductTestTwo),delimiters,10);
	printf("\n");

	printf("[6 6 6] folded sum is: %d", sum(crossProductTestOne));
	printf("\n");

	printf("[6 6 6] folded product is: %d", product(crossProductTestOne));
	printf("\n");

	printf("[6 6 6] folded max is: %d", max(crossProductTestOne));
	printf("\n");

	printf("[6 6 6] folded min is: %d", min(crossProductTestOne));
	printf("\n");

	// printf("Access test:\n");
	// Interval interval = {0, 7};
	// print_tensor(identity,delimiters,10);
	// printf("\n");
	// printf("%i to %i", interval.lBound, interval.rBound);
	// print_tensor(access_tensor(identity, 5, interval),delimiters,10);

	return 0;
}
