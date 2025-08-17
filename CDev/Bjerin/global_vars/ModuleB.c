/* Module B*/
#include <stdio.h>


extern char name[]; /* Tell the compiler this exists but in another module*/

void print_name(void)
{
	name[ 3] = 'e'; //array is safe to modify
	printf("Programmer: %s\n", name);
}
