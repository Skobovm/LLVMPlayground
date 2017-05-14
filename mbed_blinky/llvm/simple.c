
#include "simple.h"

const char* declaredString = "Declared String";
extern void tableLookupImpl(char* fill, int index);
extern void tableLookupSpaceImpl(char* fill, int words[], int wordCount);

void addOne(int* i)
{
	(*i)++;
}

const char* getConstHWString(void)
{
	return declaredString;
}

void callPrint(void)
{
	printStuff("Anonymous String 1");
	printStuff("Test 1");
	//printStuff("Stuff");
}

void callPrint2(void)
{
	printStuff("Anonymous String 2");
	//printStuff("Test 2");
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

// void tableLookup(char* fill, int index)
// {
	// tableLookupImpl(fill, index);
// }
