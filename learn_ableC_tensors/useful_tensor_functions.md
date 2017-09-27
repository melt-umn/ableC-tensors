# Useful Tensor Functions
Listed below are all the useful functions for a user in this ableC-tensors extension. There are a handful of functions that exist in the extension that are not listed here, but those are functions that are called by other functions and thus not considered important *for use*. A programmer who wishes to modify this code will still want to read the descriptions of these functions in the src file to fully understand all that is going on. For the most part, the functions below should be fairly intuitive. They are organized loosely by functionality. Note that some of the functions below may also have unique syntax that can be used to call them. 

Just as in [the special tensor syntax](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/special_tensor_syntax.md) documentation file, the word shape here represents the number of dimensions and size of those dimensions in a Tensor. If two Tensors are of equal shape, they have the same number of dimensions and the size of each of those dimensions is identical.

## Tensor creation
<dl>
<b>create(dim,dim_size,count,data)</b> 
  <dd><i>Parameters: dim and count are integers, dim_size is a pointer to an integer array of size dim, and data is a pointer to a float array of size count. Multiplying each element in dim_size together gives count. </i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding element in dim_size. The Tensor will have count elements, and those elements will be what is in data.</dd>
</d1>

Unique syntax found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/tensors_and_intervals.md)

### or

<dl>
<b>create(dim,dim_size,count,data) -> Tensor</b>
  <dd><i>Parameters: dim and count are integers, dim_size is a pointer to an integer array of size dim, and data is a pointer to a float array of size count. Multiplying each element in dim_size together gives count. </i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding element in dim_size. The Tensor will have count elements, and those elements will be what is in data.</dd>
</d1>

<dl>
<b>Tensor create(int dim, int *dim_size, int count, float *data)</b> 
  <dd><i>Parameters: dim and count are integers, dim_size is a pointer to an integer array of size dim, and data is a pointer to a float array of size count. Multiplying each element in dim_size together gives count. </i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding element in dim_size. The Tensor will have count elements, and those elements will be what is in data.</dd>
</d1>

Unique syntax found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/tensors_and_intervals.md)


### or something else? 
I want to figure out how this should be written before writing them all, in case I'm totally off!




Tensor copy(Tensor)

Tensor trans(Tensor)

Tensor id(int,int);

Tensor fill(int,int*,float);

Tensor ones(int,int*);

Tensor zeros(int,int*);

Tensor float_to_ten(float);

## Important Tensor functions
float ten_to_float(Tensor);

Tensor accessT(Tensor,Interval*);

void freeT(Tensor);

void freeT_dynamic(Tensor *);

void printT(Tensor); 

void printT_extended(Tensor, char *, int); 

## Tensor mapping functions
Tensor map(float (*)(float),Tensor);

Tensor map_cilk(float (*)(float),Tensor);

Tensor map_with_context(float (*)(float,void*),Tensor,void*); 

Tensor map_with_context_cilk(float (*)(float,void*),Tensor,void*); 

Tensor square(Tensor);

Tensor square_cilk(Tensor);

Tensor incr(Tensor);

Tensor incr_cilk(Tensor);

Tensor negate(Tensor);

Tensor negate_cilk(Tensor);

## Tensor equality and arithmetic 
bool ten_equals(Tensor,Tensor);

bool ten_not_equals(Tensor,Tensor);

float plus_one(float);

float times_negative_one(float);

float scalar_square(float);

float scalar_add(float,float);

float scalar_subtract(float,float);

float scalar_multiply(float,float);

float scalar_divide(float,float);

## Tensor folding functions
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

## Tensor combination functions
Tensor ten_combine(float (*)(float,float),Tensor,Tensor);

Tensor ten_combine_cilk(float(*)(float,float),Tensor,Tensor);

Tensor ten_elem_add(Tensor,Tensor);

Tensor ten_elem_add_cilk(Tensor,Tensor); 

Tensor ten_elem_subtract(Tensor,Tensor);

Tensor ten_elem_subtract_cilk(Tensor,Tensor); 

Tensor ten_elem_multiply(Tensor,Tensor);

Tensor ten_elem_multiply_cilk(Tensor,Tensor); 

Tensor ten_elem_divide(Tensor,Tensor);

Tensor ten_elem_divide_cilk(Tensor,Tensor); 

## Linear algebra functionality
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
