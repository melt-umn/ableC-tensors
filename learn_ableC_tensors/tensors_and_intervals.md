# Tensors and Intervals: The Basics
All of the functions in the ableC-tensor extension are based on two different data types: Tensors and Intervals. Therefore, in order to use this extension, it is first imperative that you understand what the two are.

## Tensors
### What is a Tensor?
Tensors are a struct that represent an array of data (currently, must be floating point numbers). However, Tensors are not actually a C array (this is the primary reason that we chose to call them Tensors instead of arrays). Instead, a Tensor is a data type that has four different variables saved to it:
1. **dim (int)**: this represents how many dimensions a Tensor has. For instance, a *n x m*  Tensor would have two dimensions, while a *n x m x j* Tensor would have three. Currently, empty tensors (zero dimensional Tensors) are not supported in most functions.
2. **dim_size (\*int)**: this saves the size of the dimensions of the Tensor as an array. Using the examples from above, an *n x m* Tensor would have [n, m] stored, while a *n x m x j* Tensor would have [n, m, j] stored.
3. **count (int)**: this keeps track of how many total elements are in the Tensor. A *n x m* Tensor would have *n \* m* elements, while an *n x m x j* Tensor would have *n \* m \* j* elements.
4. **data (\*float)**: the data is an array of all of the elements in the Tensor. It is the heart of what a Tensor is for: storing floating point numbers.

Two important notes:
1. The array of elements (4 above) is the only part of the Tensor that a user would normally need. The previous three variables are useful in creating the necessary space for that array and for comparing different Tensors. Two Tensors could have the same number of dimensions and same number of elements, for example, but different dimensions. A *n x m* Tensor and a *m x n* Tensor are very different things and must be treated as such.
2. The count can always be calculated using the dim_size, and thus does not technically need to be stored. It is possible that removing count would be more efficient, but the amount of memory needed to store one extra int in a Tensor struct is minimal and can save code and time elsewhere, thus it is currently left in the struct.

### So… what does this mean to someone just trying to use the extension?
There are two ways to create a Tensor. When possible, the first is simpler and preferable.

The first way highlights the functionality of the extension and the ability of Silver and ableC: the programmer can write out a Tensor with specialized syntax. To do this, they must already know the data that will be in the Tensor (either explicitly or saved as variables). Then, they can store all that data between a nested sequence of pairs of brackets, each pair representing a dimension. For instance, a *2 x 3* Tensor full of zeros would be written as such: `[[ [[ 0, 0, 0]] , [[ 0, 0, 0 ]] ]]`. Empty Tensors can not be created using this method; in other words, `[[ ]]` is not valid syntax. In addition, Tensors may not be uneven. This means that `[[ 0, [[ 0 , 0 ]] ]]` is invalid. When creating Tensors using this syntax, it is not necessary for the programmer to specify or even know the number of dimensions, size of those dimensions, or number of elements.

In rare cases, the programmer may need to explicitly call a function called *create* that takes each of the variables described above (dim, dim_size, data, and count). To do this, the coder must malloc dim_size and data on their own, then call `create(dim, dim_size, data, count)` with the respective values for each variable. This is messy and not ideal, but may sometimes be necessary.

## Intervals
## What is an Interval?
Intervals lists are how one can access a Tensor. Unlike accessing an array or a list, which returns a single element of the inner data type of the array or list, Tensor accessing returns a Tensor that can have multiple elements. An Interval has a right bound and a left bound. The right bound represents where to start accessing in a given dimension, while the left bound represents where to stop accessing in the same dimension (both bounds are inclusive). To use an Interval to access a Tensor, it is necessary to use a sequence of them. This is because Tensors have multiple dimensions and, thus, there must be a Interval that corresponds to each dimension. If the Tensor [[ 0, 1, 2, 3, 4, 5 ]] was saved as ten, and the user wanted just to access it so they had the Tensor [[ 2, 3, 4 ]], it would be done like so: <.>ten<( <( 2 ,-, 4 )> )>.

There is also other special syntax that has been implemented in this extension, including, but not limited to, new syntax for dot product (.\*) and overloaded syntax for Tensor equality (==). In addition, there is a multitude of functions that can be called for Tensors that do not have their own special syntax, but are useful nonetheless.
