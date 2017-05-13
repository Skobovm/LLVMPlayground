#include "mbed.h"
#include "simple.h"

extern const char* mightWork;

DigitalOut myled(LED1);

extern "C"
{
	void printFunc(const char* val)
	{
		printf("%s\n", val);
	}
	
	const char* getConstGoodString(void)
	{
		return "Thisstringwillwork";
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
		printf("Might work? %s\n", mightWork);
		printf("Const: %s\n", getConstHWString());
		printf("Goodstr: %s\n", getConstGoodString());
		printf("Count: %d\n", count);
		addOne(&count);
    }
}
