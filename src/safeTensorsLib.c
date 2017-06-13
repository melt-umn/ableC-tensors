//Written by Nguyen Nguyen, Ankit Siva and Zoe Wentzel
//Parts copied from edu.umn.cs.melt.exts.ableC.matlab

//THIS IS THE ORIGINAL (slightly modified) CODE FROM MATLAB. 

#include <stdio.h>
#include <stdlib.h>
#include "tensorsLib.h"
#include <errno.h>

/*
  Description:
    Create tensor will return an tensor that has "num" on the top left corner of
   	the tensor and all of the remaining values in the tensor will be assigned by 
	incrementing num based on "incr"

  Assumption:
    Dimension_size and incr must be an tensor of size "dimension"
 */

Tensor create_tensor(int dim, int* dim_size, int num, int* incr){
	int i,j, col, row, high;
	int ecnt = 1;
	int fill=0;
	for (i = 0; i < dim; i++) {
		ecnt = ecnt * dim_size[i];
	}

	int* cena = malloc(sizeof(int)*ecnt);

	// Do the 2D part first, assuming a tensor is always at least 2D

	for(row=0; row< dim_size[0]; row++){
		for(col=0; col< dim_size[1];col++){
		cena[(dim_size[1])*row + col] = (num + (row*(incr[1]))) + (col*incr[0]);
		fill++;
		printf("cena[i]");
		printf(" ");
		}
		printf(";");
	}


	//end of 2D part

	//now for dimension-2 part

	for(high=3; high<=dim; high++) {
		for(i=1; i<dim_size[high-1]; i++){
		for(j=0; j< fill; j++){
			cena[(fill*i)+j]= cena[j]+ (incr[high-1])*i;
			}
		}
		fill+=fill*(dim_size[high-1]-1);
	}

	//end of higher-than-2D part

	Tensor *mtrx = malloc(sizeof(Tensor) + sizeof(int) * dim + sizeof(int) * ecnt);

	mtrx->dim = dim;
	mtrx->dim_size = dim_size;
	mtrx->count = ecnt;
	mtrx->data = cena;

	return *mtrx;
}

/*
  Description:
    Print out the tensor element by element and in addition printing out the
    delimeter when appropriate.
  Assumption:
    "delimeter" and "order_read" must have the same number of dimension as the
    tensor being use to print.
    "order_read" must only contain value between 0 and the dimension-1 being used.
 */

void print_tensor_ex(Tensor input, int* order_read, char** delimeter){
	int max_len = input.count;
	int max_dim = input.dim;
	int *data = input.data;
	int *dim_size = input.dim_size;

	int i,j,k;

	int *dim_buff = malloc(sizeof(dim_size+1));
	for (i = 0; i < max_dim; i++) {
		dim_buff[i] = 0;
	}

	for (j=0; j < max_len; j++) {
		printf("%d", data[j]);
		dim_buff[0]++;
		printf("%s", delimeter[0]);

		if(dim_buff[0] == dim_size[1]) {
			dim_buff[1]++;
			dim_buff[0] = 0;
			printf("%s", delimeter[1]);
		}

		if (dim_buff[1] == dim_size[0]) {
			dim_buff[2]++;
			dim_buff[1] = 0;
			printf("%s", delimeter[2]);
		}

		for (k = 3;  k < max_dim; k++) {
			if(dim_buff[k-1] == dim_size[k-1]) {
			printf("%s", delimeter[k]);
			dim_buff[k-1] = 0;
			dim_buff[k]++;
			}
		}
	}

  printf("\n");
}

/*
  Description: Print out a tensor with default delimeter just as print_tensor_ex

  Assumption: Only acccept tensor up to the 4th Dimension

*/

void print_tensor(Tensor input){
  int max_len = input.count;
  int max_dim = input.dim;
  int *data = input.data;
  int *dim_size = input.dim_size;
  int order_read[4] = {0,1,2,3};
  char *delimeter[4] = {" ",";","\n","\n\n"};
  int tooLarge = 0;
  int *dim_buff;
  int i,j,k;

  printf("max_dim is %d \n",max_dim);

  if (max_dim > 3) {
    tooLarge = 1;
    printf("Beginning of tensor... \n");
    max_dim = 3;
    dim_buff = malloc(8);
  }
  else {
    printf("dim_size + 1 is %d\n",sizeof(dim_size+1));
    dim_buff = malloc(sizeof(dim_size+1));
  }
  for (i = 0; i < max_dim; i++) {
    dim_buff[i] = 0;
  }

  for (j=0; j < max_len; j++) {
    printf("%d", data[j]);
    dim_buff[0]++;
    printf("%s", delimeter[0]);

    if(dim_buff[0] == dim_size[1]) {
      dim_buff[1]++;
      dim_buff[0] = 0;
      printf("%s", delimeter[1]);
    }

    if (dim_buff[1] == dim_size[0]) {
      dim_buff[2]++;
      dim_buff[1] = 0;
      printf("%s", delimeter[2]);
    }

    for (k = 3;  k < max_dim; k++) {
      if(dim_buff[k-1] == dim_size[k-1]) {
      printf("%s", delimeter[k]);
      dim_buff[k-1] = 0;
      dim_buff[k]++;
      }
    }

  }
  if (tooLarge) {
  	printf("... rest of tensor cannot be printed");
  }
  printf("\n\n");
}

/*
  Description:
    Perform the same action as print_tensor except out will be redirected to a
    file descriptor.
*/

void fprintf_tensor_ex(FILE* fd, Tensor input, int* order_read, char** delimeter){
  int max_len = input.count;
  int max_dim = input.dim;
  int *data = input.data;
  int *dim_size = input.dim_size;

  int i,j,k;

  int *dim_buff = malloc(sizeof(dim_size+1));
  for (i = 0; i < max_dim; i++) {
    dim_buff[i] = 0;
  }

  for (j=0; j < max_len; j++) {
    fprintf(fd, "%d", data[j]);
    dim_buff[0]++;
    fprintf(fd,"%s", delimeter[0]);

    if(dim_buff[0] == dim_size[1]) {
      dim_buff[1]++;
      dim_buff[0] = 0;
      fprintf(fd,"%s", delimeter[1]);
    }

    if (dim_buff[1] == dim_size[0]) {
      dim_buff[2]++;
      dim_buff[1] = 0;
      fprintf(fd,"%s", delimeter[2]);
    }

    for (k = 3;  k < max_dim; k++) {
      if(dim_buff[k-1] == dim_size[k-1]) {
      fprintf(fd,"%s", delimeter[k]);
      dim_buff[k-1] = 0;
      dim_buff[k]++;
      }
    }
  }
}

/*
  Description:
    Perform the same action as print_tensor except out will be redirected to a
    file descriptor. Uses default delimeter.
*/

void fprintf_tensor(FILE* fd, Tensor input){
  int max_len = input.count;
  int max_dim = input.dim;
  int *data = input.data;
  int *dim_size = input.dim_size;
  int order_read[4] = {0,1,2,3};
  char *delimeter[4] = {" ",";","\n","\n\n"};

  int i,j,k;

  int *dim_buff = malloc(sizeof(dim_size+1));
  for (i = 0; i < max_dim; i++) {
    dim_buff[i] = 0;
  }

  for (j=0; j < max_len; j++) {
    fprintf(fd, "%d", data[j]);
    dim_buff[0]++;
    fprintf(fd,"%s", delimeter[0]);

    if(dim_buff[0] == dim_size[1]) {
      dim_buff[1]++;
      dim_buff[0] = 0;
      fprintf(fd,"%s", delimeter[1]);
    }

    if (dim_buff[1] == dim_size[0]) {
      dim_buff[2]++;
      dim_buff[1] = 0;
      fprintf(fd,"%s", delimeter[2]);
    }

    for (k = 3;  k < max_dim; k++) {
      if(dim_buff[k-1] == dim_size[k-1]) {
      fprintf(fd,"%s", delimeter[k]);
      dim_buff[k-1] = 0;
      dim_buff[k]++;
      }
    }
  }
}

/*
  Description:
    Create a file from filename and call fprintf_tensor to output the tensor
    into that file. Must define the order of reading and delimeter
*/

void file_print_tensor_ex(char* filename, Tensor input, int* order_read, char**delimeter) {
  FILE *fp;
  fp = fopen(filename, "w+");

  fprintf_tensor_ex(fp, input, order_read, delimeter);

  fclose(fp);
}

/*
  Description:
    Create a file from filename and call fprintf_tensor to output the tensor
    into that file. Uses default order of read and delimeter.
*/

void file_print_tensor(char* filename, Tensor input) {
  FILE *fp;
  fp = fopen(filename, "w+");

  fprintf_tensor(fp, input);

  fclose(fp);
}

void print(Tensor input){
	int max_len = input.count;
	int *data = input.data;
	int i;
	for(i = 0; i < max_len; i++) {
		printf("%d, ", data[i]);
	}
	printf("\n");
}

/*
  Description:
    Read a tensor from a txt file and return it as a Tensor
  Assumption:
    Tensor in txt file must be of the correct format and that user must give
    the correct dimension size and dimension
*/

Tensor read_tensor(char* filename, int* dim_size, int dim){
  FILE *fp;
  char* c;
  int i, flag;
  int number;
  int count = 0;
  int ele = 1;
  int *cena;

  for (i = 0; i < dim; i++) {
    ele *= dim_size[i];
  }

  cena = malloc(sizeof(int) * ele);

  fp = fopen(filename, "r");

  while (fscanf(fp, "%d%*[a-zA-Z ;,!?-.)_{}]", &number) != EOF && count != ele) {
    cena[count] = number;
    count++;
  }

  fclose(fp);

  Tensor *mtrx = malloc(sizeof(Tensor) + sizeof(int)*dim + sizeof(int)*ele);

  mtrx->count = ele;
  mtrx->data = cena;
  mtrx->dim_size = dim_size;
  mtrx->dim = dim;

  return *mtrx;
}

/*
  Description:
    Create a new tensor based on how we want to access tensor A. access_range
    will need to have double the amount of dimension for tensor A since it
    should contain two value for each dimension, where it start and where it ends.
  Assumption:
    Index of access_range start at 0. For example if we want to access the first
    3 row it would be {0,2}
    Access_range must only contain valid value, in range of tensor A dimension.
 */

Tensor accessor_tensor(Tensor A, int* access_range){
	int *cena, *dim_size;
	int ecnt, dim, flag;
	int i,j,k;
	int* dim_buff = malloc(sizeof(int) *A.dim);

	dim = A.dim;
	dim_size = malloc(sizeof(int)*dim);

	for(i=0; i < A.dim*2; i++) {
		access_range[i]++;
	}

	ecnt = 1;
	for (i = 0; i < A.dim*2; i+=2) {
		int dim_range;
		dim_range = ((access_range[i+1] - access_range[i])+1);
		ecnt *= dim_range;
		dim_size[i/2] = dim_range;
	}

	cena = malloc(sizeof(int) * ecnt);

	Tensor *mtrx = malloc(sizeof(Tensor) + sizeof(int) * dim + sizeof(int) * ecnt);

	j = 0;
	for(i = 0; i < A.count; i++) {
		dim_buff[0]++;

		if (dim_buff[0] == A.dim_size[1]) {
			dim_buff[1]++;
			dim_buff[0] = 0;
		}

		if (dim_buff[1] == A.dim_size[0]) {
			dim_buff[2]++;
			dim_buff[1] = 0;
		}

		for (k = 3; k < A.dim; k++) {
			if(dim_buff[k-1] == A.dim_size[k-1]) {
			dim_buff[k-1] = 0;
			dim_buff[k]++;
			}
		}

		flag = 1;

		for (k = 0; k < dim; k++) {
			if (k == 0) {
				if (dim_buff[1]+1 < access_range[0] || dim_buff[1]+1 > access_range[1]) {
					flag = 0;
				}
			} else if (k == 1) {
				if (dim_buff[0]+1 < access_range[2] || dim_buff[0]+1 > access_range[3]) {
					flag = 0;
				}
			} else {
				if(dim_buff[k]+1 < access_range[k*2] || dim_buff[k]+1 > access_range[k*2+1]) {
					flag = 0;
				}
			}

		}

		if (flag == 1) {
			cena[j] = A.data[i+1];
			j++;
		}
	}

	mtrx->count = ecnt;
	mtrx->data = cena;
	mtrx->dim_size = dim_size;
	mtrx->dim = dim;

	return *mtrx;
}

/*Description:
    Concat two tensor on a certain specify dimension and return a new tensor

  Assumption:
    Tensor A and B must have the same dimension size on every dimension except
    the dimension being concanted in order to return a rectangular tensor.
    Example would be for tensor A to be a 2x6x4 tensor, then B can only be a
    tensor of size 2xYx4 where Y could be any number greater than 0 in order
    for the two tensor to concat on the second dimension (column).

 */

Tensor cat_tensor(int dim, Tensor A, Tensor B){
	int *cena, *dimension_size;
	int ecnt, dimension, slice_count;
	int i,j,k;

	int actual_dim = dim-1;

	for (i=0; i < A.dim; i++) {
		if (i != actual_dim) {
			if (A.dim_size[i] != B.dim_size[i]) {
				printf("Error, can't concat these two matrices. Invald dimension !!!\n");
				printf("Attempted to concat on dimension %d, but ", dim);
				printf("Dimension number %d does not match, cannot create a rectangular tensor\n", i+1);
			exit(-1);
			}
		}
	}

	int *A_buff = malloc(sizeof(int) *A.dim);
	int *B_buff = malloc(sizeof(int) *B.dim);

	if (dim <= A.dim && dim <= B.dim) {
		//printf("Concating two tensor into a smaller or current dimension\n");
		dimension_size = malloc(sizeof(int) *A.dim);
		dimension = A.dim;
		for (i = 0;  i < dimension; i++) {
			if(i+1 != dim) {
				dimension_size[i] = A.dim_size[i];
			} else {
				dimension_size[i] = A.dim_size[i] + B.dim_size[i];
			}
		}

		ecnt = 1;
		for (j = 0; j < dimension; j++) {
			ecnt *= dimension_size[j];
		}

		cena = malloc(sizeof(int) * ecnt);

		slice_count = dimension_size[0] * dimension_size[1];

		Tensor *mtrx = malloc(sizeof (Tensor) + sizeof(int) * dimension + sizeof(int) * ecnt);


		if (dimension == dim) {
      //printf("Concat on highest dimension");

			j = 0;
			for (i=0; i < A.count; i++) {
				cena[j] = A.data[i];
				j++;
			}

			for (i=0; i < B.count; i++) {
				cena[j] = B.data[i];
				j++;
			}

			mtrx->count = ecnt;
			mtrx->data = cena;
			mtrx->dim_size = dimension_size;
			mtrx->dim = dimension;

			return *mtrx;
		}


		int swtch = 0;
		int Ai = 0;
		int Bi = 0;

		for (i = 0; i < ecnt; i++) {
			if (swtch == 0) {
				cena[i] = A.data[Ai];
				Ai++;
				A_buff[0]++;

				if (A_buff[0] == A.dim_size[1]) {
					A_buff[1]++;
					A_buff[0] = 0;
					if (actual_dim == 1) {
						swtch = 1;
					}
				}

				if (A_buff[1] == A.dim_size[0]) {
					A_buff[2]++;
					A_buff[1] = 0;
					if (actual_dim == 0) {
						swtch = 1;
					}
				}

				for (k = 3; k < A.dim; k++) {
					if(A_buff[k-1] == A.dim_size[k-1]) {
						A_buff[k-1] = 0;
						A_buff[k]++;
						if (actual_dim == k-1) {
							swtch = 1;
						}
					}
				}

			} else {
				cena[i] = B.data[Bi];
				Bi++;
				B_buff[0]++;

				if (B_buff[0] == B.dim_size[1]) {
					B_buff[1]++;
					B_buff[0] = 0;
					if (actual_dim == 1) {
						swtch = 0;
					}
				}

				if (B_buff[1] == B.dim_size[0]) {
					B_buff[2]++;
					B_buff[1] = 0;
					if (actual_dim == 0) {
						swtch = 0;
					}
				}

				for (k = 3; k < B.dim; k++) {
					if(B_buff[k-1] == B.dim_size[k-1]) {
						B_buff[k-1] = 0;
						B_buff[k]++;
						if (actual_dim == k-1) {
							swtch = 0;
						}
					}
				}
			}
		}

    mtrx->count = ecnt;
    mtrx->data = cena;
    mtrx->dim_size = dimension_size;
    mtrx->dim = dimension;
    return *mtrx;

  } else {
    //printf("Concat to a new dimension\n");
    ecnt = A.count+B.count;

    cena = malloc(sizeof(int)*ecnt);
    dimension_size = malloc(sizeof(int) * dim);

		Tensor *mtrx = malloc(sizeof (Tensor) + sizeof(int) * dimension + sizeof(int) * ecnt);

    j=0;

    for(i=0; i<A.count;i++) {
      cena[j] = A.data[i];
      j++;
    }

    for(i=0; i<B.count;i++) {
      cena[j] = B.data[i];
      j++;
    }

    for(i=0; i<dim; i++) {
      if (i < A.dim) {
        dimension_size[i] = A.dim_size[i];
      } else if (i != dim-1) {
        dimension_size[i] = 1;
      } else {
        dimension_size[i] = 2;
      }
    }

    mtrx->count = ecnt;
    mtrx->data = cena;
    mtrx->dim_size = dimension_size;
    mtrx->dim = dim;

    return *mtrx;
  }
}

/*
  Description:
    Take a struct Tensor and return an integer.

  Assumption:
    Tensor A must be a tensor with value of 1 for all dimension which mean data
    should be a pointer to an int tensor of length 1.
*/

int tensor_to_int(Tensor A){
	int flag = 1;
	int i;

	for(i=0; i < A.dim; i++) {
		if(A.dim_size[i] != 1) {
			flag = 0;
		}
	}

	if (flag == 1) {
		return A.data[0];
	} else {
		printf("Error, tensor is not appropriate for conversion");
		exit(-1);
	}
}

/*
  Description:
    Take an integer value and a dimension, and return a Tensor

  Assumption:
    Tensor return will have the value of 1 on all dimension, and a single value
    of the interger inputed (x).
*/

Tensor int_to_tensor_ex(int x, int dimension){
	int *cena, *dim;
	int i;

	dim = malloc(sizeof(int)*dimension);
	cena = malloc(sizeof(int));
	Tensor *mtrx = malloc(sizeof( Tensor) + sizeof(int)*dimension + sizeof(int));

	cena[0] = x;

	for(i = 0; i < dimension; i++) {
		dim[i] = 1;
	}
	mtrx->count = 1;
	mtrx->data = cena;
	mtrx->dim = dimension;
	mtrx->dim_size = dim;

  return *mtrx;
}

Tensor int_to_tensor(int x) {
  return int_to_tensor_ex(x,1);
}

