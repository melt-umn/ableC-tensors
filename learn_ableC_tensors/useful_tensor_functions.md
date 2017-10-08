# Useful Tensor Functions
Listed below are all the useful functions for a user in this ableC-tensors extension. There are a handful of functions that exist in the extension that are not listed here, but those are functions that are called by other functions and thus not considered important *for use*. A programmer who wishes to modify this code will still want to read the descriptions of these functions in the src file to fully understand all that is going on. For the most part, the functions below should be fairly intuitive. They are organized loosely by functionality. Note that some of the functions below may also have unique syntax that can be used to call them.

Just as in [the special tensor syntax](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/special_tensor_syntax.md) documentation file, the word shape here represents the number of dimensions and size of those dimensions in a Tensor. If two Tensors are of equal shape, they have the same number of dimensions and the size of each of those dimensions is identical.

## Tensor creation
<dl>
<b>Tensor create(int dim, int *dim_size, int count, float *data)</b>
  <dd><i>Parameters: dim and count are integers, dim_size is a pointer to an integer array of size dim, and data is a pointer to a float array of size count. Multiplying each element in dim_size together gives count. </i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding element in dim_size. The Tensor will have count elements, and those elements will be what is in data.</dd>
</d1>

Unique syntax found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/tensors_and_intervals.md#tensors)

<dl>
<b>Tensor copy(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor trans(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor id(int,int);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor fill(int,int*,float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ones(int,int*);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor zeros(int,int*);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor float_to_ten(float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Important Tensor functions
<dl>
<b>float ten_to_float(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor accessT(Tensor,Interval*);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>void freeT(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>void freeT_dynamic(Tensor *);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>void printT(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>void printT_extended(Tensor, char *, int);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Tensor mapping functions
<dl>
<b>Tensor map(float (*)(float),Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor map_cilk(float (*)(float),Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor map_with_context(float (*)(float,void*),Tensor,void*);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor map_with_context_cilk(float (*)(float,void*),Tensor,void*);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor square(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor square_cilk(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor incr(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor incr_cilk(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor negate(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor negate_cilk(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Tensor equality and arithmetic
<dl>
</b>bool ten_equals(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>bool ten_not_equals(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float plus_one(float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float times_negative_one(float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_square(float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_add(float,float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_subtract(float,float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_multiply(float,float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_divide(float,float);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Tensor folding functions
<dl>
</b>Tensor ten_fold(float (*)(float,float),Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float fold(float (*)(float,float),float,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float max(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float min(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float sum(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float prod(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_max(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_min(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_sum(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_prod(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Tensor combination functions
<dl>
<b>Tensor ten_combine(float (*)(float,float),Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_combine_cilk(float(*)(float,float),Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_add(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_add_cilk(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_subtract(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_subtract_cilk(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_multiply(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_multiply_cilk(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_divide(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_divide_cilk(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Linear algebra functionality
<dl>
<b>Tensor ten_multiply(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor dot_product(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>float float_dot_product(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>float float_dot_product_vtwo(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor cross_product(Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor scalar_triple_product(Tensor,Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>float float_triple_product(Tensor,Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor vector_triple_product(Tensor,Tensor,Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>float trace(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_trace(Tensor);</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>
