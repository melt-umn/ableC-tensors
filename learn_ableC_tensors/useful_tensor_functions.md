# Useful Tensor Functions
Listed below are all the useful functions for a user in this ableC-tensors extension. There are a handful of functions that exist in the extension that are not listed here, but those are functions that are called by other functions and thus not considered important *for use*. A programmer who wishes to modify this code will still want to read the descriptions of these functions in the src file to fully understand all that is going on. For the most part, the functions below should be fairly intuitive. They are organized loosely by functionality. Note that some of the functions below may also have unique syntax that can be used to call them.

Just as in [the special tensor syntax](special_tensor_syntax.md) documentation file, the word shape here represents the number of dimensions and size of those dimensions in a Tensor. If two Tensors are of equal shape, they have the same number of dimensions and the size of each of those dimensions is identical.

Note that some of the functions below have a function call that includes \_cilk at the end. These are identical functions that use cilk to perform parallel programming. We have not figured out which of the versions is more efficient with time and memory yet, thus they are both still included. 

Almost of these functions have examples in the test file of this repository, found [here](../test/positive). It would be wise to look through these files to check your understanding of the functions and how they work (at least on a basic level).

## Tensor creation
<dl>
<b>Tensor create(int dim, int *dim_size, int count, float *data)</b>
  <dd><i>Parameters: dim and count are integers, dim_size is a pointer to an integer array of size dim, and data is a pointer to a float array of size count. Multiplying each element in dim_size together gives count.</i></dd>
  <dd>Returns a Tensor with dim dimensions, each dimension the size of the corresponding integer in dim_size. The Tensor will have count elements, and those elements will be what is in data.</dd>
</d1>

More explanation and unique syntax found [here](tensors_and_intervals.md#tensors).

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

More explanation and unique syntax found [here](tensors_and_intervals.md#intervals).

<dl>
<b>bool ten_equals(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must be Tensors.</i></dd>
  <dd>Compares the shape and elements in tensorOne and tensorTwo (note: does not compare the Tensors in memory). If the shape is different, returns false. If the shape is the same but elements corresponding to the same index are not the same, returns false. Otherwise, if the shape and all of the corresponding elements are the same for the two Tensors, returns true. (Opposite of != below.)
</dd>
</dl>

Unique syntax found [here](special_tensor_syntax.md#overloaded-functions).

<dl>
<b>bool ten_not_equals(Tensor ten_one, Tensor ten_two)</b>
  <dd><i>Parameters: ten_one and ten_two must be Tensors.</i></dd>
  <dd>Compares the shape and elements in tensorOne and tensorTwo (note: does not compare the Tensors in memory). If the shape is different, returns true. If the shape is the same but elements corresponding to the same index are not the same, returns true. Otherwise, if the shape and all of the corresponding elements are the same for the two Tensors, returns false. (Opposite of == above.)</dd>
</dl>

Unique syntax found [here](special_tensor_syntax.md#overloaded-functions).

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
Note that all of the map functions below directly modify the Tensor passed in. This means that it is not actually necessary to return a Tensor (the returns are currently included for convinience, but it may be wiser to remove them). If you wish to map over a Tensor without modifying the actual Tensor, you should first copy the Tensor and then map over that copy.

In addition, square, incr, and negate are all functions written with map.

<dl>
<b>Tensor map(float (*fun )(float),Tensor ten)</b>
  <dd>or <b>Tensor map_cilk(float (*fun)(float), Tensor ten)</b></dd>
  <dd><i>Parameters: fun must be a function that takes in a float as a parameter and returns a float and ten must be a Tensor.</i></dd>
  <dd>Returns the <i>same</i> Tensor in which fun has been performed on every element in ten.</dd>
</dl>

<dl>
<b>Tensor map_with_context(float (*fun)(float, void*), Tensor ten, void *context)</b>
  <dd>or <b>Tensor map_with_context_cilk(float (*fun)(float, void*), Tensor ten, void *context)</b></dd> 
  <dd><i>Parameters: fun must be a function that takes in a float and a void pointer as parameters and returns a float. ten must be a Tensor and context must be a void pointer.</i></dd>
  <dd>Returns the <i>same</i> Tensor in which fun has been performed on every element in ten while also using data from context (the void * argument in fun). Context will (almost?) always be a pointer to a struct.</dd>
</dl>

Note: this one is harder to understand and currently has no simple examples, but I would recommend looking at this [implementation](../examples/inverse_pnm_colors_cilk.xc) for guidance. These void pointers are necessary for dynamically decided map functions.

<dl>
<b>Tensor square(Tensor ten_to_square)</b>
  <dd>or <b>square_cilk(Tensor ten_to_square)</b></dd>
  <dd><i>Parameters: ten_to_square must be a Tensor.</i></dd>
  <dd>Returns the <i>same</i> Tensor with all of its elements squared.</dd>
</dl>

<dl>
<b>Tensor incr(Tensor ten_to_incr)</b>
  <dd>or <b>Tensor incr_cilk(Tensor ten_to_incr)</b></dd> 
  <dd><i>Parameters: ten_to_incr must be a Tensor.</i></dd>
  <dd>Returns the <i>same</i> Tensor with all of its elements incremented by one.</dd>
</dl>

<dl>
<b>Tensor negate(Tensor ten_to_negate)</b>
  <dd> or <b>Tensor negate_cilk(Tensor ten_to_negate)</b></dd>
  <dd><i>Parameters: ten_to_negate must be a Tensor.</i></dd>
  <dd>Returns the <i>same</i> Tensor with all of its elements negated.</dd>
</dl>

## Tensor folding functions
All of the functions below (excluding fold and ten_fold) are coded using fold and ten_fold (fold for the ones that return a float, ten_fold for the ones that return a Tensor).

<dl>
<b>float fold(float (*fun)(float, float), float starting_float, Tensor ten)</b>
  <dd><i>Parameters: fun must be a function that takes in two floats and returns a float, starting_float must be a float, and ten must be a Tensor.</i></dd>
  <dd>Returns a floating point value. To begin with, the function fun takes the starting_float value and the first element of ten as arguments. The return value of fun becomes the new value that gets passed into fun with the next element of ten. This continues until all of ten is iterated through. The final value that fun returns becomes the return value of fold.</dd>
</dl>

<dl>
<b>Tensor ten_fold(float (*fun)(float, float), Tensor starting_ten,Tensor ten)</b>
  <dd><i>Parameters: fun must be a function that takes in two floats and returns a float, starting_ten must be a one-dimensional Tensor with a single element, and ten must be a Tensor.</i></dd>
  <dd>Returns a one-dimensional Tensor with a single element. To begin with, the function fun takes the element in starting_ten and the first element of ten as arguments. The return value of fun becomes the new value that gets passed into fun with the next element of ten. This continues until all of ten is iterated through. The final value that fun returns becomes the single element in the returned Tensor.</dd>
</dl>

<dl>
<b>float max(Tensor ten)</b>
  <dd><i>Parameters: ten must be a Tensor.</i></dd>
  <dd>Returns the maximum of ten as a floating point value.</dd>
</dl>

<dl>
<b>float min(Tensor ten)</b>
  <dd><i>Parameters: ten must be a Tensor.</i></dd>
  <dd>Returns the minimum of ten as a floating point value.</dd>
</dl>

<dl>
<b>float sum(Tensor)</b>
  <dd><i>Parameters: ten must be a Tensor.</i></dd>
  <dd>Returns the floating point value of the elements of ten added together.</dd>
</dl>

<dl>
<b>float prod(Tensor ten)</b>
  <dd><i>Parameters: ten must be a Tensor.</i></dd>
  <dd>Returns the floating point value of the elements of ten multiplied together.</dd>
</dl>

<dl>
<b>Tensor ten_max(Tensor ten)</b>
  <dd><i>Parameters: ten must be a Tensor.</i></dd>
  <dd>Returns a one-dimensional Tensor with the maximum of ten as its only value.</dd>
</dl>

<dl>
<b>Tensor ten_min(Tensor ten)</b>
  <dd><i>Parameters: ten must be a Tensor.</i></dd>
  <dd>Returns a one-dimensional Tensor with the minimum of ten as its only value.</dd>
</dl>

<dl>
<b>Tensor ten_sum(Tensor ten)</b>
  <dd><i>Parameters: ten must be a Tensor.</i></dd>
  <dd>Returns a one-dimensional Tensor in which the only value is all of the elements of ten added together.</dd>
</dl>

<dl>
<b>Tensor ten_prod(Tensor ten)</b>
  <dd><i>Parameters: ten must be a Tensor </i></dd>
  <dd>Returns a one-dimensional Tensor in which the only value is all of the elements of ten multiplied together.</dd>
</dl>

## Tensor combination functions
Unique syntax for all the functions in this section (except ten_combine and ten_combine_cilk, the first ones below) can be found [here](special_tensor_syntax.md#overloaded-functions). 

Note that all of the functions in this section (minus ten_combine and ten_combine_cilk) are coded using ten_combine for the normal functions and ten_combine_cilk for the functions with cilk. All of the overloaded functions (linked above) use the version that does not use cilk. 

<dl>
<b>Tensor ten_combine(float (*fun)(float, float), Tensor ten_one, Tensor ten_two)</b>
  <dd>or <b>Tensor ten_combine_cilk(float (*fun)(float, float),Tensor ten_one, Tensor ten_two)</b></dd>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape and fun must be a function that takes in two floats and returns a float.</i></dd>
  <dd>Returns a Tensor in which each element is the result of performing fun with corresponding elements of ten_one and ten_two as the parameters.</dd>
</dl>

<dl>
<b>Tensor ten_elem_add(Tensor ten_one, Tensor ten_two)</b>
  <dd>or <b>Tensor ten_elem_add_cilk(Tensor ten_one, Tensor ten_two)</b></dd>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the elements in the same location of tensorOne and tensorTwo added.</dd>
</dl>

<dl>
<b>Tensor ten_elem_subtract(Tensor ten_one, Tensor ten_two)</b>
  <dd>or <b>Tensor ten_elem_subtract_cilk(Tensor ten_one, Tensor ten_two)</b></dd>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the element in the same location of tensorTwo subtracted from the matching element in tensorOne.</dd>
</dl>

<dl>
<b>Tensor ten_elem_multiply(Tensor ten_one, Tensor ten_two)</b>
  <dd>or <b>Tensor ten_elem_multiply_cilk(Tensor ten_one, Tensor ten_two)</b></dd>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the elements in the same location of tensorOne and tensorTwo multiplied.</dd>
</dl>

<dl>
<b>Tensor ten_elem_divide(Tensor ten_one, Tensor ten_two)</b>
  <dd>or <b>Tensor ten_elem_divide_cilk(Tensor ten_one, Tensor ten_two)</b></dd>
  <dd><i>Parameters: ten_one and ten_two must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the element in the same location of tensorOne divided by the matching element in tensorTwo.</dd>
</dl>

## Linear algebra functionality
Unique syntax for the first four functions below (ten_multiply, dot_product, float_dot_product, and cross_product) can be found [here](special_tensor_syntax.md#new-syntax).

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
  <dd><i>Parameters: ten_one, ten_two, and ten_three must be one-dimensional Tensors with three elements each.</i></dd>
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
