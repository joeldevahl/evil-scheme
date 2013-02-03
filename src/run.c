#include <mmap.h>
#include <stdio.h>

typedef int (*func_t)();

int main(int argc, char** argv)
{
	int ret = -1;
	mmap_t handle;
	char* data;
	func_t func;

	handle = mmap_create(argv[1]);
	data = mmap_get_pointer(handle);

	func = (func_t)(data+1);
	ret = func();

	mmap_destroy(handle);
	
	printf("Image exited with retcode %d\n", ret);

	return ret;
}
