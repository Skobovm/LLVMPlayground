#include <stdio.h>
#include "simple.h"

extern "C"
{
	char retArr[] = "Hello, World!";

	void addOne(int* i)
	{
		(*i)++;
	}

	char* getHWString(void)
	{
		return retArr;
	}

	const char* getConstHWString(void)
	{
		return "I-do-not-get-linked-correctly";
	}
}