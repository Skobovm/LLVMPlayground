#include <stdio.h>

extern "C"
{
	void addOne(int* i);
	char* getHWString(void);
	const char* getConstHWString(void);
}