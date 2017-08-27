//this file should take an RGB ppm file and return a grayscale (P2) file
//by taking the weighted average, based on user input, of each of the colors for each pixel
//this is done with using cilk functions

#include "../include/pnmTensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  float red_weight;
  float green_weight;
  float blue_weight;
} AverageContext;

float average_red(float i, void *context) {
  AverageContext *ctx = (AverageContext*) context;
  return i * ctx->red_weight;
}

float average_green(float i, void *context) {
  AverageContext *ctx = (AverageContext*) context;
  return i * ctx->green_weight;
}

float average_blue(float i, void *context) {
  AverageContext *ctx = (AverageContext*) context;
  return i * ctx->blue_weight;
}

PNMInfo color_to_greyscale_input(PNMInfo pnm_info,float red,float green,float blue) {
  //extract color value of each pixel
  Tensor red_info = get_red_info_tensor(pnm_info);
  Tensor green_info = get_green_info_tensor(pnm_info);
  Tensor blue_info = get_blue_info_tensor(pnm_info);

  //find weighted average of each color tensor
  AverageContext context = (AverageContext) {.red_weight = red, .green_weight = green, .blue_weight = blue};
  
  map_with_context_cilk(average_red,red_info,&context);
  map_with_context_cilk(average_green,green_info,&context);
  map_with_context_cilk(average_blue,blue_info,&context);

  //add each element of the red and green weighted tensors
  Tensor red_green_info = ten_elem_add_cilk(red_info,green_info);

  //add the blue color information to it
  Tensor red_green_blue_info = ten_elem_add_cilk(red_green_info, blue_info);

  //no longer need any tensor other than red_green_blue_info
  freeT(red_info);
  freeT(green_info);
  freeT(blue_info);
  freeT(red_green_info);

  //now must free pnm_info and return a new PNMInfo struct (array sizes are different)
  pnm_info.color_type = 2;

  //pnm_info.color_range will not change

  freeT(pnm_info.tensor); //no longer need this tensor, too much space allocated
  pnm_info.tensor = red_green_blue_info;
  return pnm_info;
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

  float red,green,blue,total;

  printf("\nA greyscale image can be produced from an RGB image by "
          "taking the average of each color value. A complete average "
		  "in which each color has a weight of approximately .33333 is "
          "an option, but other color combinations are more commonly used "
          "to account for human perception. One common one is .2989, .5870, "
          "and .1140 for RGB accordingly. Here, you can choose which weights "
          "are desired (note: the total of each weight must be between .99 and 1.0\n\n");
  printf("Weight of Red (in dec.): ");
  scanf("%f",&red);
  printf("Weight of Green: ");
  scanf("%f",&green);
  printf("Weight of Blue: ");
  scanf("%f",&blue);
  
  total = red + green + blue;
  if (total < .99 || total > 1) {
	printf("Values add up to %f. Values must add up to be between .99 and 1.0\n",total);
    exit(EXIT_FAILURE);
  }

  PNMInfo pnm_info = pnm_file_to_pnm_info(read_file);

  pnm_info = color_to_greyscale_input(pnm_info,red,green,blue);

  //open file to write
  FILE *write_file = fopen(argv[2],"w");
  if (!write_file) {
    printf("File %s could not be opened for writing\n", argv[2]);
    return 1;
  }
  pnm_info_to_pnm_file(write_file, pnm_info); //writes a info to a pnm file

  free_pnm_info(pnm_info);
  fclose(read_file);
  fclose(write_file);

  return 0;
}
