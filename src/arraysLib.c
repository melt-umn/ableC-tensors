//Written by Nguyen Nguyen, Ankit Siva and Zoe Wentzel
//Parts copied from edu.umn.cs.melt.exts.ableC.matlab

//Modified arraysLib.c file to fit our own needs, cleaning out most of the
//code from the matlab version but still using snippets for inspiration/help//might break, please don't trust this -zoe

#include <stdio.h>
#include <stdlib.h>
#include "arraysLib.h"
#include <errno.h>


/* lol l8er
Array create_identity_array(int dimension){
	int *
}
*/

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
