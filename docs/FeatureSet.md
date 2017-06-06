## Feature Set:

Roadmap for this is [here](#roadmap).

### Types
- ``array``

  An array has dimensions represented by an list of positive integer
  values.

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

  Consider using the operator '.*' for dot product and 'x*' for cross
  product as these are frequently used operations.

- `Cross Product :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a1) = dims(a2) and iff
                        1) length(dims(a1)) = 1, dims(a1) = [3]
                           or
                        2) length(dims(a1)) > 1, 3 is in dims(a1)`
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

- `ConRow :: (array a1, array a2) -> (array a3)`
  - **Requires:** `numCols(a1) = numCols(a2)`
  - **Ensures:** `numCols(a3) = numCols(a1), numRows(a3) = numRows(a1) + numRows(a2)`

  How would this work in the case of matrices in 3+ dimensions?
  Possible operator for this is `:r`.

- `ConColumn`  -> Similar to ConRow, has same signature, requirements and
  guarantees, except for number of rows.
  An idea for an operator is similar to the one proposed for ConRow, `:c`

- `ConDim :: (Integer x, array a1, array a2) -> (array a3)`
  - **Requires:** `dims(a1) = dims(a2)` except for dimension along `x` axis
  - **Ensures:** that the dimensions of all axes except the one specified
	as a parameter are equal and that along `x`, dimensions of `a3 = a1`
  Operator could be `:[n]` where `n` is the dimension along which you wish to concatenate.

- `Transpose :: (array a1) -> (array a2)`

  - **Requires:** `length(dims(a1)) <= 2`
  - **Ensures:** `dims(a1) = [m,n] -> dims(a2) = [n,m]`

  Transpose takes an array up to two dimensions and rotates it so that the rows
  and columns are swapped. As a result, the values in dims(a1) will switch places
  in dims(a2). If it's a zero-dimensional array (scalar), return the same array.

  ex: [ 1 2 3 ; 4 5 6 ] -> [ 1 4 ; 2 5 ; 3 6 ]

  TO CHECK: extend transpose for a array greater than two dimensions?

- `Inverse :: (array a1) -> (array a2)`

  - **Requires:** `dims(a1) = [m,m]`
  - **Ensures:** `dims(a2) = [m,m]`

  Takes the inverse of a square array (returns square array of same size).

- `Determinant :: (array a1) -> (array a2)`

  - **Requires:** `dims(a1) = [m,m]`
  - **Ensures:** `dims(a2) = []`

  Takes a square array and returns its determinant (scalar value, aka a
  zero-dimensional array).

- `Map :: (array a1, *(fun int i1 -> int i2)) -> (array a4)`

  - **Requires:** `None`
  - **Ensures:** `dims(a1) = dims(a4)`

  Map will take an array and a function to be done on every single element of the
  array. For now, that function must deal with integers. Two possible ways to
  implement this: either have the function accept and return an integer, or
  have it accept and return a scalar array.

  I'm leaning toward the former, since it could potentially be easier for the
  user to write. Rest of documentation written assuming the former. However,
  if the latter is used, the documentation would be as such:

    `Map :: (array a1, *(fun array a2 -> array a3)) -> array a4)`
      - **Requires:** `dims(a2) = dims(a3) = []`
      - **Ensures:** `dims(a1) = dims(a4)`

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

  Adds the integer in a2 to each integer in a1.

- `Scalar Subtract :: (array a1, array a2) -> (array a3)`

  - **Requires:** `dims(a2) = []`
  - **Ensures:** `dims(a1) = dims(a2)`

  Subtracts the integer in a2 from each integer in a1.

### done with arithmetic functions to be implemented using map

### this one cannot actually be done yet, must allow boolean arrays first
### (or use the normal C array system until boolean arrays are implemented)
- `Where :: (array a1, array a2, array a3) -> (array a4)`

  - **Requires:** `type(a1) = bool, type(a2) = type(a3), dims(a1) = dims(a2) = dims(a3)`
  - **Ensures:** `dims(a1) = dims(a4), type(a2) = type(a4)`

  `Where` goes through each boolean in a1. If it is true, it puts the corresponding
  element in a2 into a4. If it is false, it puts the corresponding element in a3
  into a4. It is similar to a giant `if then else` statement for an array.



- Echelon form row reduction
- Transformations (aka Rotations)
- Automated Eigenvalue/vector calculation -> think about complex values
- Diagonalizations
- RF/LU factorization + Gram Schmidt
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
