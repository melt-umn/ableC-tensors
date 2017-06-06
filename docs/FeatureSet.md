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
  - **Requres:** `dims(a1) = dims(a2)` except for dimension along `x` axis
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

  TO CHECK: extend transpose for a matrix greater than two dimensions?

- Determinants
- Echelon form row reduction
- Transformations (aka Rotations)
- Automated Eigenvalue/vector calculation -> think about complex values
- Diagonalizations
- RF/LU factorization + Gram Schmidt
- Linearization
- Transpose
- Inverse
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
