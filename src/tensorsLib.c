//Written by Ankit Siva and Zoe Wentzel
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
 * Creates a Tensor in which each field of the tensor struct is passed in
 *
 * Assumption:
 * everything is passed in correctly
*/
Tensor create_tensor(int dim, int *dim_size, int count, int *data) {
	Tensor newTens;
	newTens.dim = dim;
	newTens.dim_size = dim_size;
	newTens.count = count;
	newTens.data = data;
	return newTens;
}

/*
 * Description:
 * This function creates and returns a tensor containing the elements that need to be accessed
 * Takes in the tensor to be accessed, an integer pointer pointing to an array that specifies
 * which dimensions need to be accessed along. An interval is also passed (that for now moves only along the row,
 * but later changes wil allow interval to specify the dimension it needs to go along as well).
 * Passed also is an int containing the length of the accessAlongDims.
 *
Tensor access_tensor(Tensor toAccess, int dimOfInterval, Interval interval, int * accessAlongRemaining, int accessAlongRemainingSize) {
	int i = 0;
	int j = 0;
	int k = 0;
	int offset = 0;

	if (accessAlongRemainingSize > toAccess.dim) {
		printf("\n\nToo many dimensions specified. Tensor cannot be accessed with these parameters");
		exit(1);
	} else if (accessAlongRemainingSize < toAccess.dim - 1) {
		printf("\n\nToo few dimensions specified. Tensor cannot be accessed with these parameters");
		exit(1);
	}

	Tensor toReturn;
	toReturn.count = interval.rBound - interval.lBound + 1;
	toReturn.data = malloc(toReturn.count * sizeof(int));
	toReturn.dim = toAccess.dim;
	toReturn.dim_size = malloc(sizeof(int)*toReturn.dim);

	for (i = 0; i < toReturn.dim; i++) {
		if(i != dimOfInterval - 1) {
			toReturn.dim_size[i] = 1;
		} else {
			toReturn.dim_size[i] = toReturn.count;
		}
	}

	for (i = interval.lBound; i <= interval.rBound; i++) {
		printf("\n%i", i);
		offset = 1;
		for (k = toAccess.dim - 1; k > 0; k--) {
			if (k != dimOfInterval - 1) {
				offset *= accessAlongRemaining[accessAlongRemainingSize - k] + toAccess.dim_size[k];
			} else {
				offset *= i + toAccess.dim_size[k];
			}
			printf("%i", offset);
		}
		offset *= accessAlongRemaining[0];
		printf("\nAt index %i", offset);
		toReturn.data[j] = toAccess.data[offset];
		j++;
	}

	return *toReturn;
}*/

Tensor access_tensor(Tensor toAccess, struct Interval * intervalList, int intervalListLength) {
	if (intervalListLength != toAccess.dim) {
		printf("\n\nNot enough intervals specifying the accessing");
	}

	Tensor toReturn;
	int j = 0;
	int i = 0;
	int boundDiff = 0;

	toReturn.dim = toAccess.dim;
	toReturn.count = 0;

	toReturn.dim_size = malloc(sizeof(int) * toReturn.dim);
	
	for (; i < intervalListLength; i++) {
		boundDiff = intervalList[i].rBound - intervalList[i].lBound;
		if(boundDiff == 0) {
			toReturn.dim--;
		} else {
			toReturn.count *= boundDiff;
			toReturn.dim_size[j++] = boundDiff;
		}
	}

	toReturn.data = malloc(sizeof(int) * toReturn.count);
	


	return toReturn;
}

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

	Tensor newTens;

	newTens.dim = dim;
	newTens.dim_size = dim_size;
	newTens.count = count;
	newTens.data = data;

	return newTens;
}

/*
  Description:
    Takes a tensor and transposes it (rows and columns are swapped)shhdsfsdfjasdfjsdfjasdfjkk.

  Assumption:
    The tensors passed in must be <= two dimensions and the returned tensor
		will have the same dimensions, but swapped. Does NOT mutate the actual tensor.
*/
Tensor transpose(Tensor tens) {
	int i,j;

	//passed in tensor
	int dim = tens.dim;
	int *dim_size = tens.dim_size;
	int count = tens.count;
	int *data = tens.data;

	//new tensor
	int new_dim;
	int *new_dim_size;
	int *new_data;
	Tensor newTens;

	if (dim <= 2) { //make sure tensor is two or less dimensions
		if (dim == 0) { //scalar tensor returns the tensor (copy)
			return copy_tensor(tens);
		}

		new_data = malloc(sizeof(int)*count); //malloc space for data

		if (dim == 1) { // n tensor is equivalent to n x 1, will become 1 x n
			new_dim = 2;
			new_dim_size = malloc(sizeof(int)*2);
			new_dim_size[0] = 1;
			new_dim_size[1] = dim_size[0];
			for (i = 0; i < count; i++) { //put all elements in, just need to copy
				new_data[i] = data[i];
			}
		} else { //tensor is two dimensional
			if (dim_size[0] == 1) { // 1 x n tensor will become n
				new_dim = 1;
				new_dim_size = malloc(sizeof(int));
				new_dim_size[0] = dim_size[1];
				for (i = 0; i < count; i++) { //put all elements in, just need to copy
					new_data[i] = data[i];
				}
			} else { // n x m tensor will become m x n
				new_dim = 2;
				new_dim_size = malloc(sizeof(int)*2);
				new_dim_size[0] = dim_size[1];
				new_dim_size[1] = dim_size[0];
				//can't just copy the elements for an n x m array :(
				for (i = 0; i < dim_size[0]; i++) {
					for (j = 0; j < dim_size[1]; j++) {
						new_data[j+dim_size[1]*i] = data[i + dim_size[0]*j]; //rip math thanks nathan
					}
				}
			}
		}
		newTens.dim = new_dim;
		newTens.dim_size = new_dim_size;
		newTens.count = count; //count won't change no matter what
		newTens.data = new_data;
		return newTens;
	} else {
		printf("Error, cannot transpose a Tensor that is greater than two dimensions\n");
		exit(1);
	}
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

	Tensor matrix;
	matrix.dim = numDimensions;
	matrix.dim_size = malloc(sizeof(int)*numDimensions);

	for (i = 0; i < numDimensions; i++) {
		matrix.dim_size[i] = dim_len;
	}

	matrix.count = pow(dim_len, numDimensions);
	matrix.data =  data;

	return matrix;
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

	Tensor tens;

	tens.dim = dim;
	tens.dim_size = dim_size;
	tens.count = count;
	tens.data = data;

	return tens;
}

/*
  Description:
    Take the number of dimensions and a pointer to the dimension tensor to
		return a tensor of that shape full of ones

  Assumption:
    Tensor returned will have ones in all dimensions
*/
Tensor ones(int dim, int *dim_size) {
	return fill_tensor(dim,dim_size,1);
}

/*
  Description:
    Take the number of dimensions and a pointer to the dimension tensor to
		return a tensor of that shape full of zeros

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

	Tensor tens;

	data[0] = i;

	tens.dim = 0;
	tens.dim_size = NULL;
	tens.count = 1;
	tens.data = data;

	return tens;
}

/*
  Description:
    Takes an (scalar) tensor and returns the integer in it

  Assumption:
    The given tensor must have only one element (count of 1).
*/
int scalar_tensor_to_int(Tensor a) {
	if (a.count == 1) { //should work for tensors with dim_size = [], [1], [1,1,1], etc
		return a.data[0];
	} else {
		printf("Error, not a scalar tensor\n");
		exit(1);
	}
}

/*
  Description:
    Takes a function and a Tensor and performs that function on every
		element in the Tensor.

  Assumption:
    The given function must handle integers and the returned Tensor will be
		the same shape as the one passed in. Will mutate the tensor itself, will
		not return a new tensor.
*/
Tensor map(int (*fun)(int), Tensor tens) {
	int i;
	int count = tens.count;
	int *data = tens.data;

	for (i = 0; i < count; i++) {
		data[i] = (*fun)(data[i]);
	}

	return tens;
}

Tensor square(Tensor tens) {
	return map(scalar_square,tens);
}

Tensor increment(Tensor tens) {
	return map(plus_one,tens);
}

int plus_one(int i) {
	return i + 1;
}

int scalar_square(int i) {
	return i * i;
}

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
	} else {
		printf("Error, cannot scalar divide by zero\n");
		exit(1);
	}
}

int scalar_mod(int i, int j) {
	if (j != 0) {
		return i % j;
	} else {
		printf("Error, cannot scalar divide by zero\n");
		exit(1);
	}
}

int greater_than(int i, int j) {
	if (i > j) {
		return i;
	} else {
		return j;
	}
}

int lesser_than(int i, int j) {
	if (i > j) {
		return j;
	} else {
		return i;
	}
}


/*
  Description:
    Takes a function, an integer, and a Tensor. Will reduce the Tensor using
		the rules given by the function, with the integer as the base. For example,
		if you wanted to add each element together, the function would be an
		addition function, the integer would be 0, and the Tensor would be the Tensor.

  Assumption:
    The given function must handle integers and will return a scalar Tensor.
*/
Tensor tensor_fold(int (*fun)(int,int), Tensor current, Tensor tens){
	int i;
	int count = tens.count;
	int currentCount = current.count;
	int *data = tens.data;
	int currentDim = current.dim;
	int *currentData = current.data;

	if (currentCount == 1) {
		if (currentDim == 0) { //dim needs to be 0, a [1] tensor will not work
				int *newData;
				Tensor newTens;
				newData[0] = currentData[0];

				for (i = 0; i < tens.count; i++) {
					newData[0] = (*fun)(data[i],newData[0]);
				}

				newTens.dim = 0;
				newTens.dim_size = NULL;
				newTens.count = 1;
				newTens.data = newData;
				return newTens;
		} else {
			printf("Error, starting data must be scalar array");
			exit(1);
		}
	} else {
		printf("Error, not a scalar tensor");
		exit(1);
	}
}

/*
  Description:
    Takes a function, an integer, and a Tensor. Will reduce the Tensor using
		the rules given by the function, with the integer as the base. For example,
		if you wanted to add each element together, the function would be an
		addition function, the integer would be 0, and the Tensor would be the Tensor.

  Assumption:
    The given function must handle integers and will return an integer.
*/
int fold(int (*fun)(int,int), int current, Tensor tens){
	int i;
	int count = tens.count;
	int *data = tens.data;

	for (i = 0; i < tens.count; i++) {
		current = (*fun)(data[i],current);
	}
	return current;
}

int max(Tensor tens) {
	return fold(greater_than,-2147483648,tens);
}

int min(Tensor tens) {
	return fold(lesser_than,2147483647,tens);
}

int sum(Tensor tens) {
	return fold(scalar_add,0,tens);
}

int product(Tensor tens) {
	return fold(scalar_multiply,1,tens);
}

Tensor tensor_max(Tensor tens) {
	return int_to_scalar_tensor(max(tens));
}

Tensor tensor_min(Tensor tens) {
	return int_to_scalar_tensor(min(tens));
}

Tensor tensor_sum(Tensor tens) {
	return int_to_scalar_tensor(sum(tens));
}

Tensor tensor_product(Tensor tens) {
	return int_to_scalar_tensor(product(tens));
}

/*
 * Description:
 * Creates a new tensor using a function and two other tensors
 *
 * Assumption:
 * two tensors must be the sameshape and the function must deal with ints
 * does not mutate either tensor passed in
*/
Tensor tensor_combine(int (*fun)(int,int), Tensor tOne, Tensor tTwo) {
	int i, sum;
	int dimOne = tOne.dim;
	int dimTwo = tTwo.dim;
	int *dimSizeOne = tOne.dim_size;
	int *dimSizeTwo = tTwo.dim_size;
	int *dataOne = tOne.data;
	int *dataTwo = tTwo.data;
	int totalCount = tOne.count; //if dimSizeOne == dimSizeTwo, count for each will be same

	int *data;
	int *dimSize;
	Tensor tens;

	if (dimOne == dimTwo) {
		for (i = 0; i < dimOne; i++) {
			if (dimSizeOne[i] != dimSizeTwo[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}
		data = malloc(sizeof(int)*totalCount);
		dimSize = malloc(sizeof(int)*dimOne);
		for (i = 0; i < dimOne; i++) {
			dimSize[i] = dimSizeOne[i];
		}
		for (i = 0; i < totalCount; i++) {
			data[i] = (*fun)(dataOne[i], dataTwo[i]);
		}
		tens.dim = dimOne;
		tens.dim_size = dimSize;
		tens.count = totalCount;
		tens.data = data;
		return tens;
	} else {
		printf("The two tensors have a different number of dimensions\n");
		exit(1);
	}
}

Tensor tensor_elem_add(Tensor tOne, Tensor tTwo) {
	return tensor_combine(scalar_add,tOne,tTwo);
}

Tensor tensor_elem_subtract(Tensor tOne, Tensor tTwo) {
	return tensor_combine(scalar_subtract,tOne,tTwo);
}

Tensor tensor_elem_multiply(Tensor tOne, Tensor tTwo) {
	return tensor_combine(scalar_multiply,tOne,tTwo);
}

Tensor tensor_elem_divide(Tensor tOne, Tensor tTwo) {
	return tensor_combine(scalar_divide,tOne,tTwo);
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
	Tensor tens;

	sum = 0;

	if (dimOne == dimTwo) {
		for (i = 0; i < dimOne; i++) {
			if (dimSizeOne[i] != dimSizeTwo[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}
		data = malloc(sizeof(int));
		for (i = 0; i < totalCount; i++) {
			sum += dataOne[i] * dataTwo[i];
		}
		data[0] = sum;
		tens.dim = 0;
		tens.dim_size = NULL;
		tens.count = 1;
		tens.data = data;
		return tens;
	} else {
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
    Returns the dot product of two tensors as an integer. This version uses
		tensor combine and fold functions.

  Assumption:
    The two tensors passed in must be the same dimensions and cannot be greater
		than two-dimensional.
*/
int int_dot_product_vtwo(Tensor tOne, Tensor tTwo) {
	return sum(tensor_combine(scalar_multiply,tOne,tTwo));
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
	Tensor tens;

	if (dimOne == dimTwo && dimOne == 1) {
		if (dimSizeOne[0] == dimSizeTwo[0] && dimSizeOne[0] == 3) {
			dim_size = malloc(sizeof(int));
			data = malloc(sizeof(int)*3);
			dim_size[0] = 3;
			data[0] = (dataOne[1] * dataTwo[2]) - (dataOne[2] * dataTwo[1]);
			data[1] = (dataOne[2] * dataTwo[0]) - (dataOne[0] * dataTwo[2]);
			data[2] = (dataOne[0] * dataTwo[1]) - (dataOne[1] * dataTwo[0]);

			tens.dim = 1;
			tens.dim_size = dim_size;
			tens.count = 3;
			tens.data = data;
			return tens;
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
  Description:
    Takes three tensors and calculates the scalar triple product of them. Takes
		the dot product of the first tensor with the cross product of the other two.

  Assumption:
    The tensors passed in must be vectors (dim = 1) with three elements. The
		result will be a scalar tensor (one element, dim = 0).
*/
Tensor scalar_triple_product(Tensor tOne, Tensor tTwo, Tensor tThree) {
	return dot_product(tOne, cross_product(tTwo,tThree));
	/* Note: the shape checking of the last two tensors should happen during the call
		 to cross product (which makes sure the size of each is three). Then, because
		 dot product will make sure the first tensor and the other one are the same
		 shape, that should also be size three. No need to explicitely check shape here.
	*/
}

/*
  Description:
    Takes three tensors and calculates the scalar triple product of them. Takes
		the dot product of the first tensor with the cross product of the other two.

  Assumption:
    The tensors passed in must be vectors (dim = 1) with three elements. The
		result will be the integer calculated.
*/
int int_scalar_triple_product(Tensor tOne, Tensor tTwo, Tensor tThree) {
	return int_dot_product(tOne, cross_product(tTwo,tThree));
	/* Note: the shape checking of the last two tensors should happen during the call
		 to cross product (which makes sure the size of each is three). Then, because
		 dot product will make sure the first tensor and the other one are the same
		 shape, that should also be size three. No need to explicitely check shape here.
	*/
}

/*
  Description:
    Takes three tensors and calculates the vector triple product of them. Takes
		the cross product of the first tensor with the cross product of the other two.

  Assumption:
    The tensors passed in must be vectors (dim = 1) with three elements. The
		returned tensor will also be a vector with three elements.
*/
Tensor vector_triple_product(Tensor tOne, Tensor tTwo, Tensor tThree) {
	return cross_product(tOne,cross_product(tTwo,tThree));
}


/*
  Description:
    Takes a tensor and calculates its trace (summation of all elements along its
		main diagonal). Returns an integer.

  Assumption:
    The tensor passed in is a square matrix, shape [n,n]
*/
int trace(Tensor tens) {
	int i,total;
	int dim = tens.dim;
	int *dim_size = tens.dim_size;
	int count = tens.count;
	int *data = tens.data;

	if (dim == 2) {
		if (dim_size[0] == dim_size[1]) {
			total = 0;
			for (i = 0; i < count; i++) {
				if (i % (dim_size[0] + dim - 1) == 0) { //finds each diagonal
					total += data[i];
				}
			}
			return total;
		} else {
			printf("Tensor passed in to trace is not square");
			return -1;
		}
	} else {
		printf("Tensor passed in to trace is not two dimensions");
		return -1;
	}
}

/*
  Description:
    Takes a tensor and calculates its trace (summation of all elements along its
		main diagonal). Returns a scalar tensor.

  Assumption:
    The tensor passed in is a square matrix, shape [n,n]. Returned tensor is
		scalar, dim = 0
*/
Tensor tensor_trace(Tensor tens) {
	return int_to_scalar_tensor(trace(tens));
}

void free_tensor(Tensor tens) {
	free(tens.data);
	free(tens.dim_size);
}

void free_tensor_dynamic(Tensor *tens) {
	free(tens -> data);
	free(tens -> dim_size);
	free(tens);
}

/*
 * Proper, n-dimensional tensor print
 * Should be written with modular arithmetic to ensure high portability
 * As of now works with 2D and lower, so should run fine instead of using the large print function above
 */
void print_tensor(Tensor input, char * delimiters, int numDelims) {
	if(numDelims < input.dim) {
		printf("Delimiter array has too few delimiters for the current tensor input");
		exit(1);
	}

	int i = 0;
	int j = 0;
	char delimiterToPrint = ',';
	int dimChecker = 1;

	printf("[\n");

	for (; i < input.count; i++) {
		printf("%i", input.data[i]);
		delimiterToPrint = delimiters[0];
		dimChecker = 1;
		for(j = 0; j < input.dim - 1; j++) {
			dimChecker *= input.dim_size[input.dim - j - 1];
			if ((i + 1 ) % dimChecker == 0) {
				delimiterToPrint = delimiters[j + 1];
			} else {
				break;
			}
		}
		printf("%c", delimiterToPrint);
	}

	printf("\n]");
	printf("\n%i dimensions in this tensor\n", input.dim);
	printf("Dimensions are: [");
	for (i = 0; i < input.dim; i++) {
		printf("%i, ",  input.dim_size[i]);
	}
	printf("]\n\n");
}

void print_tensor_alternate(Tensor input, char * delimiters, int numDelims) {
	if(numDelims < input.dim) {
		printf("Delimiter array has too few delimiters for the current tensor input");
		exit(1);
	}

	int i = 0;
	int j = 0;
	char delimiterToPrint = ',';
	int dimChecker = 1;

	printf("[\n");

	for (; i < input.count; i++) {
		printf("%i", input.data[i]);
		delimiterToPrint = delimiters[0];
		dimChecker = 1;
		for(j = input.dim - 1; j >= 0; j--) {
			dimChecker *= input.dim_size[input.dim - 1 - j];
			if ((i + 1 ) % dimChecker == 0) {
				delimiterToPrint = delimiters[input.dim - j];
			} else {
				break;
			}
		}
		printf("%c", delimiterToPrint);
	}
	printf("]\n\n");
	printf("\n]");
	printf("\n%i dimensions in this tensor\n", input.dim);
	printf("Dimensions are: [");
	for (i = 0; i < input.dim; i++) {
		printf("%i, ",  input.dim_size[i]);
	}
	printf("]\n\n");
}
