//Written by Nguyen Nguyen, Ankit Siva and Zoe Wentzel
//Parts copied from edu.umn.cs.melt.exts.ableC.matlab

//Modified tensorsLib.c file to fit our own needs, cleaning out most of the
//code from the matlab version but still using snippets for inspiration/help//might break, please don't trust this -zoe

#include <stdio.h>
#include <stdlib.h>
#include "tensorsLib.h"
#include <errno.h>
#include <math.h>

/*
  Description:
    Take the number of dimensions, a pointer to the dimension tensor, and the
		number to fill the tensor with

  Assumption:
    Tensor returned will have the value of the given number in all dimensions
*/

Tensor create_identity_tensor(int dimension, int dim_len){
	int i = 0;
	Tensor *matrix = malloc(sizeof(Tensor));
	*matrix.dim = dimension;
	*matrix.dim_size = calloc(dim_len*dim_len, sizeof(int));
	*matrix.count = pow(dim_len, dimension);
	*matrix.data = malloc(sizeof(int)*count);
	for (i = 0; i < count; i++) {
		if (i % (dim_len + dimension) == 0) {
			*(data + i) = 1;
		} else {
		*(data + i) = 0;
		}
	}
	print_tensor(matrix);
}

Tensor fill_tensor(int dim, int *dim_size, int toFill) {
	int i, count;
	int *data;
	count = 1; //if dim is 0 (scalar), count will still be one

	for (i = 0; i < dim; i++) {
		count *= dim_size[i]; //multiply number of elements by the dimensions
	}

	data = malloc(sizeof(int)*count); //malloc space for each element

	for (i = 0; i < count; i++) {
		data[i] = toFill; //fill tensor with the given number
	}

	Tensor *tens = malloc(sizeof(Tensor) + sizeof(int)*count + sizeof(int)*dim);

	tens->dim = dim;
	tens->dim_size = dim_size;
	tens->count = count;
	tens->data = data;

	return *tens;
}

/*
  Description:
    Take the number of dimensions and a pointer to the dimension tensor to
		return a tensor of that size full of ones

  Assumption:
    Tensor returned will have ones in all dimensions
*/

Tensor ones(int dim, int *dim_size) {
	return fill_tensor(dim,dim_size,1);
}

/*
  Description:
    Take the number of dimensions and a pointer to the dimension tensor to
		return a tensor of that size full of zeros

  Assumption:
    Tensor returned will have zeros in all dimensions
*/

Tensor zeros(int dim, int *dim_size) {
	return fill_tensor(dim,dim_size,0);
}

/*
  Description:
    Takes an integer and turns it into a 0 dimensional, single element tensor

  Assumption:
    The returned tensor will have a dim of 0, a dim_size of null, and a count
		of 1. It's only data will be the given integer.
*/

Tensor int_to_scalar_tensor(int i) {
	int *data;
	data = malloc(sizeof(int));
	Tensor *tens = malloc(sizeof(Tensor) + sizeof(int) ); //sizeof(int) * dim + sizeof(int) * count

	data[0] = i;

	tens->dim = 0;
	tens->dim_size = NULL;
	tens->count = 1;
	tens->data = data;

	return *tens;
}

/*
  Description:
    Takes an (scalar) tensor and returns the integer in it

  Assumption:
    The given tensor must have only one element (count of 1). This also means
		that its dimension is 0 and it's dim_size is NULL, though neither of these
		are being checked.
*/

int scalar_tensor_to_int(Tensor a) {
	if (a.count == 1) {
		return a.data[0];
	}
	else {
		printf("Error, not a scalar tensor");
		exit(-1);
	}
}

int main (int argc, char **argv) {

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

	Tensor fillTensorTest = fill_tensor(2,dataTestOne,666);
	Tensor onesTest = ones(2,dataTestTwo);
	Tensor zerosTest = zeros(1,dataTestThree);

	printf("intToScalarTest Tensor:\n");
/*	print_tensor(Tensor input){
	int currentCount,i,j;
  int totalCount = input.count;
  int totalDim = input.dim;
  int *data = input.data;
  int *dim_size = input.dim_size;
	currentCount = 0;

	printf("[ ");
	if (totalDim == 0) {
		printf("%d ", data[currentCount]);
	}

	if (totalDim == 1) {
		for (i = 0; i < dim_size[0]; i++) {
			printf("%d ", data[currentCount]);
		}
	}

	if (totalDim == 2) {
		for (i = 0; i < dim_size[1]; i++) {
			for (j = 0; j < dim_size[0]; j++) {
				printf("%d ", data[currentCount]);
				currentCount++;
			}
			if (i != dim_size[1] - 1) {
				printf("\n  ");
			}
		}
	}

	printf("]");
} */
}
