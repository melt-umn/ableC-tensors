/************************************************************
                MATLAB MATRIX FUNCTION LIBRARY

Created by: Nguyen Nguyen
Modified by: Nguyen Nguyen
*************************************************************/

// Struct definition for Array Struct

typedef struct {
  int dim;
  int *dim_size;
  int count;
  int *data;
} Array;

// Function calls

Array create_identity_array(int);
Array int_to_array(int);
int array_to_int(Array);

/*
Array create_array(int, int*, int, int*);

void print_array(Array);
void print_array_ex(Array, int*, char**);
void fprintf_array(FILE*, Array);
void fprintf_array_ex(FILE*, Array, int*, char**);
void file_print_array(char*, Array);
void file_print_array_ex(char*, Array, int*, char**);
void print(Array);

Array read_array(char*,int*, int);

Array accessor_array(Array, int*);
Array cat_array(int, Array, Array);
Array tranpose_array(Array);

int array_to_int(Array);
Array int_to_array_ex(int, int);
Array int_to_array(int);
*/
