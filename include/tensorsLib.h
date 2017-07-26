/************************************************************
                TENSOR FUNCTION LIBRARY
Created by: Nguyen Nguyen
Modified by: Ankit Siva, Zoe Wentzel
*************************************************************/
#include <stdbool.h>

// Struct definition for Tensor Struct
typedef struct __attribute__((refId("edu:umn:cs:melt:exts:ableC:tensors:tensors"),
                      module("edu:umn:cs:melt:exts:ableC:tensors:tensors"))) Tensor {
  float *data; //saves memory if at top
  int dim;
  int *dim_size;
  int count;
} Tensor;

typedef struct __attribute__((refId("edu:umn:cs:melt:exts:ableC:tensors:interval"),
                      module("edu:umn:cs:melt:exts:ableC:tensors:interval"))) Interval {
	int lBound;
	int rBound;
} Interval;

extern char delimiters[10];
extern char delimiters_alternate[10];

Interval create_interval_double_bound_hidden(int,int);
Interval create_interval_double_bound(int,int);
Interval create_interval_left_bound(int);
Interval create_interval_right_bound(int);
Interval create_interval_no_bound();


// Function calls
Tensor empty_tensor();
Tensor create_tensor(int,int*,int,float*);
Tensor access_tensor(Tensor,Interval*);
float float_access_tensor(Tensor,int*);
Tensor copy_tensor(Tensor);
Tensor transpose(Tensor);
Tensor create_identity_tensor(int,int);
Tensor create_identity_tensor_asymmetric(int, int*);
Tensor fill_tensor(int,int*,float);
Tensor ones(int,int*);
Tensor zeros(int,int*);
Tensor float_to_scalar_tensor(float);

float scalar_tensor_to_float(Tensor);

Tensor map(float (*)(float),Tensor);
Tensor square(Tensor);
Tensor increment(Tensor);
Tensor negate(Tensor);

float plus_one(float);
float times_negative_one(float);
float scalar_square(float);
float scalar_add(float,float);
float scalar_subtract(float,float);
float scalar_multiply(float,float);
float scalar_divide(float,float);
float greater_than(float,float);
float lesser_than(float,float);

Tensor tensor_fold(float (*)(float,float),Tensor,Tensor);
float fold(float (*)(float,float),float,Tensor);
float max(Tensor);
float min(Tensor);
float sum(Tensor);
float product(Tensor);
Tensor tensor_max(Tensor);
Tensor tensor_min(Tensor);
Tensor tensor_sum(Tensor);
Tensor tensor_product(Tensor);

Tensor tensor_combine(float (*)(float,float),Tensor,Tensor);
Tensor tensor_elem_add(Tensor,Tensor);
Tensor tensor_elem_subtract(Tensor,Tensor);
Tensor tensor_elem_multiply(Tensor,Tensor);
Tensor tensor_elem_divide(Tensor,Tensor);

bool tensor_equals(Tensor,Tensor);

Tensor tensor_multiply(Tensor,Tensor);
Tensor dot_product(Tensor,Tensor);
float float_dot_product(Tensor,Tensor);
float float_dot_product_vtwo(Tensor,Tensor);
Tensor cross_product(Tensor,Tensor);
Tensor scalar_triple_product(Tensor,Tensor,Tensor);
float float_scalar_triple_product(Tensor,Tensor,Tensor);
Tensor vector_triple_product(Tensor,Tensor,Tensor);

float trace(Tensor);
Tensor tensor_trace(Tensor);

void free_tensor(Tensor);
void free_tensor_dynamic(Tensor *);

void print_tensor_compact(Tensor);
void print_tensor(Tensor, char *, int);
