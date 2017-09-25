# Tensors and Intervals: The Basics
All of the functions in the ableC-tensor extension are based on two different data types: Tensors and Intervals. Therefore, in order to use this extension, it is first imperative that you understand what the two are.

## Tensors
### What is a Tensor?
Tensors are a struct that represent an array of data (currently, must be floating point numbers). However, Tensors are not actually a C array (this is the primary reason that we chose to call them Tensors instead of arrays). Instead, a Tensor is a struct that has four different variables saved to it:
1. **dim (int)**: this represents how many dimensions a Tensor has. For instance, a *n x m*  Tensor would have two dimensions, while a *n x m x j* Tensor would have three. Currently, empty tensors (zero dimensional Tensors) are not supported in most functions.
2. **dim_size (\*int)**: this saves the size of the dimensions of the Tensor as an array. Using the examples from above, an *n x m* Tensor would have [n, m] stored, while a *n x m x j* Tensor would have [n, m, j] stored.
3. **count (int)**: this keeps track of how many total elements are in the Tensor. A *n x m* Tensor would have *n \* m* elements, while an *n x m x j* Tensor would have *n \* m \* j* elements.
4. **data (\*float)**: the data is an array of all of the elements in the Tensor. It is the heart of what a Tensor is for: storing floating point numbers.

Two important notes:
1. The array of elements (4 above) is the only part of the Tensor that a user would normally need. The previous three variables are useful in creating the necessary space for that array and for comparing different Tensors. Two Tensors could have the same number of dimensions and same number of elements, for example, but different dimensions. A *n x m* Tensor and a *m x n* Tensor are very different things and must be treated as such.
2. The count can always be calculated using the dim_size, and thus does not technically need to be stored. It is possible that removing count would be more efficient, but the amount of memory needed to store one extra int in a Tensor struct is minimal and can save code and time elsewhere, thus it is currently left in the struct.

### How to create a Tensor
There are two ways to create a Tensor. When possible, the first is simpler and preferable.

The first way highlights the functionality of the extension and the ability of Silver and ableC: the programmer can write out a Tensor with specialized syntax. To do this, they must already know the data that will be in the Tensor (either explicitly or saved as variables). Then, they can store all that data between a nested sequence of pairs of brackets, each pair representing a dimension. For instance, a *2 x 3* Tensor full of zeros would be written as such: `[[ [[ 0, 0, 0]] , [[ 0, 0, 0 ]] ]]`. Empty Tensors can not be created using this method; in other words, `[[ ]]` is not valid syntax. In addition, Tensors may not be uneven. This means that `[[ 0, [[ 0 , 0 ]] ]]` is invalid. When creating Tensors using this syntax, it is not necessary for the programmer to specify or even know the number of dimensions, size of those dimensions, or number of elements. **A simple program using this unique syntax to create Tensors can be found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/test/positive/able_create_new_syntax.xc).**

In rare cases, the programmer may need to explicitly call a function called *create* that takes each of the variables described above (dim, dim_size, data, and count). To do this, the coder must malloc dim_size and data on their own, then call `create(dim, dim_size, data, count)` with the respective values for each variable. This is messy and not ideal, but may sometimes be necessary. **A simple program using the function call previously described to create Tensors can be found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/test/positive/able_create_test.xc).** (Note: this is not a good example of why one might need to create a Tensor with function calls, but just code showing how one could.)

## Intervals
### What is an Interval?
Intervals lists are how one can access a Tensor. Unlike accessing an array or a list, which returns a single element of the inner data type of the array or list, Tensor accessing returns a Tensor that can have multiple elements. (For those of you who know MATLAB, it is the same idea as their accessing.) An Interval is a struct with two variables saved to it:
1. **lBound (int)**: the left bound of an interval represents where to start accessing the Tensor in a corresponding dimension
2. **rBound (int)**: the right bound of an interval represents where to stop accessing in the same dimension 

Note that both bounds are **inclusive**. In otherwords, if the lBound is 0 and the rBound is 4, the accessed indices would be 0, 1, 2, 3, and 4. In addition, most Intervals will have more than one dimension. When accessing a Tensor, each dimension of that Tensor is required to have a corresponding Interval to access it. In other words, a Tensor with four dimensions must take in a sequence of four Intervals. The syntax for defining Intervals and then actually using those Intervals to access a Tensor is defined below. A simple program using Intervals to access Tensors can be found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/test/positive/able_access_test.xc).

### How to create an Interval
When creating an Interval, there is syntax to show that an Interval is being created as well as some unique syntax to indicate the range of the interval. This unique syntax was created to help users write shorter, easier code. An Interval is started by `<(` and ended with `)>`. In the middle, however, is the important information.

As said just above, there is new syntax that was created to represent the range of an interval. Please keep in mind that all the syntax below would be put in the middle of  `<(  )>`. 
* The most intuitive syntax is just a integer. If a single integer is in the Interval, that integer represents both the beginning and end of the accessing range.
* It is also possible to access every index in the Tensor dimension corresponding to the Interval by using just `*`. In other words, the Intervals left bound is automatically set to 0 and its right bound is set to the corresponding dimension length - 1. This can be particularily useful if the programmer does not know the length of the corresponding dimension beforehand (it can be figured out through function calls, but this is simpler). Although this would not make sense to use for a one-dimension array, it does have more use in arrays of greater dimensions. 
* The syntax `,-,` represents a range. Both integers and the `*` syntax can be used with the range symbol to create different combinations (the last two are included for sake of consistency, but have no practical use):
   * `intStart ,-, intEnd` creates an Interval that starts at `intStart` and stop at `intEnd`.\*
   * `intStart ,-, *` creates an Interval that starts at `intStart` and stops at the end of the corresponding dimension.
   * `* ,-, intEnd` creates an Interval that starts at 0 and stops at `intEnd`. Equivalent to `0 ,-, intEnd`. 
   * `* ,-, *` creates an Interval that starts at 0 and stops at the end of the corresponding dimension. Equivalent to `*`.

 \*`intStart` and `intEnd` in all of the examples above can be variables, expressions that result in integers, or just integers.

### How to actually use Intervals
As mentioned earlier, accessing a Tensor requires a sequence of intervals. Just as each Interval is started by using `<(` and ended by using `)>`, a sequence of Intervals is wrapped in the exact same syntax. This is the case whether there is one Interval or more. In addition, each individual Interval within that sequence is seperated by commas. So if there was a Tensor with three dimensions, the code would be as followed `<( intervalOne, intervalTwo, intervalThree )>`. (`intervalOne`, `intervalTwo`, and `intervalThree` can be created beforehand and saved to variables or can be created while coding the sequence.)

Although it would be ideal if this was all that was necessary to index a Tensor, unfortunately that is not the case. Due to complexities in ableC and how new syntax is created (in particular, the type PostFixExpr_c, which is what would be needed to accept Interval sequences as described above, does not currently allow this kind of syntax), it is to communicate to the compiler that the Tensor is going to be accessed *before* the Tensor is referenced. This is something that should be cleaned up, but currently must be delt with as is.

**As a reminder, a simple example program that uses Intervals to access Tensors of various sizes can be found [here](https://github.umn.edu/melt/ableC-tensors/blob/master/test/positive/able_access_test.xc).**

## Next?
Find documentation for other new ableC-tensors syntax [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/special_tensor_syntax.md) (recommended).

Otherwise, there is documentation for ableC-tensors functions [here](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/useful_tensor_functions.md).
