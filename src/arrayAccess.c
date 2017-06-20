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
  int *data = tens.data;

  Tensor newTens;
  int newDim;
  int *newDimSize;
  int newCount;
  int *newData;

// 1 dim:
  if (dim == 1) {
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
    newDim = 2;
    newDimSize = malloc(sizeof(int)*newDim);

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
        newData[j] = data[k + dim_size[0]*i];
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
