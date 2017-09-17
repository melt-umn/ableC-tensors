3 SEPTEMBER 2017

# ableC-tensors

## Introduction

Tensor extension for ableC, inspired and helped by [Single Assignment C (SAC)](http://www.sac-home.org/doku.php), [MATLAB](https://www.mathworks.com/products/matlab.html) and [Julia](https://julialang.org/).

The ableC-tensor extension was created to mimic some of the functionality of the languages above — an "array" (quotes to symbolize that it does not work with actual C arrays, but rather a new data type called Tensor\*) dominated extension with functions and syntax to simplify many common mathematical practices. It is worthwhile to note that this extension was created as a summer research project and, although it is functional, it is by no means at its maximum potention. However, what is here sets up a solid foundation both for ableC programmers who wish to use arrays in interactive manners as well as for programmers who may wish to improve (and extend!) this extension. 

In addition, this ableC-tensors extension shows the **power** of [Silver](https://github.com/melt-umn/silver), [Copper](https://github.com/melt-umn/copper), and [ableC](https://github.com/melt-umn/ableC) in creating extensions that handle new data types and utilize new syntax in a relatively simple manner. A C programmer who has never used Silver, Copper, or ableC could, with minimal effort, use this extension to simplify coding with tensors.

\*Tensor: although the actual data type Tensor will be explained under under **Usage** below, the important thing to understand is that a tensor is similar to a matrix with unlimited dimensions. To learn more about tensors in mathematics, feel free to check out the [wiki page](https://en.wikipedia.org/wiki/Tensor). 

## Usage

### A Brief Overview 
All of the functions in the ableC-tensor extension are based on two different data types: Tensors and Intervals. Therefore, in order to use this extension, it is first imperative that you understand what the two are. The basics are listed below:

Tensors are a struct that represent an array of data (currently, must be floating point numbers). However, Tensors are not actually a C array (this is the primary reason that we chose to call them Tensors instead of arrays). Instead, a Tensor is a data type that has four different variables saved to it: the number of dimensions, the size of those dimensions (as an array), the number of elements in the tensor, and all of those elements (as an array). Tensors can be created with a *create* method that takes in all of the previously listed variables, or with special syntax as follows: `[[ [[ 1, 2, 3 ]] , [[ 4, 5, 6 ]]` (a *2 x 3* Tensor). 

Intervals lists are how one can access a Tensor. Unlike accessing an array or a list, which returns a single element of the inner data type of the array or list, Tensor accessing returns a Tensor that can have multiple elements. An Interval has a right bound and a left bound. The right bound represents where to start accessing in a given dimension, while the left bound represents where to stop accessing in the same dimension (both bounds are inclusive). To use an Interval to access a Tensor, it is necessary to use a sequence of them. This is because Tensors have multiple dimensions and, thus, there must be a Interval that corresponds to each dimension. If the Tensor `[[ 0, 1, 2, 3, 4, 5 ]]` was saved as `ten`, and the user wanted just to access it so they had the Tensor `[[ 2, 3, 4 ]]`, it would be done like so: `<.>ten<( <( 2 ,-, 4 )> )>`.

There is also other special syntax that has been implemented in this extension, including, but not limited to, new syntax for dot product (`.*`) and overloaded syntax for Tensor equality (`==`). In addition, there is a multitude of functions that can be called for Tensors that do *not* have their own special syntax, but are useful nonetheless. 

### Want to learn more?
If you are interested in learning more, we would recommend reading more about Tensors and Intervals before reading more of the code documentation. **Note:** what is above is repeated in part in the documentation, but there are some clarifications and more examples. Re-reading is very recommended. The extended documentation on Tensors and Intervals can be found here: [Tensors and Intevals](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/tensors_and_intervals.md). The section specifically on other special syntax is here: [Special Tensor Syntax](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/special_tensor_syntax), while the section including all of the functions is here: [Useful Tensor Functions](https://github.umn.edu/melt/ableC-tensors/blob/master/learn_ableC_tensors/useful_tensor_functions.md).

## TODO:
Although there are many things that could be done to improve the code in ableC-tensors or to grow upon it, here is a list of known edits that may significantly improve the code (in no order):
* More errors can be reported at compile time by moving/adding error tests into the Silver code. This includes, but is not limited to:
  * Making sure the length of the interval sequence matches the number of dimensions of the Tensor it is accessing (currently **not** checked anywhere, which could lead to lots of confusion and many bugs)
  * Comparing the variables of one or more Tensors for any function that requires the Tensor(s) to match a specific mold. For instance, the function that turns a Tensor into a float requires that the Tensor has only one dimension and one element. It **may** not be possible to currently look at the dim_size and data in Silver, but I believe that it should be possible to access num_dim and count (since they are simply saved ints). 
* Compare functions with cilk to functions without and choose the best default. Currently, any new syntax that can call a version of a function with cilk or without is defaulting to without, but that is simply because that is what was coded first. 
* Fix awkward Interval access, it requires <.> to be put BEFORE the Tensor being accessed for it to work
* Make sure all functions work both on a Tensor itself, on a variable representing a Tensor, and on a Tensor returned by an equation. For the ones that don't, fix.

## Installation

### Requirements

To use the ableC-tensors extension, first make sure to install [ableC](https://github.com/melt-umn/ableC) and [Silver](https://github.com/melt-umn/silver) (put them in the same directory!). I put their shared directory directly on my desktop, but the location should not matter.

### Installation

In the same directory as ableC and Silver, create an `extensions` folder (if you have created this folder before, enter the one you have). The ableC-tensors repository (and any other up-to-date ableC extension) should be downloaded in this folder. This can be done two main ways: 

1. To clone this repository, open up your terminal and enter the extensions folder. Then, type `git clone git@github.umn.edu:melt/ableC-tensors.git` and the repository will download.

2. To manually download this repository, you can click the green "Clone or download" button on this page's github (https://github.umn.edu/melt/ableC-tensors TODO: move to public github) and then click "Download ZIP". Unpack this ZIP file in the extensions folder.

## Credits

This extension was primarily coded by Ankit Siva and Zoe Wentzel, with assistance from Nathaniel Ringo and Travis Carlson. In addition, it was inspired by the incomplete (and private) Matlab ableC extension coded by Sean Geronimo Anderson and Nguyen Nguyen.

## Contact

For basic questions on using or understanding the extension, email Zoë Wentzel at wentz101@umn.edu. If you are interested on improving and/or expanding the ableC-tensor extension, wish to create your own extension with ableC and Silver (or already have and want to share it!), desire more information on ableC and/or Silver, or anything else along those lines, contact Professor Van Wyk at evw@umn.edu. 

 
