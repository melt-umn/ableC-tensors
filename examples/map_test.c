#include "../src/tensorsLib.c"

//yo we gotta write legit test files soon lol
int main (int argc, char **argv) {
	int *dataTestOne = malloc(sizeof(int) * 2);
	dataTestOne[0] = 3;
	dataTestOne[1] = 3;

	int *dataTestTwo = malloc(sizeof(int));
	dataTestTwo[0] = 9;

  int *dataTestThree = malloc(sizeof(int)*3);
  dataTestThree[0] = 2;
  dataTestThree[1] = 3;
  dataTestThree[2] = 4;

  int *dataTestFour = NULL;

  Tensor tenOne = fill_tensor(2,dataTestOne,666);
  Tensor tenTwo = fill_tensor(1,dataTestTwo,2);
  Tensor tenThree = fill_tensor(3,dataTestTwo,100);
}
