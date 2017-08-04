//taken from: http://zarb.org/~gc/html/libpng.html
/*
 * Copyright 2002-2010 Guillaume Cottenceau.
 *
 * This software may be freely redistributed under the terms
 * of the X11 license.
 *
 */

#include "../include/tensorsLib.h"

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#define PNG_DEBUG 3
#include <png.h>


int x, y;

int* dimensions; //width,height
png_byte color_type;
png_byte bit_depth;

png_structp png_ptr;
png_infop info_ptr;
int number_of_passes;
png_bytep * row_pointers;

#define BYTES_TO_CHECK 8
void read_png_file(char* file_name) {
  char header[BYTES_TO_CHECK];

  /* open file and test for it being a png */
  FILE *fp = fopen(file_name, "rb");
  if (!fp) {
    printf("File %s could not be opened for reading\n", file_name);
    abort();
  }
  fread(header, 1, BYTES_TO_CHECK, fp); //grabs first bits of file
  if (png_sig_cmp(header, 0, 8)) {
    printf("File %s is not a PNG file\n", file_name);
    abort();
  }

  /* initialize stuff */
  png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

  if (!png_ptr) {
    printf("png_create_read_struct returned failed\n");
    abort();
  }

  info_ptr = png_create_info_struct(png_ptr);
  if (!info_ptr) {
    printf("png_create_info_struct failed\n");
    abort();
  }

  if (setjmp(png_jmpbuf(png_ptr))) {
    printf("Error reading info\n");
    abort();
  }

  png_init_io(png_ptr, fp);
  png_set_sig_bytes(png_ptr, BYTES_TO_CHECK); //tells libpng how many bytes have already been read

  png_read_info(png_ptr, info_ptr);

  dimensions = malloc(sizeof(int)*2);
  dimensions[0] = png_get_image_width(png_ptr, info_ptr); //width
  dimensions[1] = png_get_image_height(png_ptr, info_ptr); //height
  color_type = png_get_color_type(png_ptr, info_ptr);
  bit_depth = png_get_bit_depth(png_ptr, info_ptr);

  number_of_passes = png_set_interlace_handling(png_ptr); //?
  png_read_update_info(png_ptr, info_ptr);


  /* read file */
  if (setjmp(png_jmpbuf(png_ptr))) {
    printf("Error reading image\n");
    abort();
  }

  row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * dimensions[1]);
  for (y=0; y<dimensions[1]; y++)
    row_pointers[y] = (png_byte*) malloc(png_get_rowbytes(png_ptr,info_ptr));

  png_read_image(png_ptr, row_pointers);

  fclose(fp);
}


void write_png_file(char* file_name)
{
  /* create file */
  FILE *fp = fopen(file_name, "wb");
  if (!fp) {
    printf("File %s could not be opened for writing\n", file_name);
    abort();
  }


  /* initialize stuff */
  png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

  if (!png_ptr) {
    printf("png_create_write_struct failed\n");
    abort();
}

  info_ptr = png_create_info_struct(png_ptr);
  if (!info_ptr) {
    printf("png_create_info_struct failed\n");
    abort();
  }
  if (setjmp(png_jmpbuf(png_ptr))) {
    printf("Error during init_io\n");
    abort();
  }

  png_init_io(png_ptr, fp);


  /* write header */
  if (setjmp(png_jmpbuf(png_ptr))) {
    printf("Error during writing header\n");
    abort();
  }

  png_set_IHDR(png_ptr, info_ptr, dimensions[0], dimensions[1],
               bit_depth, color_type, PNG_INTERLACE_NONE,
               PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

  png_write_info(png_ptr, info_ptr);


  /* write bytes */
  if (setjmp(png_jmpbuf(png_ptr))) {
    printf("Error during writing bytes\n");
    abort();
  }

  png_write_image(png_ptr, row_pointers);


  /* end write */
  if (setjmp(png_jmpbuf(png_ptr))) {
    printf("Error during end of write\n");
  }

  png_write_end(png_ptr, NULL);

  /* cleanup heap allocation */
  for (y=0; y<dimensions[1]; y++)
    free(row_pointers[y]);
  free(row_pointers);

  fclose(fp);
}


void process_file(void)
{
  if (png_get_color_type(png_ptr, info_ptr) != PNG_COLOR_TYPE_RGBA) {
    printf("[process_file] color_type of input file must be PNG_COLOR_TYPE_RGBA (%d) (is %d)\n",
           PNG_COLOR_TYPE_RGBA, png_get_color_type(png_ptr, info_ptr));
    abort();
  }

  int count = dimensions[0] * dimensions[1];
  float float_arr[count];
  int currentCount = 0;

/*
  for (y = 0; y<dimensions[1]; y++) {
    png_byte* row = row_pointers[y];
    for (x = 0; x < dimensions[0]; x++) {
       png_byte* ptr = &(row[x*4]);
       float_arr[currentCount] = ptr[0];
       float_arr[currentCount+1] = ptr[1];
       float_arr[currentCount+2] = ptr[2];
       float_arr[currentCount+3] = ptr[3];
       currentCount += 4;
    }
  }
*/
  Tensor png_tensor = create(2,dimensions,dimensions[0]*dimensions[1],float_arr);
  printT(png_tensor);

  for (y=0; y<dimensions[1]; y++) {
    png_byte* row = row_pointers[y];
    for (x=0; x<dimensions[0]; x++) {
      png_byte* ptr = &(row[x*4]);

      /* set red value to 0 and green value to the blue one */
      ptr[0] = 0;
      ptr[1] = ptr[2];
    }
  }
  return;
}


int main(int argc, char **argv)
{
  if (argc != 3) {
    printf("Usage: program_name <file_in> <file_out>\n");
    return 1;
  }
  read_png_file(argv[1]);
  process_file();
  write_png_file(argv[2]);

  return 0;
}
