//this file should take an ppm file and return another ppm file in which
//each color number is equivalent to the max color number - the color number
//this function is testing map with cilk

#include "../include/pnmTensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  float color_range;
} InvertContext;

float invert_color(float i, void *context) {
  InvertContext *ctx = (InvertContext*) context;
  return ctx->color_range - i;
}

PNMInfo invert_colors(PNMInfo pnm_info) {
  InvertContext context = (InvertContext) {.color_range = pnm_info.color_range};
  //context.color_range = pnm_info.color_range;
  map_with_context_cilk(invert_color,pnm_info.tensor,&context);
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

  PNMInfo pnm_info = pnm_file_to_pnm_info(read_file);

  invert_colors(pnm_info);

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
}

