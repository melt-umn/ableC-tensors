#include <stdio.h>
#include <stdlib.h>
#include "../include/tensorsLib.h"
#include <errno.h>
#include <math.h>

int int_access_tensor(Tensor tens, int *indices) {
  int j,currentIndex,currentSum,currentProd,downTo,k;
  int dim = tens.dim;
  int *dim_size = tens.dim_size;
  int *data = tens.data;

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

Tensor access_tensor_vtwo(Tensor tens, Interval *interIndices) {
  int k,j,z;
  int currentChangingDim; //innermost dimension changing
  int largestChangingDim;
  int dim = tens.dim;
  Tensor newTens;
  int newDim;
  int *newDimSize;
  int newCount;
  int *newData;
  int *intIndices;

  newDim = dim; //dims won't change in this version
  newDimSize = malloc(sizeof(int)*newDim); //malloc space
  for (k = 0; k < newDim; k++) { //fill it based on bounds (1 + because inclusivity)
    newDimSize[k] = 1 + interIndices[k].rBound - interIndices[k].lBound;
  }
  newCount = 1;
  for (k = 0; k < newDim; k++) { //total elements is each dim multiplied
    newCount *= newDimSize[k];
  }
  newData = malloc(sizeof(int)*newCount); //need enough memory in data for each element

  //assumes every dimension needed in intervals is passed in
  intIndices = malloc(sizeof(int)*dim);
  Interval *interIndicesCopy = malloc(sizeof(Interval)*dim);
  for (k = 0; k < dim; k++) { //copy the interval, keep original for reference
    interIndicesCopy[k] = interIndices[k];
  }
  currentChangingDim = dim - 1; //start with rightmost dimension
  largestChangingDim = dim - 1; //largset changing dim is also rightmost dimension
  for (k = 0; k < newCount; k++) { //loop until we get every element
    //starts with minimum of each interval, lBound changes as this loops
    for (j = 0; j < dim; j++) {
      intIndices[j] = interIndicesCopy[j].lBound;
    }
    newData[k] = int_access_tensor(tens, intIndices); //find the int at the current indices

    //changing the farthest element possible to the right
    if (interIndicesCopy[currentChangingDim].lBound != interIndicesCopy[currentChangingDim].rBound) {
      interIndicesCopy[currentChangingDim].lBound++; //left bound gets higher
    } else if (currentChangingDim != largestChangingDim) {
      for (z = currentChangingDim; z < dim; z++) {
        //reset all indices from the current one to the last one
        //(this is the reason we needed a copy)
        interIndicesCopy[z].lBound = interIndices[z].lBound;
      }
      currentChangingDim--;
      while (newDimSize[currentChangingDim] == 1) {
        //if the dim at that spot is 1, must keep going (otherwise cannot add one to it)
        //should not overpass largestChangingDim since it does the same thing
        currentChangingDim--;
      }
      interIndicesCopy[currentChangingDim].lBound += 1;
      //largest changing index has not changed
    } else {
      //currentChangingDim == largestChangingDim
      for (z = currentChangingDim; z < dim; z++) {//looking at left most changing
        //reset all indices from the current one to the last one
        interIndicesCopy[z].lBound = interIndices[z].lBound;
      }
      currentChangingDim = dim - 1; //reset current to right most dimension
      largestChangingDim--;
      while (newDimSize[largestChangingDim] == 1) {
        largestChangingDim--;
      }
      interIndicesCopy[largestChangingDim].lBound += 1; //change the first dimension that's greater than 1
    }
  }
  newTens.dim = newDim;
  newTens.dim_size = newDimSize;
  newTens.count = newCount;
  newTens.data = newData;
  return newTens;
}

//assumes indices is same size as tensor dim
Tensor access_tensor_vthree(Tensor tens, Interval *indices) {
  int x,y,z,j;//,n,xi;

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
        newData[j] = data[y + dim_size[1]*x]; //col + col_size * row
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
        newData[j++] = data[z + y * dim_size[2] + x * dim_size[2] * dim_size[1]];
      }
    }
  }

  // else {
  //   newDim = dim;
  //   newDimSize = malloc(sizeof(int)*newDim);
  //   for (i = 0; i < newDim; i++) {
  //     newDimSize[i] = 1 + indices[i].rBound - indices[i].lBound;
  //   }
  //   newCount = 1;
  //   for (x = 0; x < newDim; x++) { //total elements is each dim multiplied
  //     newCount *= newDimSize[x];
  //   }
  //   newData = malloc(sizeof(int)*newCount);
  //   int currentSum;
  //   int currentProd;
  //   // for (i = 0; i < newCount; i++) { //index
  //     currentSum = 0;
  //     for (n = dim - 1; n > 0; n--) { //add
  //       xn = newDimSize[n];
  //       currentProd = 1;
  //       for (j = 0; j < n - 1; j ++) { //prod
  //         currentProd *= dim_size[j];
  //       }
  //       currentSum += currentProd * xn;
  //     }
  //     sum = currentProd;
  //     // newData[i] = currentProd;
  //   }



  // }
  newTens.dim = newDim;
  newTens.dim_size = newDimSize;
  newTens.count = newCount;
  newTens.data = newData;

  return newTens;
}
