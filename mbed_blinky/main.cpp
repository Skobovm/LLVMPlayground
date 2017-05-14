#include "mbed.h"
#include "simple.h"

//extern const char* mightWork;

DigitalOut myled(LED1);

extern "C"
{
	//const char* table[] = {"TableStr1", "TableStr22", "TableStr333"};
	extern char* lookup_table[];
	
	void printFunc(const char* val)
	{
		printf("%s\n", val);
	}
	
	const char* getConstGoodString(void)
	{
		return "Thisstringwillwork";
	}
	
	void tableLookupImpl(char* fill, int index)
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
}

int main() {
	int count = 0;

    while(1) {
        myled = 1;
        wait(0.2);
        myled = 0;
        wait(0.2);
		//printf("%s\n", getHWString());
		//printf(": %d\n", count);
		callPrint();
		//printf("Might work? %s\n", mightWork);
		//printf("Const: %s\n", getConstHWString());
		//printf("Goodstr: %s\n", getConstGoodString());
		//printf("Count: %d\n", count);
		//addOne(&count);
		while(1)
		{
			myled = 1;
			wait(0.2);
			myled = 0;
			wait(0.2);
		}
    }
}
