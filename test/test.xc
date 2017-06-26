#include "../include/tensorsLib.h"
int main(int argc, char **argv) {
	int sizeDim[2] = {2, 2};
	Tensor tensr = onesss(2, sizeDim);
    printt(tensr);
	return 0;
}
