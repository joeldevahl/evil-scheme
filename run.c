#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdio.h>

typedef int (*func_t)();

int main(int argc, char** argv)
{
	int ret = -1;
	struct stat buffer;
	func_t func;
	const char * filename = argv[1];
	int fd = open(filename, O_RDONLY);
	fstat(fd, &buffer);
	func = (func_t)mmap(0, buffer.st_size, PROT_READ | PROT_EXEC, MAP_PRIVATE, fd, 0);
	ret = func();
	munmap(func, buffer.st_size);
	close(fd);
	
	printf("Image exited with retcode %d\n", ret);

	return ret;
}
