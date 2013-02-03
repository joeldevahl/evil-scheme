#ifndef MMAP_H
#define MMAP_H

typedef struct mmap_s* mmap_t;

mmap_t mmap_create(const char* filename);
void mmap_destroy(mmap_t handle);

void* mmap_get_pointer(mmap_t handle);

#endif // MMAP_H
