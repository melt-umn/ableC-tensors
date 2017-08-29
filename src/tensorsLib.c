//Written by Ankit Siva and Zoe Wentzel
//Parts copied from edu.umn.cs.melt.exts.ableC.matlab

#include <stdio.h>
#include <stdlib.h>
#include "../include/tensorsLib.h"
#include <errno.h>
#include <math.h>
#include <string.h>
#include <cilk/cilk.h>

#define FLT_MIN 1.175494e-38
#define FLT_MAX 3.402823e+38

char delimiters[10] = {',', ';', '/', '-', '!', '@', '#', '%', '^', '&'};
char delimiters_alternate[10] = {'&', '^', '%', '#', '@', '!', '-', ';', '/', ','};


/*
 * Description:
 * Creates an interval given a left and right bound. Left and right dimensions
 * must both be 0 or greater. This function should only be called by other functions
 * and not by the user correctly. If the user calls it, no error checking is given.
 *
 * Assumption:
 * The left boundary must be zero or greater. The right boundary must either be
 * greater than the left boundary or equal to negative one—if it is negative one,
 * it represents the furthermost right index of the tensor it is used with.
*/
Interval create_interval_double_bound_hidden(int left, int right) {
	Interval inter;
	inter.lBound = left;
	inter.rBound = right;
	return inter;
}

/*
 * Description:
 * Creates an interval given only a left bound (left bound must be 0 or greater)
 *
 * Assumption:
 * Left bound must be 0 or greater — is checked for — and within range of the
 * Tensor it will be used on (not checked at interval creation). In addition,
 * the lack of right bound assumes user wishes to stop indexing at the furthermost
 * right index.
*/
Interval create_interval_double_bound(int left, int right) {
	if (left >= 0) { //left bound must be zero or greater
		if (left <= right) { //right bound must be greater or equal to left bound
			return create_interval_double_bound_hidden(left,right);
		} else {
			printf("\n\nLeft interval index must be less than or equal to right interval index\n\n");
			exit(1);
		}
	} else {
		printf("\n\nInterval dimensions must be positive\n\n");
		exit(1);
	}
}

/*
 * Description:
 * Creates an interval given only a left bound (left bound must be 0 or greater)
 *
 * Assumption:
 * Left bound must be 0 or greater — is checked for — and within range of the
 * Tensor it will be used on (not checked at interval creation). In addition,
 * the lack of right bound assumes user wishes to stop indexing at the furthermost
 * right index.
*/
Interval create_interval_left_bound(int left) {
	if (left >= 0) {
		return create_interval_double_bound_hidden(left,-1);
	} else {
		printf("\n\nInterval dimensions must be positive\n\n");
		exit(1);
	}
}

/*
 * Description:
 * Creates an interval given only a right bound (right bound must be 0 or greater)
 *
 * Assumption:
 * Right bound must be 0 or greater — is checked for — and within range of the
 * Tensor it will be used on (not checked at interval creation). In addition,
 * the lack of left bound assumes user wishes to start the left bound at 0.
*/
Interval create_interval_right_bound(int right) {
	if (right >= 0) {
		return create_interval_double_bound_hidden(0, right);
	} else {
		printf("\n\nInterval dimensions must be positive\n\n");
		exit(1);
	}
}

/*
 * Description:
 * Creates an interval given no bounds
 *
 * Assumption:
 * This will return an interval with a left bound of 0 and a rightbound of
 * -1, which represents the furthermost right index of the Tensor.
*/
Interval create_interval_no_bound() {
	return create_interval_double_bound_hidden(0,-1);
}

/*
 * Description:
 * Creates a Tensor in which each field of the tensor struct is passed in
 *
 * Assumption:
 * everything is passed in correctly
*/
Tensor create(int dim, int *dim_size, int count, float *data) {
	Tensor newTens;
	newTens.dim = dim;
	newTens.dim_size = dim_size;
	newTens.count = count;
	newTens.data = data;
	return newTens;
}

/*
 * Description:
 * Takes a tensor and an integer list and indexes the tensor using that list
 *
 * Assumption:
 * Number of dimensions in the tensor matches the length of the index list
*/
float float_access(Tensor tens, int *indices) {
  int j,currentIndex,currentSum,currentProd,downTo,k;
  int dim = tens.dim;
  int *dim_size = tens.dim_size;
  float *data = tens.data;

  currentSum = 0;
  currentIndex = 0;
  downTo = 0;

  for (k = 0; k < dim; k++) { //add dim times
    currentProd = 1; //reset currentProduct
    //goes from smallest dim_size to smallest_one wanted
    for (j = dim - 1; j > downTo; j--) {
      currentProd *= dim_size[j];
    }
    downTo++; //won't go as low next time
    //multiply it by largest index, currentIndex goes up
    currentProd *= indices[currentIndex++];
    //add the product to our sum thusfar, last time will be just the smallest index
    currentSum += currentProd;
  }
  return data[currentSum];
}

/*
 * Description:
 * Takes a tensor and an interval list and indexes the tensor using that list
 * If the right bound of an index is -1, it represents the right most index
 * in that field of the tensor (negative indices, like Python, not allowed here).
 *
 * Assumption:
 * Number of dimensions in the tensor matches the length of the interval list
*/
Tensor accessT(Tensor tens, Interval *interIndices) {
  int k,j,z,flag;
  int currentChangingDim; //innermost dimension changing
  int largestChangingDim;
  int dim = tens.dim;
  Tensor newTens;
  int newDim;
  int *newDimSize;
  int newCount;
  float *newData;
  int *intIndices;
  flag = 0;

  newDim = dim; //dims won't change in this version
  newDimSize = malloc(sizeof(int)*newDim); //malloc space

	// whenever the rBound of interIndices is 0, it needs to change to the
	// dim - 1 of the corresponding dimension of the tensor. An rBound of -1
	// represents going to the rightmost boundary of the tensor
	for (k = 0; k < dim; k++) {
		if (interIndices[k].rBound == -1) {
			interIndices[k].rBound = tens.dim_size[k] - 1;
		}
	}

  for (k = 0; k < newDim; k++) { //fill it based on bounds (1 + because inclusivity)
    newDimSize[k] = 1 + interIndices[k].rBound - interIndices[k].lBound;
  }
  newCount = 1;
  for (k = 0; k < newDim; k++) { //total elements is each dim multiplied
    newCount *= newDimSize[k];
  }
  newData = malloc(sizeof(float)*newCount); //need enough memory in data for each element



  //assumes every dimension needed in intervals is passed in
  intIndices = malloc(sizeof(int)*dim);
  Interval *interIndicesCopy = malloc(sizeof(Interval)*dim);
  for (k = 0; k < dim; k++) { //copy the interval, keep original for reference
    interIndicesCopy[k] = interIndices[k];
  }
	memcpy(interIndicesCopy, interIndices, dim * sizeof(int));
  currentChangingDim = dim - 1; //start with rightmost dimension
  largestChangingDim = dim - 1; //largset changing dim is also rightmost dimension
  for (k = 0; k < newCount; k++) { //loop until we get every element
    //starts with minimum of each interval, lBound changes as this loops
    for (j = 0; j < dim; j++) {
      intIndices[j] = interIndicesCopy[j].lBound;
    }
    newData[k] = float_access(tens, intIndices); //find the int at the current indice
    //changing the farthest element possible to the right
    if (interIndicesCopy[currentChangingDim].lBound != interIndicesCopy[currentChangingDim].rBound) {
      interIndicesCopy[currentChangingDim].lBound++; //left bound gets higher
    } else if (currentChangingDim != largestChangingDim) {
			if (currentChangingDim != 0) {
				currentChangingDim--;
			}
      while (newDimSize[currentChangingDim] == 1) {
        //if the dim at that spot is 1, must keep going (otherwise cannot add one to it)
        //should not overpass largestChangingDim since it does the same thing
        currentChangingDim--;
      }
      while (currentChangingDim != 0 && interIndicesCopy[currentChangingDim].lBound == interIndicesCopy[currentChangingDim].rBound) {
        //if the dim at that spot is 1, must keep going (otherwise cannot add one to it)
        //should not overpass largestChangingDim since it does the same thing
				if (largestChangingDim == currentChangingDim) {
					largestChangingDim--;
					flag = 1;
				}
        currentChangingDim--;
      }
      for (z = currentChangingDim; z < dim; z++) {
        //reset all indices from the current one to the last one
        //(this is the reason we needed a copy)
        interIndicesCopy[z].lBound = interIndices[z].lBound;
      }
      interIndicesCopy[currentChangingDim].lBound += 1;
      if (flag) {
        currentChangingDim = dim - 1;
      }
      //largest changing index has not changed
    } else {
      //currentChangingDim == largestChangingDim
      for (z = currentChangingDim; z < dim; z++) {//looking at left most changing
        //reset all indices from the current one to the last one
        interIndicesCopy[z].lBound = interIndices[z].lBound;
      }
      currentChangingDim = dim - 1; //reset current to right most dimension
      largestChangingDim--;
      while (largestChangingDim > 0 && newDimSize[largestChangingDim] == 1) {
        largestChangingDim--;
      }
			if (currentChangingDim != 0) {
				interIndicesCopy[largestChangingDim].lBound += 1; //change the first dimension that's greater than 1
			}
		}
  }
  newTens.dim = newDim;
  newTens.dim_size = newDimSize;
  newTens.count = newCount;
  newTens.data = newData;
  return newTens;
}

/*
 * Description:
 * Takes a Tensor and returns a duplicate of it in a new space in memory.
 * Can be useful since Tensor functions, such as map, work on it as mutable
 * data. By copying the Tensor first, it can be modified without getting
 * rid of previous data.
 */

Tensor copy(Tensor tens) {
	Tensor newTens;

	newTens.dim = tens.dim;
	newTens.count = tens.count;

	newTens.data = malloc(sizeof(float)*newTens.count);
	newTens.dim_size = malloc(sizeof(int)*newTens.dim);

	memcpy(newTens.data, tens.data, tens.count * sizeof(float));
	memcpy(newTens.dim_size, tens.dim_size, tens.dim * sizeof(int));
	return newTens;
}

/*
  Description:
    Takes a tensor and transposes it (rows and columns are swapped)

  Assumption:
    The tensors passed in must be <= two dimensions and the returned tensor
		will have the same dimensions, but swapped. Does NOT mutate the actual tensor.
*/
Tensor trans(Tensor tens) {
	int i,j,currentCount;

	Tensor newTens;
	newTens.count = tens.count;
	newTens.data = malloc(sizeof(float)*tens.count); //malloc space for data

	if (tens.dim == 2) {
		newTens.dim = 2;
		newTens.dim_size = malloc(sizeof(int)*2);
		newTens.dim_size[0] = tens.dim_size[1];
		newTens.dim_size[1] = tens.dim_size[0];
		currentCount = 0;
		for (i = 0; i < newTens.dim_size[0]; i++) { //col / row
			for (j = 0; j < newTens.dim_size[1]; j++) { //row / col
				newTens.data[currentCount++] = tens.data[i + tens.dim_size[1]*j]; //fixed transpose :D
			}
		}
		return newTens;
	} else {
		printf("\n\nToo many dimensions to transpose\n\n");
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
Tensor id(int numDimensions, int dim_len){
	int i = 0;
	Tensor tensor;
	tensor.count = pow(dim_len, numDimensions);
	tensor.data = malloc(sizeof(float)*tensor.count);

	for (i = 0; i < tensor.count; i++) {
		if (i % (dim_len + numDimensions - 1) == 0) {
			tensor.data[i] = 1;
		} else {
			tensor.data[i] = 0;
		}
	}

	tensor.dim = numDimensions;
	tensor.dim_size = malloc(sizeof(int)*numDimensions);

	for (i = 0; i < numDimensions; i++) {
		tensor.dim_size[i] = dim_len;
	}
	return tensor;
}

/*
 * Description:
 * Take the number of dimensions, a pointer to the dimension tensor, and the
 * number to fill the tensor with
 *
 * Assumption:
 * Tensor returned will have the value of the given number in all dimensions
 */
Tensor fill(int dim, int *dim_size, float toFill) {
	int i;
	Tensor tens;
	tens.dim = dim;
	tens.dim_size = dim_size;
	tens.count = 1; //if dim is 0 (scalar), count will still be one

	for (i = 0; i < dim; i++) {
		tens.count *= dim_size[i]; //multiply number of elements by the dimensions
	}

	tens.data = malloc(sizeof(float)*tens.count); //malloc space for each element

	for (i = 0; i < tens.count; i++) {
		tens.data[i] = toFill; //fill tensor with the given number
	}


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
	return fill(dim,dim_size,1);
}

/*
  Description:
    Take the number of dimensions and a pointer to the dimension tensor to
		return a tensor of that shape full of zeros

  Assumption:
    Tensor returned will have zeros in all dimensions
*/
Tensor zeros(int dim, int *dim_size) {
	return fill(dim,dim_size,0);
}

/*
  Description:
    Takes an integer and turns it into a 0 dimensional, single element tensor

  Assumption:
    The returned tensor will have a dim of 0, a dim_size of null, and a count
		of 1. It's only data will be the given integer.
*/
Tensor float_to_ten(float i) {
	float *data;
	int *dim_size;
	data = malloc(sizeof(float));
    dim_size = malloc(sizeof(int));

	Tensor tens;

	data[0] = i;
	dim_size[0] = 1;

	tens.dim = 1;
	tens.dim_size = dim_size;
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
float ten_to_float(Tensor a) {
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

Tensor map(float (*fun)(float), Tensor tens) {
	int i;
	for (i = 0; i < tens.count; i++) {
 		tens.data[i] = (*fun)(tens.data[i]);
 	}
	return tens;
}

/*
  Description:
    Takes a function and a Tensor and performs that function on every
		element in the Tensor. Uses cilk for parallel goodness.

  Assumption:
    The given function must handle integers and the returned Tensor will be
		the same shape as the one passed in. Will mutate the tensor itself, will
		not return a new tensor.
*/

Tensor map_cilk(float (*fun)(float), Tensor tens) {
	cilk_for (int i = 0; i < tens.count; i++) {
 		tens.data[i] = (*fun)(tens.data[i]);
 	}
	return tens;
}


//same as previous map but with context that allows more intense/general map functions
Tensor map_with_context(float (*fun)(float,void*), Tensor tens, void *context) {
	int i;
	for (i = 0; i < tens.count; i++) {
 		tens.data[i] = (*fun)(tens.data[i],context);
 	}
	return tens;
}

//same as previous map but with context that allows more intense/general map functions and cilk
Tensor map_with_context_cilk(float (*fun)(float,void*), Tensor tens, void *context) {
	cilk_for (int i = 0; i < tens.count; i++) {
 		tens.data[i] = (*fun)(tens.data[i],context);
 	}
	return tens;
}

Tensor square(Tensor tens) {
	return map(scalar_square,tens);
}

Tensor square_cilk(Tensor tens) {
	return map_cilk(scalar_square,tens);
}

Tensor incr(Tensor tens) {
	return map(plus_one,tens);
}

Tensor incr_cilk(Tensor tens) {
	return map_cilk(plus_one,tens);
}

Tensor negate(Tensor tens) {
	return map(times_negative_one,tens);
}

Tensor negate_cilk(Tensor tens) {
	return map_cilk(times_negative_one,tens);
}

float plus_one(float i) {
	return i + 1;
}

float times_negative_one(float i) {
	return i * -1;
}

float scalar_square(float i) {
	return i * i;
}

float scalar_add(float i, float j) {
	return i + j;
}

float scalar_subtract(float i, float j) {
	return i - j;
}

float scalar_multiply(float i, float j) {
	return i * j;
}

float scalar_divide(float i, float j) {
	if (j != 0) {
		return i / j;
	} else {
		printf("Error, cannot scalar divide by zero\n");
		exit(1);
	}
}

float greater_than(float i, float j) {
	if (i > j) {
		return i;
	} else {
		return j;
	}
}

float lesser_than(float i, float j) {
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
Tensor ten_fold(float (*fun)(float,float), Tensor current, Tensor tens){
	int i;

	if (current.count == 1) {
		if (current.dim == 0) { //dim needs to be 0, a [1] tensor will not work
				Tensor newTens;
				newTens.data = malloc(sizeof(float));
				newTens.data[0] = current.data[0];

				for (i = 0; i < tens.count; i++) {
					newTens.data[0] = (*fun)(tens.data[i],newTens.data[0]);
				}

				newTens.dim = 0;
				newTens.dim_size = NULL;
				newTens.count = 1;
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
float fold(float (*fun)(float,float), float current, Tensor tens){
	int i;

	for (i = 0; i < tens.count; i++) {
		current = (*fun)(tens.data[i],current);
	}
	return current;
}

float max(Tensor tens) {
	return fold(greater_than,FLT_MIN,tens);
}

float min(Tensor tens) {
	return fold(lesser_than,FLT_MAX,tens);
}

float sum(Tensor tens) {
	return fold(scalar_add,0,tens);
}

float prod(Tensor tens) {
	return fold(scalar_multiply,1,tens);
}

Tensor ten_max(Tensor tens) {
	return float_to_ten(max(tens));
}

Tensor ten_min(Tensor tens) {
	return float_to_ten(min(tens));
}

Tensor ten_sum(Tensor tens) {
	return float_to_ten(sum(tens));
}

Tensor ten_prod(Tensor tens) {
	return float_to_ten(prod(tens));
}

/*
 * Description:
 * Creates a new tensor using a function and two other tensors
 *
 * Assumption:
 * two tensors must be the sameshape and the function must deal with ints
 * does not mutate either tensor passed in
*/
Tensor ten_combine(float (*fun)(float,float), Tensor tOne, Tensor tTwo) {
	int i;
	if (tOne.dim == tTwo.dim) {
		for (i = 0; i < tOne.dim; i++) {
			if (tOne.dim_size[i] != tTwo.dim_size[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}

		Tensor tens;
		tens.count = tOne.count;
		tens.data = malloc(sizeof(float)*tOne.count);
		tens.dim = tOne.dim;
		tens.dim_size = malloc(sizeof(int)*tOne.dim);

		memcpy(tens.dim_size, tOne.dim_size, sizeof(int)*tOne.dim);

		for (i = 0; i < tens.count; i++) {
			tens.data[i] = (*fun)(tOne.data[i], tTwo.data[i]);
		}

		return tens;

	} else {
		printf("The two tensors have a different number of dimensions\n");
		exit(1);
	}
}

/*
 * Description:
 * Creates a new tensor using a function and two other tensors, identical to last function but uses cilk
 *
 * Assumption:
 * two tensors must be the sameshape and the function must deal with ints
 * does not mutate either tensor passed in
*/
Tensor ten_combine_cilk(float (*fun)(float,float), Tensor tOne, Tensor tTwo) {
	int i;
	if (tOne.dim == tTwo.dim) {
		for (i = 0; i < tOne.dim; i++) {
			if (tOne.dim_size[i] != tTwo.dim_size[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}

		Tensor tens;
		tens.count = tOne.count;
		tens.data = malloc(sizeof(float)*tOne.count);
		tens.dim = tOne.dim;
		tens.dim_size = malloc(sizeof(int)*tOne.dim);

		memcpy(tens.dim_size, tOne.dim_size, sizeof(int)*tOne.dim);

		cilk_for (i = 0; i < tens.count; i++) {
			tens.data[i] = (*fun)(tOne.data[i], tTwo.data[i]);
		}

		return tens;

	} else {
		printf("The two tensors have a different number of dimensions\n");
		exit(1);
	}
}

Tensor ten_elem_add(Tensor tOne, Tensor tTwo) {
	return ten_combine(scalar_add,tOne,tTwo);
}

Tensor ten_elem_add_cilk(Tensor tOne, Tensor tTwo) {
	return ten_combine_cilk(scalar_add,tOne,tTwo);
}

Tensor ten_elem_subtract(Tensor tOne, Tensor tTwo) {
	return ten_combine(scalar_subtract,tOne,tTwo);
}

Tensor ten_elem_subtract_cilk(Tensor tOne, Tensor tTwo) {
	return ten_combine_cilk(scalar_subtract,tOne,tTwo);
}

Tensor ten_elem_multiply(Tensor tOne, Tensor tTwo) {
	return ten_combine(scalar_multiply,tOne,tTwo);
}

Tensor ten_elem_multiply_cilk(Tensor tOne, Tensor tTwo) {
	return ten_combine_cilk(scalar_multiply,tOne,tTwo);
}

Tensor ten_elem_divide(Tensor tOne, Tensor tTwo) {
	return ten_combine(scalar_divide,tOne,tTwo);
}

Tensor ten_elem_divide_cilk(Tensor tOne, Tensor tTwo) {
	return ten_combine_cilk(scalar_divide,tOne,tTwo);
}

/*
 * Description:
 * Sees if two tensors are equivalent (size and data)
 *
 * Assumption:
 * two tensors must be the same shape and the function must deal with floats
 * does not mutate either tensor passed in
*/
bool ten_equals(Tensor tOne, Tensor tTwo) {
	int i;
	int *dimSizeOne = tOne.dim_size;
	int *dimSizeTwo = tTwo.dim_size;
	if (tOne.dim == tTwo.dim) { //make sure # of dimensions are same
		for (i = 0; i < tOne.dim; i++) { //make sure size of dimensions are same
			if (dimSizeOne[i] != dimSizeTwo[i]) {
				return false;
			}
		}
		for (i = 0; i < tOne.count; i++) { //make sure each element in the same
			if (tOne.data[i] != tTwo.data[i]) {
				return false;
			}
		}
		return true;
	} else {
		return false;
	}
}

bool ten_not_equals(Tensor tOne, Tensor tTwo) {
	if (ten_equals(tOne,tTwo) == true) {
		return false;
	}
	return true;
}

Tensor ten_multiply(Tensor tOne, Tensor tTwo) {
	int i,j,k,z,currentCount;
	int dimOne = tOne.dim;
	int dimTwo = tTwo.dim;
	int *dimSizeOne = tOne.dim_size;
	int *dimSizeTwo = tTwo.dim_size;
	float *dataOne = tOne.data;
	float *dataThree;

	int newDim;
	int *newDimSize;
	int newCount;
	float *newData;

	Tensor newTens;
	Tensor tempOne;
	Tensor tempTwo;

	//temp tensors are used to pass into dot product
	// int tempOneDim;
	int *tempOneDimSize;
	float *tempOneData;

	// int tempTwoDim;
	int *tempTwoDimSize;
	float *tempTwoData;

	if (dimOne == 2 && dimTwo == 2) { //must be a 2d matrix
		if (dimSizeOne[1] == dimSizeTwo[0]) { //tensor one is n x m, tensor two is m x p
			newDim = 2;
			newDimSize = malloc(sizeof(int)*2);
			newDimSize[0] = dimSizeOne[0];
			newDimSize[1] = dimSizeTwo[1]; //new tensor is n x p
			newCount = dimSizeOne[0] * dimSizeTwo[1];
			newData = malloc(sizeof(int)*newCount);

			Tensor tThree = trans(tTwo); //tThree will now be p x m
			dataThree = tThree.data;

			tempOneDimSize = malloc(sizeof(int)*2);
			tempOneDimSize[0] = 1;
			tempOneDimSize[1] = dimSizeOne[1];
			tempOneData = malloc(sizeof(int)*dimSizeOne[1]);

			tempTwoDimSize = malloc(sizeof(int)*2);
			tempTwoDimSize[0] = 1;
			tempTwoDimSize[1] = dimSizeOne[1];
			tempTwoData = malloc(sizeof(int)*dimSizeOne[1]);

			currentCount = 0;
			for (i = 0; i < dimSizeOne[0]; i++) { //choose row
				for (j = 0; j < dimSizeTwo[1]; j++) { //choose "column"
					k = 0;
					for (z = 0; z < dimSizeOne[1]; z++) { //choose element
						tempOneData[k] = dataOne[dimSizeOne[1] * i + z];
						tempTwoData[k++] = dataThree[dimSizeOne[1] * j + z];
					}
					tempOne.dim = 2;
					tempOne.dim_size = tempOneDimSize;
					tempOne.count = dimSizeOne[1];
					tempOne.data = tempOneData;

					tempTwo.dim = 2;
					tempTwo.dim_size = tempTwoDimSize;
					tempTwo.count = dimSizeOne[1];
					tempTwo.data = tempTwoData;
					newData[currentCount++] = float_dot_product_vtwo(tempOne,tempTwo);
				}
			}
			newTens.dim = newDim;
			newTens.dim_size = newDimSize;
			newTens.count = newCount;
			newTens.data = newData;
			return newTens;
		} else {
			printf("Tensors multiplied must be n x m and m x p\n");
			exit(1);
		}
	} else {
		printf("Tensors multiplied must be two-dimensional\n");
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
	return float_to_ten(float_dot_product(tOne,tTwo));
	//this code worked before and somehow broke...
	/*int i;
	float sum;

	//used for return scalar tensor;
	Tensor tens;
	tens.dim = 0;
	tens.dim_size = NULL;
	tens.count = 1;

	sum = 0;

	if (tOne.dim == tTwo.dim) {
		for (i = 0; i < tOne.dim; i++) {
			if (tOne.dim_size[i] != tTwo.dim_size[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}

		for (i = 0; i < tOne.count; i++) {
			sum += tOne.data[i] * tTwo.data[i];
		}
		tens.data = &sum;

		return tens;

	} else {
		printf("The two tensors have a different number of dimensions\n");
		exit(1);
	}*/
}

/*
  Description:
    Returns the dot product of two tensors as an integer.

  Assumption:
    The two tensors passed in must be the same dimensions and cannot be greater
		than two-dimensional.
*/
float float_dot_product(Tensor tOne, Tensor tTwo) {
	//return scalar_tensor_to_float(dot_product(tOne,tTwo)); //wastes memory, but
	//also less code (is it worth it to call it? small amount of wasted time as well)
	int i;
	float sum;
	sum = 0;

	if (tOne.dim == tTwo.dim) {
		for (i = 0; i < tOne.dim; i++) {
			if (tOne.dim_size[i] != tTwo.dim_size[i]) {
				printf("The two tensors have different length of dimensions\n");
				exit(1);
			}
		}
		for (i = 0; i < tOne.count; i++) {
			sum += tOne.data[i] * tTwo.data[i];
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
float float_dot_product_vtwo(Tensor tOne, Tensor tTwo) {
	return sum(ten_combine(scalar_multiply,tOne,tTwo));
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
	Tensor tens;

	if (tOne.dim == tTwo.dim && tOne.dim == 1) {
		if (tOne.dim_size[0] == tTwo.dim_size[0] && tOne.dim_size[0] == 3) {
			tens.dim_size = malloc(sizeof(int));
			tens.data = malloc(sizeof(float)*3);
			tens.dim_size[0] = 3;
			tens.data[0] = (tOne.data[1] * tTwo.data[2]) - (tOne.data[2] * tTwo.data[1]);
			tens.data[1] = (tOne.data[2] * tTwo.data[0]) - (tOne.data[0] * tTwo.data[2]);
			tens.data[2] = (tOne.data[0] * tTwo.data[1]) - (tOne.data[1] * tTwo.data[0]);

			tens.dim = 1;
			tens.count = 3;
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
float float_triple_product(Tensor tOne, Tensor tTwo, Tensor tThree) {
	return float_dot_product(tOne, cross_product(tTwo,tThree));
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
float trace(Tensor tens) {
	int i,total;

	if (tens.dim == 2) {
		if (tens.dim_size[0] == tens.dim_size[1]) {
			total = 0;
			for (i = 0; i < tens.count; i++) {
				if (i % (tens.dim_size[0] + tens.dim - 1) == 0) { //finds each diagonal
					total += tens.data[i];
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
Tensor ten_trace(Tensor tens) {
	return float_to_ten(trace(tens));
}

void freeT(Tensor tens) {
	free(tens.data);
	free(tens.dim_size);
}

void freeT_dynamic(Tensor *tens) {
	free(tens -> data);
	free(tens -> dim_size);
	free(tens);
}

/*
 * Proper, n-dimensional tensor print
 * Should be written with modular arithmetic to ensure high portability
 * As of now works with 2D and lower, so should run fine instead of using the large print function above
 */
void printT_extended(Tensor input, char * delimiters, int numDelims) {
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
		printf("%f", input.data[i]);
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

void printT(Tensor input) {
  printT_extended(input, delimiters, 10);
}

/*
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
*/

//For now only works on square matrices
/*void LU_Decomp(Tensor toDecompose, Tensor *L, Tensor *U) {
  int i = 0;
  int j = 0;

  if (toDecompose.dim != 2 && toDecompose.dim_size[0] == toDecompose.dim_size[1]) {
    printf("\n\nCannot work on any tensor except those that are 2-dimensional\n\n");
    exit(1);
  }

  //In case they hold any data that we shouldn't have

  *L = create_identity_tensor(toDecompose.dim, toDecompose.dim_size[0]);
  *U = zeros(toDecompose.dim, toDecompose.dim_size);

  print_tensor(toDecompose, delimiters, 10);
}*/
