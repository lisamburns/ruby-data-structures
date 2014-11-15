// You can compile this program by running `gcc main.c -o main`. Then
// you can run `./main`.
//
// normally we don't `#include` source files, but I'm making an
// exception here.
#include "./dynarray.c"

int main () {
  DynamicArray* dynArrp = createDynamicArray();

  // push a bunch of elements onto the array
  for (int i = 0; i < 25; i++) {
    // This creates strings
    char* str = malloc(255);
    snprintf(str, 255, "s%d", i);

    push(dynArrp, str);
  }

  // pop them all off
  while (length(dynArrp) > 0) {
    printf("#%d: %s\n", length(dynArrp) - 1, pop(dynArrp));
  }
  printf("Length: %d\n", length(dynArrp));

  return 0;
}
