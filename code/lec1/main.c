// normally we don't `#include` source files, but I'm making an
// exception here.
#include "./dynarray.c"

int main () {
  DynamicArray* darrp = makeArray();

  // push a bunch on
  for (int i = 0; i < 25; i++) {
    char* str = malloc(255);
    snprintf(str, 255, "s%d", i);

    push(darrp, str);
  }

  // pop it all off
  while (length(darrp) > 0) {
    printf("#%d: %s\n", length(darrp) - 1, pop(darrp));
  }
  printf("Length: %d\n", length(darrp));

  return 0;
}
