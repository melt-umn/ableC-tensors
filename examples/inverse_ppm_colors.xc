//this file should take an RGB ppm file and return another RBG ppm file in which
//each color number (0 to 255) is equivalent to 255 - the color number
//255 would become 0, 0 to 255, and 100 to 150, for example

#include <../include/tensorsLib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//this function *assumes* that the file given IS in correct ppm format
//comments not supported
Tensor ppm_to_tensor(FILE *ppm_read) {
  //set up tensor variables
  Tensor ppm_tensor;
  int dim, count;
  int *dim_size;
  float *data;
  int current_pixel;
  char color_type[2]; //must be P3 for this example

  if (fscanf(ppm_read,"%s",&color_type) != "P3"){
    print("Color type must be P3 (RGB). Instead, it is: %s\n", color_type);
  }

  fscanf(ppm_read,"%d",&dim_size[0]);
  fscanf(ppm_read,"%d",&dim_size[1]); //dimensions of image
  dim = 2; //will always be two dimensional for an image
  count = dim_size[0]*dim_size[1]; //count is the two dimensions multiplied

  if (fscanf(ppm_read,"%d",&max_value) != 255) {
    printf("Max color value must be 255. Instead, it is: %d\n",max_value);
  }

  int current_data = 0;
  while (fscanf(ppm_read,"%d",&current_pixel) != EOF) {
    data[current_data++] = (float) current_pixel;
  }

  ppm_tensor = create(dim,dim_size,count,data);
  printT(ppm_tensor);
  return ppm_tensor;
}

/*
void tensor_to_ppm(FILE *ppm_write, Tensor ppm_tensor) {

}
*/

int main(int argc, char **argv)
{
  //make sure correct number of args
  if (argc != 3) {
    printf("Usage: ./inverse_ppm_colors.xc <file_in> <file_out>\n")
    return 1;
  }

  //open file to read
  FILE *read_file = fopen(argv[1], "r");
  if (!read_file) {
    printf("File %s could not be opened for reading\n", argv[1]);
    return 1;
  }

  //open file to write
  FILE *write_file = fopen(argv[2],"w")
  if (!write_file) {
    printf("File %s could not be opened for writing\n", argv[2]);
    return 1;
  }

  Tensor ppm_tensor = ppm_to_tensor(read_file);

}
