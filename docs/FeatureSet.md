## Feature Set:

Roadmap for this is [here](#roadmap).

### Types
- ``array``

  An array has dimensions represented by an list of positive integer
  values.

  Arrays have the following properties:
1. Number of data elements
2. Data elements
3. Number of dimensions
4. Length of matrix in each dimension.

  Only data elements (number 2 on the list) are allowed to be floats and/or <= 0.

  Array can be constructed by `[shape], [data]` as in the example `[2,2] [1,2,3,4]` creates

 ```
   1 2
   3 4
 ```

  Can use `ones()`, `zeroes()` and `rand()` to populate a matrix of
  dimensions passed as an argument

  We can use `dims()` as a function that returns the dimensions of an
  array.

  Functions numCols and numRows will also be implemented to return the
  number of rows and columns.

- ``Interval``

  1. An Interval has an enum that specifies the boundedness property, and can be one of the following four:
    1. Unbounded
    2. Bounded
    3. Bounded left, unbounded right
    4. Unbounded left, bounded right
  2. A low bound integer that specifies the lower bound of the interval (if bounded or bounded left)
  3. A high bound integer that specifies the higher bound of the interval (if bounded or bounded right)

### Array Accessing
- `Array Access :: (array a1, array a2) -> (array a3)`
  - **Requires:** `dims(a1) = dims(a2), each element of a2 must be of type interval or integer.`
  - **Ensures:**  `dims(a3) = dims(a1) - number of interval types in a2`

  Need to find a way to access chunks of data from the array efficiently. For example, you should be able to pull out a 2D matrix from a 2+D matrix.

### Language Independent Linear Algebra  
- `Dot Product :: (array a1, array a2) -> (array a3)`

  - **Requires:**  `dims(a1) = dims(a2), length(dims(a1)) = 1`
  - **Ensures:** `dims(a3) = []`

  This representation for the type of the dot production operations tells
  us that it takes two arrays and returns an array. The names (a1, a2, a3)
  let us identify them.

  Besides the type requirements this requires that the two input arrays
  have the same dimensions and that they are vectors (by having the length
  of the dimensions be 1).

  If these requirements are met, the operation ensures that the result is a scalar.

  You might write another version of dot product that returns a C ``float``.

  Consider using the operator `.*` for dot product and `x*` for cross
  product as these are frequently used operations.

  **NOTE:** Matlab uses `.*` to multiply each individual element in an array
  with the corresponding element in another array.

  **Important note:** Should use the **Kahan Summation Algorithm** to prevent loss of significance in calculation with floating point numbers.

- `Cross Product :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a1) = dims(a2)` and both dimensions belong to integers.
  - **Ensures:** `dims(a3) = dims(a1)`

  Cross product will take two arrays and return a third array of the same size
  (but with the cross product math calculated), assuming the requirements are met.

  If length(dims(a1)) and length(dims(a2)) are one, then the array must have
  three elements. In this case, the normal cross-product is taken and returned
  as an array of the same size, as one would expect.

  Otherwise, if length(dims(a1)) and length(dims(a2)) are greater than one,
  then a1 and a2 are treated as a set of three-element vectors. Identical to
  Matlab, calculating the cross-product of multi-dimensional arrays will find
  the cross product of the vectors along the first array whose size is three
  (and return an array of the same size as the originals).

  If the arrays are scalar (dims(a1) = dims(a2) = []), different sizes
  (dims(a1) != dims(a2)), or have no dimension in which there are three elements,
  an error will be returned.

- `Scalar Triple Product :: (array a1, array a2, array a3) -> (array a4)`

  - **Requires:** `dims(a1) = dims(a2) = dims(a3) = [3]`
  - **Ensures:** `dims(a4) = []`

  The scalar triple product takes three vectors of size three and finds the
  cross product of two, and then the dot product between that result and the
  remaining vector. Which vectors are used when does not matter (the property is
  commutative).

  For ease, will likely be `a1 .* (a2 x* a3)`

- `Vector Triple Product :: (array a1, array a2, array a3) -> (array a4)`

  - **Requires:** `dims(a1) = dims(a2) = dims(a3) = [3]`
  - **Ensures:** `dims(a4) = [3]`

  The vector triple product takes the cross product of each array, like below:
                            `a1 x* (a2 x* a3)`

  Each array must be single-dimensional (vector) with a size of three. Because
  only cross products are being calculated, the result will be an another
  single-dimensional array of size three.

- `ConDim :: (Integer x, array a1, array a2) -> (array a3)`
  - **Requires:** `dims(a1) = dims(a2)` except for dimension along `x` axis. `x` cannot be negative, that is, `x` >= 0;
  - **Ensures:** that the dimensions of all axes except the one specified
	as a parameter are equal and that along `x`, dimensions of `a3 = a1`
  Operator could be `:[n]` where `n` is the dimension along which you wish to concatenate.


- `ConRow :: (array a1, array a2) -> (array a3)`
  - **Requires:** `numCols(a1) = numCols(a2)`
  - **Ensures:** `numCols(a3) = numCols(a1), numRows(a3) = numRows(a1) + numRows(a2)`

  This is an extension of the `ConDim` operation, but more specifically for rows (the first dimension).

- `ConColumn`  -> Similar to ConRow, has same signature, requirements and
  guarantees, except for number of rows.
  An idea for an operator is similar to the one proposed for ConRow, `:c`

- `Transpose :: (array a1) -> (array a2)`

  - **Requires:** `length(dims(a1)) <= 2`
  - **Ensures:** `dims(a1) = [m,n] -> dims(a2) = [n,m]`

  Transpose takes an array up to two dimensions and rotates it so that the rows
  and columns are swapped. As a result, the values in dims(a1) will switch places
  in dims(a2). If it's a zero-dimensional array (scalar), return the same array.

  ex: [ 1 2 3 ; 4 5 6 ] -> [ 1 4 ; 2 5 ; 3 6 ]

  TO CHECK: extend transpose for arrays greater than two dimensions?

- `Inverse :: (array a1) -> (array a2)`

  - **Requires:** `dims(a1) = [n,n]`
  - **Ensures:** `dims(a2) = [n,n]`

  Takes the inverse of a square array (returns square array of same size).

- `Determinant :: (array a1) -> (array a2)`

  - **Requires:** `dims(a1) = [n,n]`
  - **Ensures:** `dims(a2) = []`

  Takes a square array and returns its determinant (scalar value, aka a
  zero-dimensional array).

  The determinant of a scalar is that scalar.

  The inverse of a matrix only exists if its determinant != 0.

- `Normal Array Multiplication :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a1) = [n,m], dims(a2) = [m,p]`
  - **Ensures:** `dims(a3) = [n,p]`

  This is the customary way to multiply two arrays together. The number of columns
  of the first array must match the number of rows of the second array. The
  resulting array will have the number of rows from the first array and the
  number of columns from the second array.

  TODO: Extend beyond two dimensions? Not sure how this would work, but I assume
  it is possible.

- `Elemental Array Multiplication :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a1) = dims(a2)`
  - **Ensures:** `dims(a3) = dims(a1)`

  This array multiplication method will multiply each element in the first array
  by the corresponding element in the second array.

- `Array Addition :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a1) = dims(a2)`
  - **Ensures:** `dims(a3) = dims(a1)`

  Takes two arrays and adds together each corresponding element. Should be possible
  to do some loop unrolling/other means of efficiency.

- `Array Subtraction :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a1) = dims(a2)`
  - **Ensures:** `dims(a3) = dims(a1)`

  Takes two arrays and subtracts each element in the second array from the
  corresponding element in the first array. Should be possible to do some loop unrolling/other means of efficiency.

### Map should be able to use parallelism or concurrency (forget which) or even
### loop unrolling to be much more efficient.

- `Map :: (*(fun int i1 -> int i2), array a1) -> (array a2)`

  - **Requires:** `None`
  - **Ensures:** `dims(a1) = dims(a2)`

  Map will take an array and a function to be done on every single element of the
  array. For now, that function must deal with integers. Two possible ways to
  implement this: either have the function accept and return an integer, or
  have it accept and return a scalar array.

  I'm leaning toward the former, since it could potentially be easier for the
  user to write. Rest of documentation written assuming the former. However,
  if the latter is used, the documentation would be as such:

    `Map :: (*(fun array a1 -> array a2), array a3) -> array a4)`
      - **Requires:** `dims(a1) = dims(a2) = []`
      - **Ensures:** `dims(a3) = dims(a4)`

### Note on the following arithmetic functions: each can be calculated using the
### previous `Map` function — in addition, each of the scalar arrays to
### multiply/add/etc by could instead be an integer. This is a design element
### we need to decide on, or, as talked about, do both of for now. For ease,
### I have written all as scalar arrays. -Zoë

- `Scalar Multiply :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a2) = []`
  - **Ensures:** `dims(a1) = dims(a3)`

  Multiplies each integer in a1 to the integer in a2, equivalent to normal
  scalar multiplication (not to be confused with matrix multiplication, even
  though both elements are arrays).

  This will likely be linked with one of the multiplication methods from above
  (dot, cross, elemental, or normal array; not sure what would be best). May
  be the same function (or that one will call this one when the second array is
  a scalar).

- `Scalar Divide :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a2) = [], a2 != [0]`
  - **Ensures:** `dims(a1) = dims(a3)`

  Divides each integer in a1 by the integer in a2 (a2 cannot be [0], due to obvious
  division by zero errors).

- `Scalar Mod :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a2) = [], a2 != [0]`
  - **Ensures:** `dims(a1) = dims(a3)`

  Mods each integer in a1 by the integer in a2 (a2 cannot be [0], due to obvious
  division by zero errors).

- `Scalar Add :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a2) = []`
  - **Ensures:** `dims(a1) = dims(a3)`

  Adds the integer in a2 to each integer in a1. May be linked to the array addition function.

- `Scalar Subtract :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a2) = []`
  - **Ensures:** `dims(a1) = dims(a2)`

  Subtracts the integer in a2 from each integer in a1. May be linked to the array
  subtraction function.

### done with arithmetic functions to be implemented using map

### this one cannot actually be done yet, must allow boolean arrays first
### (or use the normal C array system until boolean arrays are implemented)
- `Where :: (array a1, array a2, array a3) -> (array a4)`

  - **Requires:** `type(a1) = bool, type(a2) = type(a3), dims(a1) = dims(a2) = dims(a3)`
  - **Ensures:** `dims(a1) = dims(a4), type(a2) = type(a4)`

  `Where` goes through each boolean in a1. If it is true, it puts the corresponding
  element in a2 into a4. If it is false, it puts the corresponding element in a3
  into a4. It is similar to a giant `if then else` statement for an array.

  Format and idea for where is taken from SAC.

- `Fold :: (*(fun int i1, int i2 -> int i3), array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a2) = []`
  - **Ensures:** `dims(a3) = []`

  Takes an array and folds it, using the function passed in, to a scalar array.
  A scalar array must also be passed in, since the function needs a value to
  start with. This is useful for various reduction operations, shown below.

  Similar to the `Map` function above, the inner passed in here could instead
  be represented as taking in and returning a scalar array (versus integers).
  Writing this one, I am starting to think that it may be better to write both
  of these functions that way instead. Still not sure.

### Following functions can be written using fold (ideas taken from SAC).
- `Sum :: (array a1) -> (array a2)`

  - **Requires:** `None`
  - **Ensures:** `dims(a2) = []`

  Adds each element in the array together and returns a scalar array with
  that value, assumes addition starts with 0. If empty array, [0] is returned.

- `Prod :: (array a1) -> (array a2)`

  - **Requires:** `None`
  - **Ensures:** `dims(a2) = []`

  Multiplies each element in the array together and returns a scalar array with
  that value, assumes multiplication starts with 1. If empty array, [1] is returned.

- `Max :: (array a1) -> (array a2)`

  - **Requires:** `None`
  - **Ensures:** `dims(a2) = []`

  Finds the maximum number in the array. If the array is empty, returns lowest
  possible integer (not sure what this is off the top of my head) as a scalar
  array.

- `Min :: (array a1) -> (array a2)`

  - **Requires:** `None`
  - **Ensures:** `dims(a2) = []`

  Finds the minimum number in the array. If the array is empty, returns largest
  possible integer as a scalar array.

#end of fold functions

- `Reduced row echelon form :: (array a1) -> (array a2)`

  - **Requires:** `1 <= length(dims(a1)) <= 2`
  - **Ensures:** `dims(a1) = dims(a2)`

  An array is in echelon form when the non-zero element (leading entry) in each
  row is one, each leading entry is to the right of the row above it, and any
  rows with only zeros are at the very bottom of the matrix (a row with all zeros
  cannot be followed by a row with any numbers).

  Because there are multiple possibilities for an row echelon form (in other words, there is not always a unique solution), I would recommend we do this as the
  reduced row echelon form (I'm guessing this was the intention). If this is the
  case, there is one more rule: the leading entry in each row is the only
  non-zero element in its column.

  NOTE: might be useful/smart to have another function that can swap two rows.
  This ability is necessary to find the row echelon form (reduced or not).

  Reference: http://stattrek.com/matrix-algebra/echelon-transform.aspx  

- `Rotations :: `

  - **Requires:** ``
  - **Ensures:** ``

### MATLAB has various eigenvalue/eigenvector calculations, not sure which we want
### implement? https://www.mathworks.com/help/matlab/ref/eig.html#inputarg_A
### Return a column matrix or a diagonal matrix? The default in MATLAB seems to
### be the column vector, but that does not necessarily mean it is the best option.
### We could also implement various forms of eigenvalue calculation, that may
### be the safest option? :) Set-up below is assuming column array return, however.

- `Eigenvalue Calculation :: (array a1) -> (array a2) `

  - **Requires:** `dims(a1) = [n,n]`
  - **Ensures:** `dims(a2) = [1,n] (assuming it's [row,column])`

  This function takes in a square array and returns a column vector (of same
  height) with the eigenvalues of the original array.

- `Trace :: (array a1) -> (array a2)`

  - **Requires:** `dims(a1) = [n,n]`
  - **Ensures:** `dims(a2) = []`

  The trace of a square matrix is the sum of all the elements along its main
  diagonal (top left to bottom right). Trace also has some relation to other
  equations, such as eigenvalue. We may be able to link them ourselves, or leave
  it to the user to utilize.




- Echelon form row reduction
    - just reduced form or also a generic row echelon form?
- Transformations (aka Rotations)
    - ???
- Automated Eigenvalue/vector calculation -> think about complex values
    - complex values in the future, completely new data type
- Diagonalizations
    - function to see if an array can be diagonalized and another to actually
      diagonalize it?
- RF/LU factorization + Gram-Schmidt
    - want to do the modified Gram-Schmidt (MGS) for accuracy/error reduction?
- Linearization
- Pseudo-inverses (Maybe)
- Steady state configuration
- Singular Value Decomposition

### SAC
- `where` (Selection option for map)

### Julia
- Rich matrix creation
- Julia should be able to call functions that are created by the extension to use in Julia files.

### MATLAB
- `mex` functionality to call C code from the MATLAB environment
- Sparse matrices

### Halide
- Integrate loop transformations from Lucas' Halide extension

### Roadmap
- Create structures and functions for arrays/matrices that construct them in a `.h` file
    - Look into matrix representations (think of additional creation features)
    - Find a concise way of merging vectors, scalars and multidimensional matrices
- Look into exact implementations/algorithms of the features (if possible)
    - Find ideal implementations for the operations (matrix multiplication should use Parallelism, for example)
    - Look into using halide for parallelism
- Build out the features
- Work on extending mex and look into Julia calling this language
