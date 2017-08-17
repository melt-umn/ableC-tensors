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
Tensor create(int,int*,int,float*);
Tensor accessT(Tensor,Interval*);
float float_access(Tensor,int*);
Tensor copy(Tensor);
Tensor trans(Tensor);
Tensor id(int,int);
Tensor id_as(int, int*);
Tensor fill(int,int*,float);
Tensor ones(int,int*);
Tensor zeros(int,int*);
Tensor float_to_ten(float);

float ten_to_float(Tensor);

Tensor map(float (*)(float),Tensor);
Tensor map_cilk(float (*)(float),Tensor);
Tensor map_with_context(float (*)(float,void*),Tensor,void*);
Tensor map_with_context_cilk(float (*)(float,void*),Tensor,void*);
Tensor square(Tensor);
Tensor incr(Tensor);
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

Tensor ten_fold(float (*)(float,float),Tensor,Tensor);
float fold(float (*)(float,float),float,Tensor);
float max(Tensor);
float min(Tensor);
float sum(Tensor);
float prod(Tensor);
Tensor ten_max(Tensor);
Tensor ten_min(Tensor);
Tensor ten_sum(Tensor);
Tensor ten_prod(Tensor);

Tensor ten_combine(float (*)(float,float),Tensor,Tensor);
Tensor ten_elem_add(Tensor,Tensor);
Tensor ten_elem_subtract(Tensor,Tensor);
Tensor ten_elem_multiply(Tensor,Tensor);
Tensor ten_elem_divide(Tensor,Tensor);

bool ten_equals(Tensor,Tensor);

Tensor ten_multiply(Tensor,Tensor);
Tensor dot_product(Tensor,Tensor);
float float_dot_product(Tensor,Tensor);
float float_dot_product_vtwo(Tensor,Tensor);
Tensor cross_product(Tensor,Tensor);
Tensor scalar_triple_product(Tensor,Tensor,Tensor);
float float_triple_product(Tensor,Tensor,Tensor);
Tensor vector_triple_product(Tensor,Tensor,Tensor);

float trace(Tensor);
Tensor ten_trace(Tensor);

void freeT(Tensor);
void freeT_dynamic(Tensor *);

void printT(Tensor);
void printT_extended(Tensor, char *, int);
