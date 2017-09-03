3 SEPTEMBER 2017

# ableC-tensors

## Introduction

Tensor extension for ableC, inspired and helped by [Single Assignment C (SAC)](http://www.sac-home.org/doku.php), [MATLAB](https://www.mathworks.com/products/matlab.html) and [Julia](https://julialang.org/).

The ableC-tensor extension was created to mimic some of the functionality of the languages above — an "array" (quotes to symbolize that it does not work with actual C arrays, but rather a new data type called Tensor\*) dominated extension with functions and syntax to simplify many common mathematical practices. It is worthwhile to note that this extension was created as a summer research project and, although it is functional, it is by no means at its maximum potention. However, what is here sets up a solid foundation both for ableC programmers who wish to use arrays in interactive manners as well as for programmers who may wish to improve (and extend!) this extension. 

In addition, this ableC-tensors extension shows the **power** of Silver, Copper, and ableC in creating extensions that handle new data types and utilize new syntax in a relatively simple manner. A C programmer who has never used Silver, Copper, or ableC could, with minimal effort, use this extension to simplify coding with tensors.

\*Tensor: although the actual data type Tensor will be explained under under **Usage** below, the important thing to understand is that a tensor is similar to a matrix with unlimited dimensions. To learn more about tensors in mathematics, feel free to check out the [wiki page](https://en.wikipedia.org/wiki/Tensor). 

## Usage

TODO: short code snippets/instructions on how to use

## TODO:

TODO: write the TODO section :D 

## Installation

### Requirements

To use the ableC-tensors extension, first make sure to install [ableC](https://github.com/melt-umn/ableC) and [silver](https://github.com/melt-umn/silver) (put them in the same directory!). I put their shared directory directly on my desktop, but the location should not matter.

### Installation

In the same directory as ableC and silver, create an `extensions` folder (if you have created this folder before, enter the one you have). The ableC-tensors repository (and any other up-to-date ableC extension) should be downloaded in this folder. This can be done two main ways: 

1. To clone this repository, open up your terminal and enter the extensions folder. Then, type `git clone git@github.umn.edu:melt/ableC-tensors.git` and the repository will download.

2. To manually download this repository, you can click the green "Clone or download" button on this page's github (https://github.umn.edu/melt/ableC-tensors TODO: move to public github) and then click "Download ZIP". Unpack this ZIP file in the extensions folder.

## Credits

This extension was primarily coded by Ankit Siva and Zoe Wentzel, with assistance from Nathaniel Ringo and Travis Carlson. In addition, it was inspired by the incomplete (and private) Matlab ableC extension coded by Sean Geronimo Anderson and Nguyen Nguyen.

## Contact

For basic questions on using or understanding the extension, email Zoë Wentzel at wentz101@umn.edu. If you are interested on improving and/or expanding the ableC-tensor extension, wish to create your own extension with ableC/silver (or already have and want to share it!), desire more information on ableC or silver, or anything else along those lines, contact Professor Van Wyk at evw@umn.edu. 

 
