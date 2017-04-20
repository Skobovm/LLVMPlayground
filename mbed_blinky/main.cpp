#include "mbed.h"
#include "simple.h"

DigitalOut myled(LED1);

int main() {
	int count = 0;

    while(1) {
        myled = 1;
        wait(0.2);
        myled = 0;
        wait(0.2);
		printf("%s\n", getHWString());
		printf(": %d\n", count);
		printf("Const: %s\n", getConstHWString());
		printf(": %d\n", count);
		addOne(&count);
    }
}
