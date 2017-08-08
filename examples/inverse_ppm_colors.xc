//this file should take an RGB ppm file and return another RBG ppm file in which
//each color number (0 to 255) is equivalent to 255 - the color number
//255 would become 0, 0 to 255, and 100 to 150, for example

#include <pnmTensorsLib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  float color_range;
} InvertContext;

float invert_color(float i, void *context) {
  InvertContext *ctx = (InvertContext*) context;
  return ctx.color_range - i;
}

void invert_colors(PNMInfo pnm_info) {
  InvertContext context = (InvertContext) {.max = pnm_info.color_range;};
  //context.color_range = pnm_info.color_range;
  map_with_context(invert_color,pnm_info.tensor,&context);
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

  //open file to write
  FILE *write_file = fopen(argv[2],"w");
  if (!write_file) {
    printf("File %s could not be opened for writing\n", argv[2]);
    return 1;
  }

  PNMInfo pnm_info = pnm_file_to_pnm_info(read_file);
  invert_colors(ppm_info);
  pnm_info_to_pnm_file(write_file, pnm_info); //writes a info to a pnm file

  fclose(read_file);
  fclose(write_file);
}
