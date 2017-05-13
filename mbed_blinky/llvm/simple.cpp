#include <stdio.h>
#include "simple.h"

const char* mightWork = "Thisstringmightwork";

void addOne(int* i)
{
	(*i)++;
}

// char* getHWString(void)
// {
	// return retArr;
// }

const char* getConstHWString(void)
{
	return "Thisstringdoesnotwork";
}
