## Feature Set:
   
Roadmap for this is [here](#roadmap).

### Types.
- ``array``
  
  An array has dimensions represented by an list of positive integer
  values.
    
  Array can be constructed by `[shape], [data]` as in the example `[2,2] [1,2,3,4]` creates
    
 ``` 1 2 
  3 4 ```
    
  We can use ``dims`` as a function that returns the dimensions of an
  array.

### Lang Independent Lin Algebra
- Dot Product :: (array a1, array a2) -> (array a3)

  - **Requires:**  dims(a1) = dims(a2), length(dims(a1)) = 1
  - **Ensures:** dims(a3) = []
  
  This representation for the type of the dot production operations tells
  us that it takes two arrays and returns an array. The names (a1, a2, a3)
  let us identify them.
  
  Besides the type requirements this requires that the two input arrays
  have the same dimensions and that they are vectors (by having the length
  of the dimensions be 1).
  
  If these requirements are met, the operation ensures that the result is a scalar.
  
  You might write another version of dot product that returns a C ``float``.
  
- Cross Product
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
