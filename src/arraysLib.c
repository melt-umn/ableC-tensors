//Written by Nguyen Nguyen, Ankit Siva and Zoe Wentzel
//Parts copied from edu.umn.cs.melt.exts.ableC.matlab

//Modified arraysLib.c file to fit our own needs, cleaning out most of the
//code from the matlab version but still using snippets for inspiration/help//might break, please don't trust this -zoe

#include <stdio.h>
#include <stdlib.h>
#include "arraysLib.h"
#include <errno.h>
#include <math.h>


Array create_identity_array(int dimension, int dim_len){
	int i = 0;
	Array *matrix = malloc(sizeof(Array));
	*matrix.dim = dimension;
	*matrix.dim_size = calloc(dim_len*dim_len, sizeof(int));
	*matrix.count = pow(dim_len, dimension);
	*matrix.data = malloc(sizeof(int)*count);

	for (i = 0; i < count; i++) {
		if (i % (dim_len + 2) == 0) {
			*(data + i) = 1;
		} else {
			*(data + i) = 0;
		}
	}

	print_array(matrix);
}

Array int_to_array(int i) {
	int *data, *dim;
	dim = malloc(sizeof(int));
	data = malloc(sizeof(int));
	Array *arr = malloc(sizeof(Array) + sizeof(int) * 2);

	data[0] = i;
	
	arr->dim = 1;
	arr->dim_size = dim; 
	arr->count = 1;
	arr->data = data;
}

//i think i'm using count wrong, idk though -zoe
int array_to_int(Array a) {
	if (a.count == 1) {
		return a.data[0];
	}
	else {
		printf("Error, not a scalar array");
		exit(-1);
	}
}

void print_array(Array tensor) {
	int i = 0;
	for (i =0; i < tensor -> count; i++) {
		printf(tensor -> *(data + i));
		if (i % (tensor -> dim_len) == 0) {
			printf("; ");
		} else {
			printf(" ");
		}
	}
}

