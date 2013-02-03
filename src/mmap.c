#include <mmap.h>

struct mmap_s
{
	HANDLE file;
};

mmap_t mmap_create(const char* filename)
{
	mmap_t handle = (mmap_t)malloc(sizeof(struct mmap_s));

	handle->file = CreateFile(filename, GENERIC_READ | GENERIC_EXECUTE, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_FLAG_RANDOM_ACCESS, NULL);

	return handle;
}

void mmap_destroy(mmap_t handle)
{
	CloseHandle(handle->file);
	free(handle);
}

void* mmap_get_pointer(mmap_t handle)
{
	return 0x0;
}

/*
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stdio.h>

	int ret = -1;
	struct stat buffer;
	func_t func;
	const char * filename = argv[1];
	char* data;
	int fd = open(filename, O_RDONLY);
	fstat(fd, &buffer);
	data = (char*)mmap(0, buffer.st_size, PROT_READ | PROT_EXEC, MAP_PRIVATE, fd, 0);
	func = (func_t)(data+1);
	ret = func();
	munmap(func, buffer.st_size);
	close(fd);
*/
