//#include <stdio.h>
#include "simple.h"

const char* declaredString = "Declared String";
const char* lookup_table[] = {"TableStr1", "TableStr22", "TableStr333"};
//const char* lookup_table[];

void addOne(int* i)
{
	(*i)++;
}

//__attribute__((annotate("telemetry")))
const char* getConstHWString(void)
{
	return declaredString;
}

void callPrint(void)
{
	printStuff("Anonymous String 1");
}

void fakeFunc(void)
{
	//char fakeString[10];
	//tableLookup(fakeString, 0);
}

void printStuff(char* str)
{
	while(*str != 0)
	{
		*str = *str + 1;
		str++;
	}
}

// TODO: this will need to change for real algo
void tableLookup(char* fill, int index)
{
	char* lookup = lookup_table[index];
	while(*lookup != 0)
	//for(int i = 0; i < 5; i++)
	{
		*fill = *lookup;//65 + i;
		fill++;
		lookup++;
	}
}