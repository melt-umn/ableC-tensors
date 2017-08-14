//this file should take an RGB ppm file and return a grayscale (P2) file
//by taking the average of each of the colors for each pixel

#include "../include/pnmTensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  float num_to_average;
} AverageContext;

float average_colors(float i, void *context) {
  AverageContext *ctx = (AverageContext*) context;
  return i / ctx->num_to_average;
}

void color_to_greyscale(PNMInfo pnm_info) {
  //extract color value of each pixel
  Tensor red_info = get_red_info_tensor(pnm_info);
  Tensor green_info = get_green_info_tensor(pnm_info);
  Tensor blue_info = get_blue_info_tensor(pnm_info);

  //add each element of the red and green tensors
  Tensor red_green_info = ten_elem_add(red_info,green_info);

  //add the blue color information to it
  Tensor red_green_blue_info = ten_elem_add(red_green_info, blue_info);

  printf("\nBefore average: \n");
  printT(<.>red_green_blue_info<( <( 0 ,-, 15 )> )> );

  AverageContext context = (AverageContext) {.num_to_average = 3}; //3 to average
  //context.color_range = pnm_info.color_range;

  //divides added color tensor by three
  map_with_context(average_colors,red_green_blue_info,&context);

  printf("\nAfter average: \n");
  printT(<.>red_green_blue_info<( <( 0 ,-, 15 )> )> );

  //now must free pnm_info and return a new PNMInfo struct (array sizes are different)
  pnm_info.color_type = 2;

  //pnm_info.color_range will not change
  
  printf("\nAfter averaging, color_type is %d\n\n",pnm_info.color_type);
  printf("\nAfter averaging, color_range is %d\n\n",pnm_info.color_range);

  freeT(pnm_info.tensor); //no longer need this tensor, too much space allocated
  pnm_info.tensor = red_green_blue_info;
}

int main(int argc, char **argv)
{
  //make sure correct number of args
  if (argc != 3) {
    printf("Usage: ./inverse_ppm_colors.xc <file_in> <file_out>\n");
    return 1;
  }

  //open file to read
  FILE *read_file = fopen(argv[1], "r");
  if (!read_file) {
    printf("File %s could not be opened for reading\n", argv[1]);
    return 1;
  }

  PNMInfo pnm_info = pnm_file_to_pnm_info(read_file);
  printf("Image width is: %d\n",get_image_width(pnm_info));
  printf("Image height is: %d\n",get_image_height(pnm_info));
  printf("Image color type is: %d\n",get_color_type(pnm_info));
  printf("Image color range is: %d\n",get_color_range(pnm_info));

  color_to_greyscale(pnm_info);

  printf("\n\nAfter greyscale transformation:\n");

  printf("Image width is: %d\n",get_image_width(pnm_info));
  printf("Image height is: %d\n",get_image_height(pnm_info));
  printf("Image color type is: %d\n",get_color_type(pnm_info));
  printf("Image color range is: %d\n",get_color_range(pnm_info));

/*
  //open file to write
  FILE *write_file = fopen(argv[2],"w");
  if (!write_file) {
    printf("File %s could not be opened for writing\n", argv[2]);
    return 1;
  }
  pnm_info_to_pnm_file(write_file, pnm_info); //writes a info to a pnm file
*/

  free_pnm_info(pnm_info);
  fclose(read_file);
//  fclose(write_file);
}
