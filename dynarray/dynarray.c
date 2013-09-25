#include "stdlib.h"
#include "stdio.h"

// Notes:

// * `malloc(numBytes)` returns `numBytes` of allocated storage.
// * `typedef struct { ... } XYZ` defines a struct in C. A struct is
//   like an object without methods. The "methods" are defined as
//   functions below.
// * A `void*` is a pointer to an unknown type of object. This array
//   stores pointers (references) to objects.
// * `sizeof(XYZ)` returns the number of bytes it takes to store an
//   object. Presumably `sizeof(void*) == 8` since on a 64bit machine
//   a word is eight bytes long.
// * Given a pointer to a struct (like `void* darrp`), we access an
//  instance variable by `darrp->fieldName`.

void error(char* message) {
  printf("%s\n", message);

  exit(1);
}

int DEFAULT_SIZE = 10;

typedef struct {
  void** _store;
  int _storeLen;

  int _len;
} DynamicArray;

DynamicArray* makeArray() {
  DynamicArray* darrp = malloc(sizeof(DynamicArray));

  darrp->_store = malloc(DEFAULT_SIZE * sizeof(void*));
  darrp->_storeLen = DEFAULT_SIZE;
  darrp->_len = 0;

  return darrp;
}

int length (DynamicArray* darrp) {
  return darrp->_len;
}

void* get (DynamicArray* darrp, int idx) {
  if ((idx < 0) || (idx >= darrp->_len)) {
    error("Access out of range!");
  }

  return darrp->_store[idx];
}

void set (DynamicArray* darrp, int idx, void* objp) {
  if ((idx < 0) || (idx >= darrp->_len)) {
    error("Set out of range");
  }

  (darrp->_store)[idx] = objp;
}

void resize (DynamicArray* darrp) {
  printf("Resizing!\n");

  int newStoreLen = darrp->_storeLen * 2;
  void** newStore = malloc(newStoreLen * sizeof(void*));

  for (int i = 0; i < darrp->_storeLen; i++) {
    newStore[i] = (darrp->_store)[i];
  }

  // release the old store
  free(darrp->_store);
  darrp->_store = newStore;
  darrp->_storeLen = newStoreLen;
}

void push (DynamicArray* darrp, void* objp) {
  if (darrp->_len == darrp->_storeLen) {
    resize(darrp);
  }

  (darrp->_store)[darrp->_len] = objp;
  darrp->_len += 1;
}

void* pop (DynamicArray* darrp) {
  if (darrp->_len == 0) {
    error("popped empty array");
  }

  void* objp = darrp->_store[darrp->_len - 1];
  darrp->_len -= 1;

  return objp;
}
