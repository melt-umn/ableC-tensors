//Written by Nguyen Nguyen, Ankit Siva and Zoe Wentzel
//Parts copied from edu.umn.cs.melt.exts.ableC.matlab

//Modified arraysLib.c file to fit our own needs, cleaning out most of the
//code from the matlab version but still using snippets for inspiration/help//might break, please don't trust this -zoe

#include <stdio.h>
#include <stdlib.h>
#include "arraysLib.h"
#include <errno.h>
#include <math.h>


//tests functions thusfar
int main (int argc, char **argv) {

	int intTest = 5;
  Array intToScalarTest = int_to_scalar(intTest);
	int scalarToIntTest = scalar_to_int(intToScalarTest);

	int *dataTestOne = malloc(sizeof(int) * 2);
	dataTestOne[0] = 3;
	dataTestOne[1] = 3;

	int *dataTestTwo = malloc(sizeof(int) * 2);
	dataTestTwo[0] = 6;
	dataTestTwo[1] = 2;

	int *dataTestThree = malloc(sizeof(int));
	dataTestThree[0] = 9;

	Array fillArrayTest = fill_array(2,dataTestOne,666);
	Array onesTest = ones(2,dataTestTwo);
	Array zerosTest = zeros(1,dataTestThree);

	printf("intToScalarTest Array:\n");
	print_array(intToScalarTest);
	printf("\n");

	printf("\nThe intTest was %d\n\n",scalarToIntTest);

	printf("The array full of the devil is: \n");
	print_array(fillArrayTest);
	printf("\n\n");

	printf("The ones array is: \n");
	print_array(onesTest);
	printf("\n\n");

	printf("The zeros array is: \n");
	print_array(zerosTest);
	printf("\n\n");

	return 0;

}

// Array create_identity_array(int dimension, int dim_len){
// 	int i = 0;
// 	Array *matrix = malloc(sizeof(Array));
// 	Array -> dim = dimension;
// 	Array -> dim_size = malloc(sizeof(int)*dimension);
// 	Array -> count = pow(dim_len, dimension);
// 	Array -> data = malloc(sizeof(int)*count);
//
// 	for (i = 0; i < count; i++) {
// 		if (i % (dim_len + 2) == 0) {
// 			data[i] = 1;
// 		} else {
// 			data[i] = 0;
// 		}
// 	}
//
// 	print_array(matrix);
// }


//prints array up to two dimensions for now
void print_array(Array input){
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

/*
  Description:
    Take the number of dimensions, a pointer to the dimension array, and the
		number to fill the tensor with

  Assumption:
    Array return will have the value of the given number in all dimensions
*/

Array fill_array(int dim, int *dim_size, int toFill) {
	int i, count;
	int *data;
	count = 1; //if dim is 0 (scalar), count will still be one

	for (i = 0; i < dim; i++) {
		count *= dim_size[i]; //multiply number of elements by the dimensions
	}

	data = malloc(sizeof(int)*count); //malloc space for each element

	for (i = 0; i < count; i++) {
		data[i] = toFill; //fill array with the given number
	}

	Array *arr = malloc(sizeof(Array) + sizeof(int)*count + sizeof(int)*dim);

	arr->dim = dim;
	arr->dim_size = dim_size;
	arr->count = count;
	arr->data = data;

	return *arr;
}

/*
  Description:
    Takes the number of dimensions and a pointer to the dimension array

  Assumption:
    Will return array full of ones
*/

Array ones(int dim, int *dim_size) {
	return fill_array(dim,dim_size,1);
}

/*
  Description:
    Takes the number of dimensions and a pointer to the dimension array

  Assumption:
    Will return array full of zeros
*/

Array zeros(int dim, int *dim_size) {
	return fill_array(dim,dim_size,0);
}

/*
  Description:
    Takes an integer to make a scalar array

  Assumption:
    Will return an array with dim = 0 and dim_size pointing to NULL, only
		element in the array will be the integer
*/

Array int_to_scalar(int i) {
	int *data;
	data = malloc(sizeof(int));
	Array *arr = malloc(sizeof(Array) + sizeof(int) ); //sizeof(int) * dim + sizeof(int) * count

	data[0] = i;

	arr->dim = 0;
	arr->dim_size = NULL;
	arr->count = 1;
	arr->data = data;

	return *arr;
}

/*
  Description:
    Takes a scalar array to make an integer

  Assumption:
    Array passed in must have count = 1 — can only work with an array with a
		single element. Will return the integer of that single element
*/

int scalar_to_int(Array a) {
	if (a.count == 1) {
		return a.data[0];
	}
	else {
		printf("Error, not a scalar array");
		exit(-1);
	}
}
