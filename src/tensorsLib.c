//Written by Nguyen Nguyen, Ankit Siva and Zoe Wentzel
//Parts copied from edu.umn.cs.melt.exts.ableC.matlab

//Modified tensorsLib.c file to fit our own needs, cleaning out most of the
//code from the matlab version but still using snippets for inspiration/help//might break, please don't trust this -zoe

#include <stdio.h>
#include <stdlib.h>
#include "../include/tensorsLib.h"
#include <errno.h>
#include <math.h>

/*
  Description:
    Takes a Tensor and returns a duplicate of it in a new space in memory.
		Can be useful since Tensor functions, such as map, work on it as mutable
		data. By copying the Tensor first, it can be modified without getting
		rid of previous data.
*/
Tensor copy_tensor(Tensor tens) {
	int i,j;
	int dim = tens.dim;
	int count = tens.count;
	int *dim_size;
	int *data;

	data = malloc(sizeof(int)*count);
	dim_size = malloc(sizeof(int)*dim);

	for (i = 0; i < count; i++) {
		data[i] = tens.data[i];
	}
	for (j = 0; j < dim; j++) {
		dim_size[j] = tens.dim_size[j];
	}

	Tensor *newTens = malloc(sizeof(Tensor) + sizeof(int)*count + sizeof(int)*dim);

	newTens->dim = dim;
	newTens->dim_size = dim_size;
	newTens->count = count;
	newTens->data = data;

	return *newTens;
}

Tensor create_identity_tensor(int dimension, int dim_len){
	int i = 0;
	Tensor *matrix = malloc(sizeof(Tensor));
	matrix -> dim = dimension;
	matrix -> dim_size = calloc(dim_len*dim_len, sizeof(int));
	matrix -> count = pow(dim_len, dimension);
	matrix -> data = malloc(sizeof(int)*(matrix->count));
	for (i = 0; i < matrix -> count; i++) {
		if (i % (dim_len + dimension) == 0) {
			*(matrix -> data + i) = 1;
		} else {
			*(matrix -> data + i) = 0;
		}
	}
	return *matrix;
}

/*
  Description:
    Take the number of dimensions, a pointer to the dimension tensor, and the
		number to fill the tensor with

  Assumption:
    Tensor returned will have the value of the given number in all dimensions
*/
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

	////////IS THIS NECESSARY IDK I COMMENTED IT OUT AND IT WORKS STILL//////////

	Tensor *tens = malloc(sizeof(Tensor)); //+ sizeof(int)*count + sizeof(int)*dim);

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

	////////IS THIS NECESSARY IDK I COMMENTED IT OUT AND IT WORKS STILL////////////

	Tensor *tens = malloc(sizeof(Tensor)); //+ sizeof(int) ); //sizeof(int) * dim + sizeof(int) * count

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

/*
  Description:
    Takes a function and a Tensor and performs that function on every element in
		the Tensor.

  Assumption:
    The given function must handle integers and the returned Tensor will be
		the same size as the one passed in. Will mutate the tensor itself, will
		not return a new tensor.
*/
Tensor map(int (*fun)(int,int), int j, Tensor tens) {
	int i;
	int count = tens.count;
	int *data = tens.data;

	for (i = 0; i < count; i++) {
		data[i] = (*fun)(data[i],j);
	}

	return tens;
}

/*
  Description:
    Following functions are some classics to pass into map.

  Assumption:
    These functions must be passed into map alongside another integer that
		will be used with them and the tensor to use them all.
*/
int scalar_add(int i, int j) {
	return i + j;
}

int scalar_subtract(int i, int j) {
	return i - j;
}

int scalar_multiply(int i, int j) {
	return i * j;
}

int scalar_divide(int i, int j) {
	if (j != 0) {
		return i / j;
	}
	else {
		printf("Error, cannot scalar divide by zero\n");
		exit(-1);
	}
}

void print_tensor(Tensor input){
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
	Tensor identityTest = create_identity_tensor(2,3);

	printf("intToScalarTest Tensor:\n");
<<<<<<< HEAD
=======
	print_tensor(intToScalarTest);
	printf("\n");

	printf("\nThe intTest was %d\n\n",scalarToIntTest);

	printf("The tensor full of the devil is: \n");
	print_tensor(fillTensorTest);
	printf("\n\n");

	printf("The ones tensor is: \n");
	print_tensor(onesTest);
	printf("\n\n");

	printf("The zeros tensor is: \n");
	print_tensor(zerosTest);
	printf("\n\n");

	printf("The identity tensor is: \n");
	print_tensor(identityTest);
	printf("\n\n");

	printf("The mutable ones + 1 tensor is: \n");
	map(scalar_add,1,onesTest);
	print_tensor(onesTest);
	printf("\n\n");

	printf("The mutable ones + 1 - 3 tensor is: \n");
	map(scalar_subtract,3,onesTest);
	print_tensor(onesTest);
	printf("\n\n");

	printf("The mutable ones - 1 * 666 tensor is: \n");
	map(scalar_multiply,666,onesTest);
	print_tensor(onesTest);
	printf("\n\n");

	printf("The copied ones * -666 / 3 tensor is: \n");
	Tensor copiedOnesTest = map(scalar_divide,3,copy_tensor(onesTest));
	print_tensor(copiedOnesTest);
	printf("\n\n");

	printf("But the before ones is still : \n");
	print_tensor(onesTest);
	printf("\n\n");

	//this will break it, it's on purpose :D
	printf("The ones -666 / 0 tensor is: \n");
	map(scalar_divide,0,onesTest);
	print_tensor(onesTest);
	printf("\n\n");

	return 0;

>>>>>>> 4f44e4e5188f8d7b2e6181c77bf18f4479b68edc
}
