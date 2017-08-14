/************************************************************
                PNM TENSOR LIBRARY
Created by: Zoe Wentzel
*************************************************************/
#include "tensorsLib.h"
#include <stdio.h>

typedef struct {
  Tensor tensor;
  int color_type; //1, 2, or 3; 1 is b or w, 2 is greyscale, 3 is rgb color
  int color_range; //color values go from 0 to color_range
} PNMInfo;

int get_color_type_unsafe(FILE *);

int get_image_width(PNMInfo);
int get_image_height(PNMInfo);
int get_color_type(PNMInfo);
int get_color_range(PNMInfo);

PNMInfo pbm_file_to_pnm_info(FILE*);
PNMInfo pgm_file_to_pnm_info(FILE*);
PNMInfo ppm_file_to_pnm_info(FILE*);
PNMInfo pnm_file_to_pnm_info(FILE*);

void pnm_info_to_pnm_file(FILE*,PNMInfo);
void free_pnm_info(PNMInfo);

Tensor get_color_info_tensor(Tensor, int);
Tensor get_red_info_tensor(PNMInfo);
Tensor get_green_info_tensor(PNMInfo);
Tensor get_blue_info_tensor(PNMInfo);
