#include <stdio.h>
#include <stdlib.h>
#include "../include/tensorsLib.h"
#include <errno.h>
#include <math.h>



//assumes indices is same size as tensor dim
Tensor access_tensor_vtwo(Tensor tens, Interval *indices) {
  int i,j,k;

  int dim = tens.dim;
  int *dim_size = tens.dim_size;
  int count = tens.count;
  int *data = tens.data;

  Tensor newTens;
  int newDim;
  int *newDimSize;
  int newCount;
  int *newData;

// 1 dim:
  if (dim == 1) {
    printf("one dim \n");
    newDim = 1;
    newDimSize = malloc(sizeof(int)*newDim);
    newDimSize[0] = 1 + indices[0].rBound - indices[0].lBound;
    newCount = 1;

    //number of elems
    for (i = 0; i < newDim; i++) {
      newCount *= newDimSize[i];
    }

    //transfer the data in (j is index of new data, i is index of old data)
    newData = malloc(sizeof(int)*newCount);
    for (i = indices[0].lBound,j=0; i <= indices[0].rBound; i++,j++) {
      newData[j] = data[i];
    }
  }

  if (dim == 2) {
    printf("two dims \n");
    newDim = 2;
    newDimSize = malloc(sizeof(int)*newDim);
    printf("indices[0].rbound = %d\n",indices[0].rBound);
    printf("indices[0].lbound = %d\n",indices[0].lBound);

    newDimSize[0] = 1 + indices[0].rBound - indices[0].lBound;
    newDimSize[1] = 1 + indices[1].rBound - indices[1].lBound;
    newCount = 1;



    //number of elems
    for (i = 0; i < newDim; i++) {
      newCount *= newDimSize[i];
    }

    //transfer the data in (j is index of new data, i is index of old data)
    newData = malloc(sizeof(int)*newCount);
    for (i = indices[0].lBound,j=0; i <= indices[0].rBound; i++) {
      for (k = indices[1].lBound; k <= indices[1].rBound;k++,j++) {
        newData[j] = data[i + dim_size[0]*k];
      }
    }
  }


  newTens.dim = newDim;
  newTens.dim_size = newDimSize;
  newTens.count = newCount;
  newTens.data = newData;

  return newTens;

// 2 dim:


// 3 dim:
}

Tensor create_tensor(int dim, int *dim_size, int count, int *data) {
	Tensor newTens;
	newTens.dim = dim;
	newTens.dim_size = dim_size;
	newTens.count = count;
	newTens.data = data;
	return newTens;
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
