//#include <stdio.h>

#ifdef  __cplusplus
extern "C"
{
#endif
	//extern const char* mightWork;
	void addOne(int* i);
	//char* getHWString(void);
	const char* getConstHWString(void);
	void callPrint(void);
	void fakeFunc(void);
	void printStuff(char* str);
	void tableLookup(char* fill, int index);
	void tableLookupSpace(char* fill, int words[], int wordCount);

#ifdef  __cplusplus
}
#endif