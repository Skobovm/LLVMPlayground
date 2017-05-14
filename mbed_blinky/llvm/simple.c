//#include <stdio.h>
#include "simple.h"

const char* declaredString = "Declared String";
//extern const char* lookup_table[];// = {"TableStr1", "TableStr22", "TableStr333"};
//const char* lookup_table[];
extern void tableLookupImpl(char* fill, int index);
extern void tableLookupSpaceImpl(char* fill, int words[], int wordCount);

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

void callPrint2(void)
{
	printStuff("Anonymous String 2");
}

void fakeFunc(void)
{
	char fakeString[10];
	int words[3] = {0, 1, 2};
	tableLookupSpace(fakeString, words, 3);
}

void printStuff(char* str)
{
	while(*str != 0)
	{
		*str = *str + 1;
		str++;
	}
}

void tableLookupSpace(char* fill, int words[], int wordCount)
{
	tableLookupSpaceImpl(fill, words, wordCount);
}

void tableLookup(char* fill, int index)
{
	tableLookupImpl(fill, index);
}
// TODO: this will need to change for real algo
// void tableLookup(char* fill, int index)
// {
	// char* lookup = lookup_table[index];
	// while(*lookup != 0)
	// //for(int i = 0; i < 5; i++)
	// {
		// *fill = *lookup;//65 + i;
		// fill++;
		// lookup++;
	// }
// }