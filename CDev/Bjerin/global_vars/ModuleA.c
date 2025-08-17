/* Module A*/
#include <stdio.h>
#include <string.h>

char name[];

void print_name(void);
char name[50];
 
int main(void)
{
	strcpy(name, "Lennart Hyland"); //copy to array
	print_name();
	return 0;
}
