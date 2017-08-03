//found and slightly modified at: http://zarb.org/~gc/html/libpng.html

#include <png.h>

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>

int main() {
  char *file_name = "../../../../high_fidelity.png"

  //test to see if file is png
  char header[8];
  FILE *fp = fopen(file_name,"rb");
  if(!fp) {
    printf("File %s not found\n", file_name);
    return 1;
  }
  fread(header,1,8,fp);
  int is_png = !png_sig_cmp(header,0,8);
  if (!is_png) {
    printf("File %s is not PNG\n", file_name);
    return 1;
  }
  printf("PNG File %s has been opened!\n", file_name);

  //initialize stuffs

  png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
  if (!png_ptr) {
    printf("png_create_read_struct failed");
    return 1;
  }

  info_ptr = png_create_info_struct(png_ptr);
  if (!info_ptr) {
    printf("png_create_info_struct failed");
    return 1
  }

  if (setjmp(png_jmpbuf(png_ptr)))) {
    printf("Error during init_io");
    return 1
  }
  return 0;
}
