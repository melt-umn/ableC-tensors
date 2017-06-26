
typedef struct  {
  float  *data;
  signed int dim;
  signed int  *dim_size;
  signed int count;
  
} Tensor;

typedef struct  {
  signed int lBound;
  signed int rBound;
  
} Interval;

extern char delimiters[10];

extern char delimiters_alternate[10];

Tensor create_tensor(signed int  , signed int  * , signed int  , float  * );

Tensor access_tensor(Tensor  , Interval  * );

float float_access_tensor(Tensor  , signed int  * );

Tensor copy_tensor(Tensor  );

Tensor transpose(Tensor  );

Tensor create_identity_tensor(signed int  , signed int  );

Tensor create_identity_tensor_asymmetric(signed int  , signed int  * );

Tensor fill_tensor(signed int  , signed int  * , float  );

Tensor ones(signed int  , signed int  * );

Tensor zeros(signed int  , signed int  * );

Tensor float_to_scalar_tensor(float  );

float scalar_tensor_to_float(Tensor  );

Tensor map(float ( * )(float  ), Tensor  );

Tensor square(Tensor  );

Tensor increment(Tensor  );

float plus_one(float  );

float scalar_square(float  );

float scalar_add(float  , float  );

float scalar_subtract(float  , float  );

float scalar_multiply(float  , float  );

float scalar_divide(float  , float  );

float greater_than(float  , float  );

float lesser_than(float  , float  );

Tensor tensor_fold(float ( * )(float  , float  ), Tensor  , Tensor  );

float fold(float ( * )(float  , float  ), float  , Tensor  );

float max(Tensor  );

float min(Tensor  );

float sum(Tensor  );

float product(Tensor  );

Tensor tensor_max(Tensor  );

Tensor tensor_min(Tensor  );

Tensor tensor_sum(Tensor  );

Tensor tensor_product(Tensor  );

Tensor tensor_combine(float ( * )(float  , float  ), Tensor  , Tensor  );

Tensor tensor_elem_add(Tensor  , Tensor  );

Tensor tensor_elem_subtract(Tensor  , Tensor  );

Tensor tensor_elem_multiply(Tensor  , Tensor  );

Tensor tensor_elem_divide(Tensor  , Tensor  );

Tensor tensor_multiply(Tensor  , Tensor  );

Tensor dot_product(Tensor  , Tensor  );

float float_dot_product(Tensor  , Tensor  );

float float_dot_product_vtwo(Tensor  , Tensor  );

Tensor cross_product(Tensor  , Tensor  );

Tensor scalar_triple_product(Tensor  , Tensor  , Tensor  );

float float_scalar_triple_product(Tensor  , Tensor  , Tensor  );

Tensor vector_triple_product(Tensor  , Tensor  , Tensor  );

float trace(Tensor  );

Tensor tensor_trace(Tensor  );

void free_tensor(Tensor  );

void free_tensor_dynamic(Tensor  * );

void print_tensor(Tensor  , char  * , signed int  );

signed int main(signed int  argc, char  * * argv)
{

  {
    signed int sizeDim[2] = {2, 2};;
    Tensor tensr = ones(2, (sizeDim));;
    print_tensor((tensr), delimiters, 10);
    return 0;
  }
}
