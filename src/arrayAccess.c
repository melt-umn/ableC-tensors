#include <stdio.h>
#include <stdlib.h>
#include "../include/tensorsLib.h"
#include <errno.h>
#include <math.h>

//assumes indices is same size as tensor dim
Tensor access_tensor_vtwo(Tensor tens, Interval *indices) {
  int x,y,z,j;

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
    for (x = 0; x < newDim; x++) {
      newCount *= newDimSize[x];
    }

    //transfer the data in (j is index of new data, i is index of old data)
    newData = malloc(sizeof(int)*newCount);
    for (x = indices[0].lBound,j=0; x <= indices[0].rBound; x++,j++) {
      newData[j] = data[x];
    }
  }

  if (dim == 2) { //2 dim
    newDim = 2;
    newDimSize = malloc(sizeof(int)*newDim);

    newDimSize[0] = 1 + indices[0].rBound - indices[0].lBound;
    newDimSize[1] = 1 + indices[1].rBound - indices[1].lBound;
    newCount = 1;

    //number of elems
    for (x = 0; x < newDim; x++) {
      newCount *= newDimSize[x];
    }

    //transfer the data in (j is index of new data, i is index of old data)
    newData = malloc(sizeof(int)*newCount);
    j = 0;
    for (x = indices[0].lBound; x <= indices[0].rBound; x++) { //row?
      for (y = indices[1].lBound; y <= indices[1].rBound;y++) { //col?
        newData[j] = data[y + dim_size[0]*x]; //col + row_size * row
        j++;
      }
    }
  }

  if (dim == 3) { //3 dim
    newDim = 3;
    newDimSize = malloc(sizeof(int)*newDim);

    newDimSize[0] = 1 + indices[0].rBound - indices[0].lBound;
    newDimSize[1] = 1 + indices[1].rBound - indices[1].lBound;
    newDimSize[2] = 1 + indices[2].rBound - indices[2].lBound;
    newCount = 1;

    //number of elems
    for (x = 0; x < newDim; x++) {
      newCount *= newDimSize[x];
    }

    //transfer the data in (j is index of new data, i is index of old data)
    newData = malloc(sizeof(int)*newCount);
	j = 0;
    for (x = indices[0].lBound; x <= indices[0].rBound; x++) { //row
      for (y = indices[1].lBound; y <= indices[1].rBound;y++) { //col
        for (z = indices[2].lBound; z <= indices[2].rBound;z++) //depth
        newData[j++] = data[x + y * dim_size[0] + z * dim_size[0] * dim_size[1]];
      }
    }
  }
  newTens.dim = newDim;
  newTens.dim_size = newDimSize;
  newTens.count = newCount;
  newTens.data = newData;

  return newTens;



// 3 dim:
}
