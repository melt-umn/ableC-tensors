# Special Tensor Syntax
One of the things that seperates MELT extensions from generic modules with preexisting functions and data types is the ability to create new syntax. It was important, therefore, to include some new — but nonetheless logical — syntax in the ableC-tensors extension. Included in this file are overloaded functions as well as this new syntax. 

*Note: as cool as the special ableC-tensors syntax is, it is more important that you understand at least how Tensors work in the ableC-tensors extension. If you have not yet read the documentation on that, you can find it [here](tensors_and_intervals.md).*

## Overloaded functions
ableC-tensors has a handful of useful overloaded syntax that deals with two Tensors. The extension should logically also include syntax to modify Tensors with a scalar (i.e. `[[ 1, 2, 3]] * 3` should be equivalent to `[[ 3, 6, 9 ]]` but this has not yet been implemented. Below are all of the current overloaded functions. The overloaded syntax will be presented, followed by the the parameters and what the function does. The word **shape** here represents the number of dimensions and size of those dimensions in a Tensor. If two Tensors are of equal shape, they have the same number of dimensions and the size of each of those dimensions is identical. 


<dl>
<b>tensorOne + tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the elements in the same location of tensorOne and tensorTwo added.</dd>
</dl>

<dl>
<b>tensorOne - tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the element in the same location of tensorTwo subtracted from the matching element in tensorOne.</dd>
</dl>

<dl>
<b>tensorOne * tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the elements in the same location of tensorOne and tensorTwo multiplied.</dd>
</dl>

<dl>
<b>tensorOne / tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo must be Tensors of the same shape.</i></dd>
  <dd>Returns a Tensor matching the shape of tensorOne and tensorTwo, in which each element is equivalent to the element in the same location of tensorOne divided by the matching element in tensorTwo.</dd>
</dl>

<dl>
<b>tensorOne == tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo must be Tensors.</i></dd>
  <dd>Compares the shape and elements in tensorOne and tensorTwo (note: does <i>not</i> compare the Tensors in memory). If the shape is different, returns false. If the shape is the same but elements corresponding to the same index are not the same, returns false. Otherwise, if the shape and all of the corresponding elements are the same for the two Tensors, returns true. (Opposite of <b>!=</b> below.)</dd>
</dl>

<dl>
<b>tensorOne != tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo must be Tensors.</i></dd>
  <dd>Compares the shape and elements in tensorOne and tensorTwo (note: does <i>not</i> compare the Tensors in memory). If the shape is different, returns true. If the shape is the same but elements corresponding to the same index are not the same, returns true. Otherwise, if the shape and all of the corresponding elements are the same for the two Tensors, returns false. (Opposite of <b>==</b> above.)</dd>
</dl>

## New syntax
As mentioned above, the ableC-tensors extension also has a set of its own, unique syntax. Although new syntax *could* be created for every possible function, we did our best to limit ourselves to new syntax that seems logical. The most important new syntax is that for creating Tensors and accessing those Tensors with Intervals (still explained [here](tensors_and_intervals.md)!), but below is other added syntax for Tensors.

<dl>
<b>tensorOne .* tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo have to be Tensors of equal shape and two or fewer dimensions.</i></dd>
  <dd>Returns a one dimensional, single element Tensor storing the dot product of tensorOne and tensorTwo.</dd>
</d1>

<dl>
<b>tensorOne f.* tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo have to be Tensors of equal shape and two or fewer dimensions.</i></dd>
  <dd>Returns the floating point value of the dot product of tensorOne and tensorTwo.</dd>
</d1>

<dl>
<b>tensorOne x* tensorTwo</b>
  
  <dd><i>Parameters: tensorOne and tensorTwo have to be one dimensional Tensors with three elements (each).</i></dd>
  <dd>Returns the cross product of tensorOne and tensorTwo as a one dimensional Tensor (with three elements).</dd>
</d1>

<dl>
<b>tensorOne ** tensorTwo</b>
  
  <dd><i>Parameters: tensorOne must be [<b>n</b> x <b>m</b>] and tensorTwo must be [m x p]. In other words, tensorOne must be a two dimensional matrix in which the first dimension is size <b>n</b> and the second dimension is size <b>m</b>. tensorTwo must also be a two dimensional matrix, having a first dimension of size <b>m</b> (matching the second dimension of tensorOne) and a second dimension of size <b>p</b>. <b>n</b>, <b>m</b>, and <b>p</b> can all be equal, but do not need to be.</i></dd>
  <dd>Returns the result of matrix multiplication on tensorOne and tensorTwo as a [n x p] matrix (assuming dimensions listed above in Parameters. Because <b>*</b> is already overloaded to represent the multiplication of corresponding elements of two Tensors, <b>**</b> is used to calculate traditional matrix multiplication on two Tensors.</dd>
</d1>

## Next?

Documentation for the rest of ableC-tensors functions (ignoring what is in this file and the Tensors and Intervals file) can be found [here](useful_tensor_functions.md).
