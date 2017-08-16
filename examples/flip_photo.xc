//this file should take an pnm file and return a pnm file of the same type but flipped
//either horizontally, vertically, or both

#include "../include/pnmTensorsLib.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


PNMInfo horiz_flip(PNMInfo pnm_info) {
  float *data;
  data = malloc(sizeof(float)*pnm_info.tensor.count);
  memcpy(data,pnm_info.tensor.data,pnm_info.tensor.count);

  //to flip an image horizontally, every element in a row must go to the opposite element
  //ie if a row is 15 elements long, the 1st element must go to the 15th and the 15th to the 1st
  //be careful of ppm files -- the three color pixels must stay together
  
  int current_count, max_width;
  current_count = 0;
  max_width = pnm_info.tensor.dim_size[0];

  if (pnm_info.color_type < 3) { //it's bw or greyscale, aka 1 number per pixel 
    for (int i = 0; i < pnm_info.tensor.dim_size[1]; i++) {
      for (int j = 0; j < max_width; j++) {
        printf("From original index [%d], grabbing element %f and putting it in new index [%d]\n",
                i * max_width + max_width - 1 - j, data[i * max_width + max_width - 1 - j], current_count);
        //current element = [width - 1 - current_width_index][row]
        pnm_info.tensor.data[current_count++] = data[i * max_width + max_width - 1 - j];
      }
    }
  }
  free(data);
  return pnm_info;
}

/*
PNMInfo vert_flip(PNMInfo pnm_info) {
  //copying pnm_info to a new PNMInfo struct to make accessing both tensor arrays easier
  PNMInfo new_pnm_info;
  new_pnm_info.color_type = pnm_info.color_type;
  new_pnm_info.color_range = pnm_info.color_range;
  new_pnm_info.tensor = copy(pnm_info.tensor);


}

PNMInfo both_flip(PNMInfo pnm_info) {
}
*/

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

  char horiz_input[2], vert_input[2]; 
  int horiz_check, vert_check;  

  printf("Would you like to flip the image horizontally (y/n)? ");
  scanf("%s",horiz_input);
  printf("response: %s\n",horiz_input);
  
  if (strcmp(horiz_input,"y") || strcmp(horiz_input,"Y")) {
    horiz_check = 1;
  } else if (strcmp(horiz_input,"n") || strcmp(horiz_input,"N")) {
    horiz_check = 0;
  } else {
    printf("Response must be y or n. Now quitting\n");
    return 1;
  }
/* 
  printf("Would you like to flip the image vertically (y/n)? ");
  scanf("%s",vert_input);
  printf("response: %s\n",vert_input);

  if (strcmp(vert_input,"y") || strcmp(vert_input,"Y")) {
    vert_check = 1;
  } else if (strcmp(vert_input,"n") || strcmp(vert_input,"N")) {
    vert_check = 0;
  } else {
    printf("Response must be y or n. Now quitting\n");
    return 1;
  }
*/
  horiz_flip(pnm_info);

  printf("image dimensions are %d x %d\n", pnm_info.tensor.dim_size[0], pnm_info.tensor.dim_size[1]);
  printf("image color type is %d\n",pnm_info.color_type);

/*
  if (horiz_check) {
    if (vert_check) {
      both_flip(pnm_info);
    } else { 
      horiz_flip(pnm_info);
    }
  } else if (vert_check) {
    vert_flip(pnm_info);
  } else {
    printf("Must flip horizontally or vertically (or both). Image remains untouched.\n");
    return 1;
  }
*/
  //open file to write
  FILE *write_file = fopen(argv[2],"w");
  if (!write_file) {
    printf("File %s could not be opened for writing\n", argv[2]);
    return 1;
  }

//  pnm_info_to_pnm_file(write_file, pnm_info); //writes a info to a pnm file
  fclose(write_file);
  
  free_pnm_info(pnm_info);
  fclose(read_file);
  
}

