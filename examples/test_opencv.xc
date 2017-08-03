//found at: https://www.lemoda.net/c/write-png/

#include <png.h>

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdarg.h>

int main() {
  char header[8];
  FILE *fp = fopen("../../../../high_fidelity.png","rb");
  if(!fp)
  {
    printf("File not found\n");
    return 1;
  }
  fread(header,1,8,fp);
  int is_png = !png_sig_cmp(header,0,8);
  if (!is_png)
  {
    printf("File is not PNG\n");
    return 1;
  }
  printf("PNG File!\n");
  return 0;
}
