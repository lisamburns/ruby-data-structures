#include <stdlib.h>
#include <stdio.h>

typedef struct {
  int* storePtr;
  int numElements;
  int storeSize;
} DynamicArrayHeader;

DynamicArrayHeader* createDynamicArray(int startingStoreSize) {
  DynamicArrayHeader* dynArrHeader =
    malloc(sizeof(DynamicArrayHeader));
  dynArrHeader->numElements = 0;
  dynArrHeader->storeSize = startingStoreSize;

  dynArrHeader->storePtr = malloc(startingStoreSize * sizeof(int));

  return dynArrHeader;
}

int get(DynamicArrayHeader* dynArrHeader, int index) {
  if (index >= dynArrHeader->numElements) {
    exit(1);
  }

  int* integerMemoryAddress = dynArrHeader->storePtr + index;

  return *integerMemoryAddress;
}

void set(DynamicArrayHeader* dynArrHeader, int index, int value) {
  if (index >= dynArrHeader->numElements) {
    exit(1);
  }

  int* integerMemoryAddress = dynArrHeader->storePtr + index;

  *integerMemoryAddress = value;
}

void resize(DynamicArrayHeader* dynArrHeader) {
  int newStoreSize = 2 * dynArrHeader->storeSize;
  int* newStorePtr = malloc(newStoreSize * sizeof(int));

  for (int i = 0; i < dynArrHeader->numElements; i++) {
    int* newElPointer = newStorePtr + i;
    int* oldElPointer = dynArrHeader->storePtr + i;

    *newElPointer = *oldElPointer;
  }

  free(dynArrHeader->storePtr);
  dynArrHeader->storePtr = newStorePtr;
  dynArrHeader->storeSize = newStoreSize;
}

void push(DynamicArrayHeader* dynArrHeader, int value) {
  if (dynArrHeader->storeSize == dynArrHeader->numElements) {
    resize(dynArrHeader);
  }

  int* integerMemoryAddress =
    dynArrHeader->storePtr + dynArrHeader->numElements;

  *integerMemoryAddress = value;
  dynArrHeader->numElements += 1;
}

void pop(DynamicArrayHeader* dynArrHeader) {
  dynArrHeader->numElements -= 1;
}

int main () {
  DynamicArrayHeader* dynArrHeader = createDynamicArray(4);

  push(dynArrHeader, 2);
  push(dynArrHeader, 3);
  push(dynArrHeader, 5);
  push(dynArrHeader, 7);

  for (int i = 0; i < dynArrHeader->numElements; i++) {
    printf("%d\n", get(dynArrHeader, i));
  }

  push(dynArrHeader, 11);

  for (int i = 0; i < dynArrHeader->numElements; i++) {
    printf("%d\n", get(dynArrHeader, i));
  }
}
