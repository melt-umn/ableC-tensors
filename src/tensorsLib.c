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
 * Description:
 * Takes a Tensor and returns a duplicate of it in a new space in memory.
 * Can be useful since Tensor functions, such as map, work on it as mutable
 * data. By copying the Tensor first, it can be modified without getting
 * rid of previous data.
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

	Tensor *newTens = malloc(sizeof(Tensor));

	newTens->dim = dim;
	newTens->dim_size = dim_size;
	newTens->count = count;
	newTens->data = data;

	return *newTens;
}

/*
 * Description:
 * Creates an identity tensor for a given number of dimensions
 * and each dimension having a certain dimension length.
 * This function makes only tensors that have the same length in all dimensions
 *
 * Assumption:
 * Identity tensor with given dimension number and dimension length parameters
 * is generated.
 */
Tensor create_identity_tensor(int numDimensions, int dim_len){
	int i = 0;
	int count = pow(dim_len, numDimensions);

	int *data = malloc(sizeof(int)*count);

	for (i = 0; i < count; i++) {
		if (i % (dim_len + numDimensions - 1) == 0) {
			data[i] = 1;
		} else {
			data[i] = 0;
		}
	}

	Tensor *matrix = malloc(sizeof(Tensor));
	matrix -> dim = numDimensions;
	matrix -> dim_size = malloc(sizeof(int)*numDimensions);

	for (i = 0; i < numDimensions; i++) {
		matrix -> dim_size[i] = dim_len;
	}

	matrix -> count = pow(dim_len, numDimensions);
	matrix -> data =  data;

	return *matrix;
}

/*
 * Description:
 * Creates an identity tensor for a given number of dimensions
 * and each dimension having a length specified by the array of integers passed
 *
 * Assumption:
 * Identity tensor with given number of dimensions and each having the specified
 * dimension length is created.
 */

Tensor create_identity_tensor_asymmetric(int numDimensions, int * dim_len);

/*
 * Description:
 * Take the number of dimensions, a pointer to the dimension tensor, and the
 * number to fill the tensor with
 *
 * Assumption:
 * Tensor returned will have the value of the given number in all dimensions
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

	Tensor *tens = malloc(sizeof(Tensor));

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


	Tensor *tens = malloc(sizeof(Tensor));

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
		exit(1);
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
		exit(1);
	}
}


/*
  Description:
    Takes two tensors calculates the dot product between them, returns tensor.

  Assumption:
    The tensors passed in must be the same dimensions and cannot exceed two
		dimensions. The returned tensor will be scalar (zero dimensions).
*/
Tensor dot_product(Tensor tOne, Tensor tTwo) {
	int i, sum;
	int dimOne = tOne.dim;
	int dimTwo = tTwo.dim;
	int *dimSizeOne = tOne.dim_size;
	int *dimSizeTwo = tTwo.dim_size;
	int *dataOne = tOne.data;
	int *dataTwo = tTwo.data;
	int totalCount = tOne.count; //if dimSizeOne == dimSizeTwo, count for each will be same

	//used for return scalar tensor;
	int *data;
	Tensor *tens;

	sum = 0;

	if (dimOne == dimTwo) {
		for (i = 0; i < dimOne; i++) {
			if (dimSizeOne[i] != dimSizeTwo[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}
		data = malloc(sizeof(int));
		tens = malloc(sizeof(Tensor));
		for (i = 0; i < totalCount; i++) {
			sum += dataOne[i] * dataTwo[i];
		}
		data[0] = sum;
		tens->dim = 0;
		tens->dim_size = NULL;
		tens->count = 1;
		tens->data = data;
		return *tens;
	}
	else {
		printf("The two tensors have a different number of dimensions\n");
		exit(1);
	}
}

/*
  Description:
    Returns the dot product of two tensors as an integer.

  Assumption:
    The two tensors passed in must be the same dimensions and cannot be greater
		than two-dimensional.
*/
int int_dot_product(Tensor tOne, Tensor tTwo) {
	//return scalar_tensor_to_int(dot_product(tOne,tTwo)); //wastes memory, but
	//also less code (is it worth it to call it? small amount of wasted time as well)
	int i, sum;
	int dimOne = tOne.dim;
	int dimTwo = tTwo.dim;
	int *dimSizeOne = tOne.dim_size;
	int *dimSizeTwo = tTwo.dim_size;
	int *dataOne = tOne.data;
	int *dataTwo = tTwo.data;
	int totalCount = tOne.count; //if dimSizeOne == dimSizeTwo, count for each will be same
	sum = 0;

	if (dimOne == dimTwo) {
		for (i = 0; i < dimOne; i++) {
			if (dimSizeOne[i] != dimSizeTwo[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}
		for (i = 0; i < totalCount; i++) {
			sum += dataOne[i] * dataTwo[i];
		}
		return sum;
	} else {
		printf("The two tensors have a different number of dimensions\n");
		exit(1);
	}
}

/*
  Description:
    Takes two tensors calculates the cross product between them, returns tensor.

  Assumption:
    The tensors passed in must be vectors (dim = 1) with three elements. The
		returned tensor will be the same. In the future, this function may be extended
		to match that in Matlab.
*/
Tensor cross_product(Tensor tOne, Tensor tTwo) {
	int i;
	int dimOne = tOne.dim;
	int dimTwo = tTwo.dim;
	int *dimSizeOne = tOne.dim_size;
	int *dimSizeTwo = tTwo.dim_size;
	int *dataOne = tOne.data;
	int *dataTwo = tTwo.data;
	int totalCount = tOne.count; //if dimSizeOne == dimSizeTwo, count for each will be same

	int *data;
	int *dim_size;
	Tensor *tens;

	if (dimOne == dimTwo && dimOne == 1) {
		if (dimSizeOne[0] == dimSizeTwo[0] && dimSizeOne[0] == 3) {
			tens = malloc(sizeof(Tensor));
			dim_size = malloc(sizeof(int));
			data = malloc(sizeof(int)*3);
			dim_size[0] = 3;
			data[0] = (dataOne[1] * dataTwo[2]) - (dataOne[2] * dataTwo[1]);
			data[1] = (dataOne[2] * dataTwo[0]) - (dataOne[0] * dataTwo[2]);
			data[2] = (dataOne[0] * dataTwo[1]) - (dataOne[1] * dataTwo[0]);

			tens->dim = 1;
			tens->dim_size = dim_size;
			tens->count = 3;
			tens->data = data;
			return *tens;
		} else {
			printf("The two tensors have different length of dimensions\n");
			exit(1);
		}
	} else {
		printf("The two tensors have a different number of dimensions\n");
		exit(1);
	}
}
/*
void print_tensor(Tensor input) {
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
}*/

/*
 * Proper, n-dimensional tensor print
 * Should be written with modular arithmetic to ensure high portability
 * As of now works with 2D and lower, so should run fine instead of using the large print function above
 */
void print_tensor(Tensor input) {
	int i = 0;
	int j = 0;

	printf("[\n");

	for (; i < input.count; i++) {
		printf("%i", input.data[i]);
//		printf("\n\nLooking at element %i at index %i",input.data[i], i);

		for(j = input.dim - 1; j > 0; j--) {
//			printf("\n\nLooking at dimension length of %ith dimension = %i", j+1, input.dim_size[j]);
//			printf("\n(%i+1) %% input.dim_size[%i] = %i", i, j, (i + 1) % input.dim_size[j]);
			if ((i+1) % input.dim_size[j] == 0) {
				printf("%c", delimiters[j]);
				j = 0;
			}
		}

		if (j == 0) {
			printf("%c", delimiters[j]);
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
	Tensor identity = create_identity_tensor(2, 2);
	print_tensor(identity);
	printf("\n\n");

	 printf("intToScalarTest Tensor:\n");
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
	// printf("The ones -666 / 0 tensor is: \n");
	// map(scalar_divide,0,onesTest);
	// print_tensor(onesTest);
	// printf("\n\n");

	printf("first array to dot:\n");
	print_tensor(dotProductTestOne);
	printf("\n\n");

	printf("second array to dot:\n");
	print_tensor(dotProductTestTwo);
	printf("\n\n");

	printf("when dotted together (tensor):\n");
	print_tensor(dot_product(dotProductTestOne,dotProductTestTwo));
	printf("\n\n");

	printf("when dotted together (int):\n");
	printf("%d",int_dot_product(dotProductTestOne,dotProductTestTwo));
	printf("\n\n");


	printf("first array to cross:\n");
	print_tensor(crossProductTestOne);
	printf("\n\n");

	printf("second array to cross:\n");
	print_tensor(crossProductTestTwo);
	printf("\n\n");

	printf("when crossed together:\n");
	print_tensor(cross_product(crossProductTestOne,crossProductTestTwo));
	printf("\n\n");


	return 0;
}
