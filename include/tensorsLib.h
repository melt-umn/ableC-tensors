/************************************************************
                MATLAB MATRIX FUNCTION LIBRARY

Created by: Nguyen Nguyen
Modified by: Nguyen Nguyen
*************************************************************/

// Struct definition for Tensor Struct

typedef struct {
  int dim;
  int *dim_size;
  int count;
  int *data;
} Tensor;

char delimiters[10] = {',', '\n', '/', '-', '!', '@', '#', '%', '^', '&'};

// Function calls
Tensor copy_tensor(Tensor);
Tensor create_identity_tensor(int,int);
Tensor fill_tensor(int,int*,int);
Tensor ones(int,int*);
Tensor zeros(int,int*);
Tensor int_to_scalar(int);

int scalar_to_int(Tensor);

Tensor map(int (*)(int,int),int,Tensor);
int scalar_add(int,int);
int scalar_subtract(int,int);
int scalar_multiply(int,int);
int scalar_divide(int,int);

Tensor dot_product(Tensor,Tensor);
int int_dot_product(Tensor,Tensor);
Tensor cross_product(Tensor,Tensor);

void print_tensor(Tensor);
