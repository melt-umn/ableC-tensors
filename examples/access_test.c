#include "../include/tensorsLib.h"
#include <stdio.h>

int main(char *argc, char **argv) {
	printf("\n\nAccess Tensor test:\n");

	//Constructing tensor
	
	int dimSizes[] = {2, 2};
	int data[] = {1, 2, 3, 4};

	Tensor test = {2, dimSizes, 4, data};
	//Tensor constructed
	
	//Costructing aux data structures for access
	int dimOfInterval = 1;
	Interval interval = {0, 1};
	int accessAlongRemaining[] = {1};
	int accessAlongRemainingSize = 1;

	print_tensor(access_tensor(test, dimOfInterval, interval, accessAlongRemaining, accessAlongRemainingSize), delimiters, 10);

	return 0;
}
