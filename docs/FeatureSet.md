## Feature Set:
   
Roadmap for this is [here](#roadmap).
   
### Lang Independent Lin Alg
- Dot Product
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
- Steady state config
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
