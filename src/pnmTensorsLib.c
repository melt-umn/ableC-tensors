/* this is here because using tensors to mutate pnm image files is
used in many of the examples. All functions here assume the PNM file is in
the following format:

  <color_type> <width> <height> <max_color_value> <series_of_integer values>

The one exception is P1 color type, or bw files, that exclude the max color value
parameter for it would always be 1*/

#include <stdio.h>
#include <stdlib.h>
#include <pnmTensorsLib.h>
#include <errno.h>
#include <string.h>

//this function take a file pointer and return the necessary info--will
//reset the read to the top of the file every time so ONLY use if where
//pointer was before does not matter! This is the reason that this is the ONLY
//provided accessor function using the file, it can be used to figure out which
//type of PNM file must be opened (in case the user cares). There are reasons
//why the user may want other information before creationg the PNMImage struct
//(for example, if they accept only a square image), but the potential problems
//outweigh the benefits

//takes a file pointer and returns the color type of the image (file pointer will
//be reset to top of the file)
int get_color_type_unsafe(FILE *read_file) {
  char color_type_list[3];
  int color_type;
  //set file pointer to beginning of file
  if ( fseek(read_file, 0L, SEEK_SET) != 0 ) {
    printf("Unable to go to beginning of file before finding color type\n");
    fclose(read_file);
    exit(EXIT_FAILURE);
  }
  fscanf(read_file,"%s",color_type_list);
  if (strcmp(color_type_list, "P1") == 0) {
    color_type = 1; //black and white only
  } else if (strcmp(color_type_list, "P2") == 0) {
    color_type = 2; //greyscale
  } else if (strcmp(color_type_list, "P3") == 0) {
    color_type = 3; //rgb
  } else {
    printf("Current PNM tensor implementation does not support given color type: %s\n",color_type_list);
    exit(EXIT_FAILURE);
  }
  //reset file pointer to beginning of file
  if ( fseek(read_file, 0L, SEEK_SET) != 0 ) {
    printf("Unable to go to beginning of file before finding color type\n");
    fclose(read_file);
    exit(EXIT_FAILURE);
  }
  return color_type;
}


//takes a PNMInfo struct and returns the width of the image it was created from
int get_image_width(PNMInfo file_info) {
  int base_width = file_info.tensor.dim_size[0];
  if (file_info.color_type == 3) {
    base_width = base_width/3; /*rgb color type has a tensor width x3 because
    there are three values per pixel*/
  }
  return base_width;
}

//takes a PNMInfo struct and returns the height of the image it was created from
int get_image_height(PNMInfo file_info) {
  return file_info.tensor.dim_size[1];
}

//takes a PNMInfo struct and returns the color type of the image it was created
//from; 1 is bw, 2 is greyscale, 3 is rgb
int get_color_type(PNMInfo file_info) {
  return file_info.color_type;
}

//takes a PNMInfo struct and returns the max integer color value of the image
//it was created from
int get_color_range(PNMInfo file_info) {
  return file_info.color_range;
}

/* takes a pbm file and parses it to find the image dimensions, the max color
   value, and the color data. Puts this information in a PNMInfo struct (which
   also includes a Tensor struct). Assumes file is in correct format, but does
   check to make sure the file is a pgm (greyscale) file) */
PNMInfo pbm_file_to_pnm_info(FILE *pbm_read) {
  Tensor pbm_tensor;
  PNMInfo pbm_info;
  int tensor_count, current_pixel;
  int *tensor_dim_size; //[width, height]
  float *tensor_data;
  char color_type[3]; //must be P2 for this function

  //check to make sure color type is bw, if so, places value 1 in PNMInfo struct
  fscanf(pbm_read,"%s",color_type);
  if (strcmp(color_type, "P1") != 0) { //P1 is bw color type
    printf("Color type must be P3 (RGB). Instead, it is: %s\n", color_type);
    fclose(pbm_read);
    exit(EXIT_FAILURE);
  }

  pbm_info.color_type = 1;

  tensor_dim_size = malloc(sizeof(int)*2);

  fscanf(pbm_read,"%d",&tensor_dim_size[0]);
  fscanf(pbm_read,"%d",&tensor_dim_size[1]); //dimensions of image

  tensor_count = tensor_dim_size[0] * tensor_dim_size[1];

  pbm_info.color_range = 1; //max color value is always one for bw files,
  //therefore the file itself does not put this

  tensor_data = malloc(sizeof(float)*tensor_count);

  int current_data = 0;
  while (fscanf(pbm_read,"%d",&current_pixel) != EOF) {
    tensor_data[current_data++] = (float) current_pixel;
  }

  pbm_tensor = create(2,tensor_dim_size,tensor_count,tensor_data);

  pbm_info.tensor = pbm_tensor;

  return pbm_info;
}

/* takes a pgm file and parses it to find the image dimensions, the max color
   value, and the color data. Puts this information in a PNMInfo struct (which
   also includes a Tensor struct). Assumes file is in correct format, but does
   check to make sure the file is a pgm (greyscale) file) */
PNMInfo pgm_file_to_pnm_info(FILE *pgm_read) {
  Tensor pgm_tensor;
  PNMInfo pgm_info;
  int tensor_count, current_pixel, color_range;
  int *tensor_dim_size; //[width, height]
  float *tensor_data;
  char color_type[3]; //must be P2 for this function

  //check to make sure color type is greyscale, if so, places value 2 in PNMInfo struct
  fscanf(pgm_read,"%s",color_type);
  if (strcmp(color_type, "P2") != 0) { //P2 is greyscale color type
    printf("Color type must be P3 (RGB). Instead, it is: %s\n", color_type);
    fclose(pgm_read);
    exit(EXIT_FAILURE);
  }
  pgm_info.color_type = 2;

  tensor_dim_size = malloc(sizeof(int)*2);

  fscanf(pgm_read,"%d",&tensor_dim_size[0]);
  fscanf(pgm_read,"%d",&tensor_dim_size[1]); //dimensions of image

  tensor_count = tensor_dim_size[0] * tensor_dim_size[1];

  fscanf(pgm_read,"%d",&color_range); //max color value
  pgm_info.color_range = color_range;

  tensor_data = malloc(sizeof(float)*tensor_count);

  int current_data = 0;
  while (fscanf(pgm_read,"%d",&current_pixel) != EOF) {
    tensor_data[current_data++] = (float) current_pixel;
  }

  pgm_tensor = create(2,tensor_dim_size,tensor_count,tensor_data);

  pgm_info.tensor = pgm_tensor;

  return pgm_info;
}

/* takes a ppm file and parses it to find the image dimensions, the max color
   value, and the color data. Puts this information in a PNMInfo struct (which
   also includes a Tensor struct). Assumes file is in correct format, but does
   check to make sure the file is a ppm (RGB) file) */
PNMInfo ppm_file_to_pnm_info(FILE *ppm_read) {
  Tensor ppm_tensor;
  PNMInfo ppm_info;
  int tensor_count, current_pixel, color_range;
  int *tensor_dim_size; //[width, height]
  float *tensor_data;
  char color_type[3]; //must be P3 for this function

  //check to make sure color type is RGB, if so, places value 3 in PNMInfo struct
  fscanf(ppm_read,"%s",color_type);
  if (strcmp(color_type, "P3") != 0) { //P3 is RBG color type
    printf("Color type must be P3 (RGB). Instead, it is: %s\n", color_type);
    fclose(ppm_read);
    exit(EXIT_FAILURE);
  }
  ppm_info.color_type = 3;
  tensor_dim_size = malloc(sizeof(int)*2);

  fscanf(ppm_read,"%d",&tensor_dim_size[0]);
  tensor_dim_size[0] = tensor_dim_size[0]*3; //each pixel has 3 color values (RGB)
  fscanf(ppm_read,"%d",&tensor_dim_size[1]); //dimensions of image

  tensor_count = tensor_dim_size[0] * tensor_dim_size[1];

  fscanf(ppm_read,"%d",&color_range); //max color value
  ppm_info.color_range = color_range;

  tensor_data = malloc(sizeof(float)*tensor_count);

  int current_data = 0;
  while (fscanf(ppm_read,"%d",&current_pixel) != EOF) {
    tensor_data[current_data++] = (float) current_pixel;
  }

  ppm_tensor = create(2,tensor_dim_size,tensor_count,tensor_data);

  ppm_info.tensor = ppm_tensor;

  return ppm_info;
}

/* Takes a pnm file and reads it whether it is bw, greyscale, or rgb. Call this
   function if you want your code to work on any of the three images, otherwise
   you can first call get_color_type_unsafe to figure out what kind of image you
   have and then call the corresponding function if desired. */
PNMInfo pnm_file_to_pnm_info(FILE *pnm_read) {
  PNMInfo pnm_info;
  switch (get_color_type_unsafe(pnm_read)) {
    case 1:
      pnm_info = pbm_file_to_pnm_info(pnm_read);
      break;
    case 2:
      pnm_info = pgm_file_to_pnm_info(pnm_read);
      break;
    case 3:
      pnm_info = ppm_file_to_pnm_info(pnm_read);
      break;
    default:
      printf("get_color_type_unsafe returned invalid response\n");
      exit(EXIT_FAILURE);
  }
  return pnm_info;
}

void pnm_info_to_pnm_file(FILE *pnm_write, PNMInfo pnm_info) {
  fprintf(pnm_write,"P%d\n",pnm_info.color_type); //P1, P2, or P3 for bw, greyscale, or rgb
  switch (pnm_info.color_type) {
    case 1:
      fprintf(pnm_write,"%d %d\n",pnm_info.tensor.dim_size[0],pnm_info.tensor.dim_size[1]);
      //bw does not have max color range printed
    case 2:
      fprintf(pnm_write,"%d %d\n",pnm_info.tensor.dim_size[0],pnm_info.tensor.dim_size[1]);
      fprintf(pnm_write,"%d\n",pnm_info.color_range);
    case 3:
      //image dimensions, divide the first by three to make up for the fact that
      //each pixel has 3 color values
      fprintf(pnm_write,"%d %d\n",pnm_info.tensor.dim_size[0]/3,pnm_info.tensor.dim_size[1]);
      fprintf(pnm_write,"%d\n",pnm_info.color_range);
  }
  for (int i = 0; i < pnm_info.tensor.count; i++) {
    fprintf(pnm_write,"%d ", (int) pnm_info.tensor.data[i]);
    /* no line should be < 70 chars long, rounding down to 17 ints per line for
       simplicity. (max num is 3 chars long, plus space, so 17 * 4 would be 68
       max chars) */
    if (i % 15 == 0) {
      fprintf(pnm_write,"\n");
    }
  }
}

void free_pnm_info(PNMInfo pnm_info) {
  freeT(pnm_info.tensor);
}
