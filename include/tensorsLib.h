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

// Function calls


Tensor create_identity_tensor(int,int);
void print_tensor(Tensor);
Tensor fill_tensor(int,int*,int);
Tensor ones(int,int*);
Tensor zeros(int,int*);
Tensor int_to_scalar(int);
int scalar_to_int(Tensor);
void map(int (*)(int,int),int,Tensor);
int scalar_add(int,int);
int scalar_subtract(int,int);
int scalar_multiply(int,int);
int scalar_divide(int,int);


/*
Tensor create_tensor(int, int*, int, int*);

void print_tensor(Tensor);
void print_tensor_ex(Tensor, int*, char**);
void fprintf_tensor(FILE*, Tensor);
void fprintf_tensor_ex(FILE*, Tensor, int*, char**);
void file_print_tensor(char*, Tensor);
void file_print_tensor_ex(char*, Tensor, int*, char**);
void print(Tensor);

Tensor read_tensor(char*,int*, int);

Tensor accessor_tensor(Tensor, int*);
Tensor cat_tensor(int, Tensor, Tensor);
Tensor tranpose_tensor(Tensor);

int tensor_to_int(Tensor);
Tensor int_to_tensor_ex(int, int);
Tensor int_to_tensor(int);
*/
