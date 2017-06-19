/************************************************************
                TENSOR FUNCTION LIBRARY
Created by: Nguyen Nguyen
Modified by: Ankit Siva, Zoe Wentzel
*************************************************************/

// Struct definition for Tensor Struct

typedef struct {
  int dim;
  int *dim_size;
  int count;
  int *data;
} Tensor;

typedef struct {
	int lBound;
	int rBound;
} Interval;

char delimiters[10] = {',', ';', '/', '-', '!', '@', '#', '%', '^', '&'};
char delimiters_alternate[10] = {'&', '^', '%', '#', '@', '!', '-', ';', '/', ','};

// Function calls
Tensor create_tensor(int,int*,int,int*);
Tensor access_tensor(Tensor,int, Interval, int *, int);
Tensor copy_tensor(Tensor);
Tensor transpose(Tensor);
Tensor create_identity_tensor(int,int);
Tensor create_identity_tensor_asymmetric(int, int*);
Tensor fill_tensor(int,int*,int);
Tensor ones(int,int*);
Tensor zeros(int,int*);
Tensor int_to_scalar(int);

int scalar_to_int(Tensor);

Tensor tensor_map(int (*)(int,int),Tensor,Tensor);
Tensor map(int (*)(int,int),int,Tensor);
int scalar_add(int,int);
int scalar_subtract(int,int);
int scalar_multiply(int,int);
int scalar_divide(int,int);
int scalar_mod(int,int);

Tensor tensor_fold(int (*)(int,int),Tensor,Tensor);
int fold(int (*)(int,int),int,Tensor);
int max(Tensor);
int min(Tensor);
int sum(Tensor);
int product(Tensor);
Tensor tensor_max(Tensor);
Tensor tensor_min(Tensor);
Tensor tensor_sum(Tensor);
Tensor tensor_product(Tensor);

int greater_than(int,int);
int lesser_than(int,int);

Tensor tensor_combine(int (*)(int,int),Tensor,Tensor);
Tensor tensor_elem_add(Tensor,Tensor);
Tensor tensor_elem_subtract(Tensor,Tensor);
Tensor tensor_elem_multiply(Tensor,Tensor);
Tensor tensor_elem_divide(Tensor,Tensor);

Tensor dot_product(Tensor,Tensor);
int int_dot_product(Tensor,Tensor);
int int_dot_product_vtwo(Tensor,Tensor);
Tensor cross_product(Tensor,Tensor);
Tensor scalar_triple_product(Tensor,Tensor,Tensor);
int int_scalar_triple_product(Tensor,Tensor,Tensor);
Tensor vector_triple_product(Tensor,Tensor,Tensor);

void print_tensor(Tensor, char *, int);
