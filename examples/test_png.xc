
//found and slightly modified at: http://zarb.org/~gc/html/libpng.html

#include <png.h>

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>

int x, y;

png_uint_32 width, height;
int color_type;
int bit_depth;
int interlace_type;

png_structp png_ptr;
png_infop info_ptr;
int number_of_passes;
png_bytep * row_pointers;


#define BYTES_TO_CHECK 4
int check_png(char* file_name, FILE **fp) {

  char header[BYTES_TO_CHECK];

  if (( *fp = fopen(file_name,"rb")) == NULL) {
    return 0;
  }

  if (fread(header, 1, BYTES_TO_CHECK, *fp) != BYTES_TO_CHECK) {
    return 0; 
  }

  return (!png_sig_cmp(header, (png_size_t)0, BYTES_TO_CHECK));
}


void process_file(void)
{
  if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_RGB) {
    printf("Input file is color type RGB but must be color type RGBA\n");
    abort();
  }
  if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_RGBA) {
    printf("RGBA\n");
  }
  
  if (png_get_color_type(png_ptr, info_ptr) == PNG_COLOR_TYPE_GRAY) {
    printf("GRAY\n");
    abort();
  }
  
  /* Clear the pointer array */
  int row;
  for (row = 0; row < height; row++)
    row_pointers[row] = NULL;

  for (row = 0; row < height; row++)
    row_pointers[row] = png_malloc(png_ptr, png_get_rowbytes(png_ptr,
          info_ptr));

  printf("got this far");

  for (y = 0; y < height; y++) {
    png_byte* row = row_pointers[y];
    for (x = 0; x < width; x ++) {
      png_byte* ptr = &(row[x*4]);
      printf("Pixel at position [ %d - %d] has RGBA values: %d - %d - %d - %d\n", x, y, ptr[0], ptr[1], ptr[2], ptr[3]);
      ptr[0] = 0; //set red value to 0
      ptr[1] = ptr[2]; //set green value to blue value
    }
  }
}


void read_png_file(FILE *fp, int sig_read) {

  /* Create and initialize the png_struct with the desired error handler
   * functions.  If you want to use the default stderr and longjump method,
    * you can supply NULL for the last three parameters.  We also supply the
    * the compiler header file version, so that we know if the application
    * was compiled with a compatible version of the library.  REQUIRED
    */
  png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING,NULL,NULL,NULL);

  if (png_ptr == NULL)
  {
    printf("png_ptr is NULL\n");
    fclose(fp);
    abort();
  }

  /* Allocate/initialize the memory for image information.  REQUIRED. */
  info_ptr = png_create_info_struct(png_ptr);
  if (info_ptr == NULL)
  {
    printf("info_ptr is NULL\n");
    fclose(fp);
    png_destroy_read_struct(&png_ptr, NULL, NULL);
    abort();
  }

   /* Set error handling if you are using the setjmp/longjmp method (this is
    * the normal method of doing things with libpng).  REQUIRED unless you
    * set up your own error handlers in the png_create_read_struct() earlier.
    */

  if (setjmp(png_jmpbuf(png_ptr)))
  {
    /* Free all of the memory associated with the png_ptr and info_ptr */
    png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
    fclose(fp);
    printf("Problem reading file\n");
    /* If we get here, we had a problem reading the file */
    abort();
  }
  png_init_io(png_ptr, fp);
  png_set_sig_bytes(png_ptr, sig_read);

  png_read_info(png_ptr, info_ptr);

  png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type,
       &interlace_type, NULL, NULL);
  
  /* The easiest way to read the image: */
  png_bytep row_pointers[height];


  png_read_update_info(png_ptr, info_ptr);

  
  //png_read_image(png_ptr, row_pointers);

  //png_destroy_read_struct(&png_ptr, &info_ptr, NULL);
  //fclose(fp);
}

int main(int argc, char **argv)
{
  if (argc != 3) {
    printf("Usage: program_name <file_in> <file_out>\n");
    return 1;
  }

  FILE* fp = fopen(argv[1],"rb");
  if (!check_png(argv[1],&fp)) {
    printf("Not a PNG!\n");
    return 1;
  }
  printf("PNG has been opened\n");
  read_png_file(fp,BYTES_TO_CHECK);
  process_file();
  //if (write_png_file(argv[2])) {
  //  return 1;
  //}

  return 0;
}
