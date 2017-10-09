# Useful Tensor Functions
Listed below are all the useful functions for a user in this ableC-tensors extension. There are a handful of functions that exist in the extension that are not listed here, but those are functions that are called by other functions and thus not considered important *for use*. A programmer who wishes to modify this code will still want to read the descriptions of these functions in the src file to fully understand all that is going on. For the most part, the functions below should be fairly intuitive. They are organized loosely by functionality. Note that some of the functions below may also have unique syntax that can be used to call them.

Just as in [the special tensor syntax](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/special_tensor_syntax.md) documentation file, the word shape here represents the number of dimensions and size of those dimensions in a Tensor. If two Tensors are of equal shape, they have the same number of dimensions and the size of each of those dimensions is identical.

## Tensor creation
<dl>
<b>Tensor create(int dim, int *dim_size, int count, float *data)</b>
  <dd><i>Parameters: dim and count are integers, dim_size is a pointer to an integer array of size dim, and data is a pointer to a float array of size count. Multiplying each element in dim_size together gives count.</i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding integer in dim_size. The Tensor will have count elements, and those elements will be what is in data.</dd>
</d1>

More explanation and unique syntax found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/tensors_and_intervals.md#tensors).

<dl>
<b>Tensor copy(Tensor ten_to_copy)</b>
  <dd><i>Parameters: ten_to_copy is a Tensor of any size.</i></dd>
  <dd>Returns a Tensor that is identical to ten_to_copy, except with a unique memory location.</dd>
</dl>

<dl>
<b>Tensor trans(Tensor ten_to_trans)</b>
  <dd><i>Parameters: ten_to_trans is a two-dimensional Tensor (dim must be two).</i></dd>
  <dd>Returns a Tensor that is the transposed version of ten_to_trans. By definition, if a given Tensor has dimensions m x n (dim_size = [m,n]), the returned Tensor will have dimensions n x m (dim_size = [n,m]).</dd>
</dl>

<dl>
<b>Tensor id(int dim, int dim_len)</b>
  <dd><i>Parameters: dim and dim_len are both integers.</i></dd>
  <dd>Returns a Tensor with dim dimensions each of size dim_len. The function creates an identity Tensor, which means that the diagonals along each dimension are ones and every other element is a zero.</dd>
</dl>

<dl>
<b>Tensor fill(int dim, int *dim_size, float elem)</b>
  <dd><i>Parameters: dim is an integer, dim_size is a pointer to an integer array, and elem is a float.</i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding integer in dim_size. Every element in the Tensor is elem.</dd>
</dl>

<dl>
<b>Tensor ones(int dim, int *dim_size)</b>
  <dd><i>Parameters: dim is an integer, dim_size is a pointer to an integer array.</i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding integer in dim_size. Every element in the Tensor is one.</dd>
</dl>

<dl>
<b>Tensor zeros(int dim, int *dim_size)</b>
  <dd><i>Parameters: dim is an integer, dim_size is a pointer to an integer array.</i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding integer in dim_size. Every element in the Tensor is zero.</dd>
</dl>

<dl>
<b>Tensor float_to_ten(float elem)</b>
  <dd><i>Parameters: elem is a float.</i></dd>
  <dd>Returns a Tensor with one dimension (of size one) with the single element being elem.</dd>
</dl>

## Important Tensor functions
<dl>
<b>float ten_to_float(Tensor ten)</b>
  <dd><i>Parameters: ten is a Tensor with a single element (count = 1).</i></dd>
  <dd>Returns the single element (float) that is in ten.</dd>
</dl>

<dl>
<b>Tensor accessT(Tensor ten_to_access, Interval *interval_array)</b>
  <dd><i>Parameters: ten_to_access is a Tensor with as many dimensions as the length of interval_array, an array of Intervals</i></dd>
  <dd>Returns a Tensor in which each dimension of ten_to_access is accessed by the corresponding Interval in interval_array. The number of dimensions in this returned Tensor will remain the same as ten_to_access, but the length of those dimensions may change.</dd>
</dl>

More explanation and unique syntax found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/tensors_and_intervals.md#intervals).


<dl>
<b>void freeT(Tensor ten_to_free)</b>
  <dd><i>Parameters: ten_to_free is a Tensor of any size</i></dd>
  <dd>Frees everything in the Tensor (returns nothing)</dd>
</dl>

<dl>
<b>void freeT_dynamic(Tensor *ten_to_free)</b>
  <dd><i>Parameters: ten_to_free is a pointer to a Tensor of any size</i></dd>
  <dd>Frees everything in the Tensor and the pointer to the Tensor itself (returns nothing)</dd>
</dl>

<dl>
<b>void printT(Tensor ten_to_print)</b>
  <dd><i>Parameters: ten_to_print is a Tensor with ten or fewer dimensions</i></dd>
  <dd>Prints out each element of ten_to_print with certain syntax separating each dimension. The syntax for each dimension corresponds to the following array [',', ';', '/', '-', '!', '@', '#', '%', '^', '&']. If you wish to choose your own syntax or have more than ten dimensions to a Tensor, see below.</dd>
</dl>

<dl>
<b>void printT_extended(Tensor ten_to_print, char *dimension_syntax, int dimensions)</b>
  <dd><i>Parameters: ten_to_print is a Tensor, dimension_syntax is a pointer to a character array, and dimensions is an integer. The length of dimension_syntax should match dimensions, and the number of dimensions in ten_to_print must be less than or equal to dimensions.</i></dd>
  <dd>Prints out each element of ten_to_print with the corresponding syntax from dimension_syntax separating each dimension of ten_to_print.</dd>
</dl>

## Tensor mapping functions
<dl>
<b>Tensor map(float (*)(float),Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor map_cilk(float (*)(float),Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor map_with_context(float (*)(float,void*),Tensor,void*)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor map_with_context_cilk(float (*)(float,void*),Tensor,void*)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor square(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor square_cilk(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor incr(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor incr_cilk(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor negate(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor negate_cilk(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Tensor equality and arithmetic
<dl>
</b>bool ten_equals(Tensor,Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>bool ten_not_equals(Tensor,Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float plus_one(float)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float times_negative_one(float)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_square(float)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_add(float,float)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_subtract(float,float)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_multiply(float,float)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float scalar_divide(float,float)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Tensor folding functions
<dl>
</b>Tensor ten_fold(float (*)(float,float),Tensor,Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float fold(float (*)(float,float),float,Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float max(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float min(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float sum(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>float prod(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_max(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_min(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_sum(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
</b>Tensor ten_prod(Tensor)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

## Tensor combination functions
Unique syntax for all the functions in this section (except ten_combine and ten_combine_cilk, the first ones below) can be found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/special_tensor_syntax.md#overloaded-functions). 

Note that all of the functions below have a function call that includes \_cilk at the end. These are identical functions that use cilk to perform parallel programming. We do not know which of the versions is more efficient with time and memory yet, thus they are both still included. However, all of the overloaded functions (linked above) use the version that does not use cilk. 

<dl>
<b>Tensor ten_combine(float (*fun)(float, float),Tensor ten_one, Tensor ten_two)</b>
  <b>Tensor ten_combine_cilk(float (*fun)(float, float),Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: </i></dd>
  <dd> </dd>
</dl>

<dl>
<b>Tensor ten_elem_add(Tensor ten_one, Tensor ten_two)</b>
  <dd>or <b>Tensor ten_elem_add_cilk(Tensor ten_one, Tensor ten_two)</b></dd>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the elements in the same location of tensorOne and tensorTwo added.</dd>
</dl>

<dl>
<b>Tensor ten_elem_subtract(Tensor ten_one, Tensor ten_two) / Tensor ten_elem_subtract_cilk(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the element in the same location of tensorTwo subtracted from the matching element in tensorOne.</dd>
</dl>

<dl>
<b>Tensor ten_elem_multiply(Tensor ten_one, Tensor ten_two) / Tensor ten_elem_multiply_cilk(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the elements in the same location of tensorOne and tensorTwo multiplied.</dd>
</dl>

<dl>
<b>Tensor ten_elem_divide(Tensor ten_one, Tensor ten_two) / Tensor ten_elem_divide_cilk(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the element in the same location of tensorOne divided by the matching element in tensorTwo.</dd>
</dl>

## Linear algebra functionality
<dl>
<b>Tensor ten_multiply(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must be two-dimensional Tensors. If ten_one has a dim_size of [m,n], ten_two must have the dim_size [n,p]. In other words, the number of columns in ten_one must match the number of rows in ten_two.</i></dd>
  <dd>Returns a two-dimensional Tensor in which the dim_size is [m,p] (assuming dimensions listed above in Parameters). This Tensor will be the result of performing matrix multiplication on ten_one and ten_two.</dd>
</dl>

<dl>
<b>Tensor dot_product(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must have the same dimensions.</i></dd>
  <dd>Returns a one-dimensional Tensor in which the single element is the dot product of ten_one and ten_two.</dd>
</dl>

<dl>
<b>float float_dot_product(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must have the same dimensions.</i></dd>
  <dd>Returns the dot product of ten_one and ten_two as a floating point value.</dd>
</dl>

<dl>
<b>Tensor cross_product(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must be one-dimensional Tensors with three elements each.</i></dd>
  <dd>Returns a one-dimensional Tensor with three elements, calculated by taking the cross product of ten_one and ten_two.</dd>
</dl>

<dl>
<b>Tensor scalar_triple_product(Tensor ten_one, Tensor ten_two, Tensor ten_three)</b>
  <dd><i>Parameters: ten_one, ten_two, and ten_three must be one-dimensional Tensors with three elements each.</i></dd>
  <dd>Returns a one-dimensional Tensor with a single element. This element is the result of taking the dot product of ten_one with the cross product of ten_two and ten_three.</dd>
</dl>

<dl>
<b>float float_triple_product(Tensor ten_one, Tensor ten_two, Tensor ten_three)</b>
  <dd><i>Parameters: </i></dd>
  <dd>Returns the floating point number calculated by taking the vector triple product of ten_one, ten_two, and ten_three. This is the equivalent of taking the cross product ten_one with the cross product of ten_two and ten_three.</dd>
</dl>

<dl>
<b>Tensor vector_triple_product(Tensor ten_one, Tensor ten_two, Tensor ten_three)</b>
  <dd><i>Parameters: ten_one, ten_two, and ten_three must be one-dimensional Tensors with three elements each.</i></dd>
  <dd>Returns a one-dimensional Tensor with three elements, calculated by taking the vector triple product of ten_one, ten_two, and ten_three. This is the equivalent of taking the cross product ten_one with the cross product of ten_two and ten_three.</dd>
</dl>

<dl>
<b>float trace(Tensor ten_to_trace)</b>
  <dd><i>Parameters: ten_to_trace must be a two-dimensional square Tensor (dim_size = [m,m]).</i></dd>
  <dd>Returns a floating point number that is the trace (summation of all the elements along the diagonal) of ten_to_trace.</dd>
</dl>

<dl>
<b>Tensor ten_trace(Tensor ten_to_trace)</b>
  <dd><i>Parameters: ten_to_trace must be a two-dimensional square Tensor (dim_size = [m,m]).</i></dd>
  <dd>Returns a one-dimensional Tensor in which the single element is the trace (summation of all the elements along the diagonal) of ten_to_trace.</dd>
</dl>
