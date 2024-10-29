#include "uart.h"

#define START_ADDR ((void *) 0xA0000000)

unsigned char *linux_addr;
unsigned int linux_size;

void mymemcpy(unsigned char *dst, unsigned char *src, unsigned int size);

void _start(void)
{
	void (*entry)(void);

	prints("Linuxstarter...\n");

	/* Disable interrupts */
	__asm__ __volatile__("di\n");

	/* Copy linux kernel */
	mymemcpy(START_ADDR, linux_addr, linux_size);

	prints("Starting uncached.");

	entry = START_ADDR;
	prints("Jumping to ");
	printx((unsigned long) entry);
	prints("\n");
	entry();
}

void mymemcpy(unsigned char *dst, unsigned char *src, unsigned int size)
{
	unsigned int n;

	for (n = 0; n < size; n++) {
		dst[n] = src[n];
	}
}
