#include <stdio.h>
#include <stdint.h>
main() {
  int32_t loc1;
  int32_t *loc1p = &loc1;
  int32_t loc2;
  int32_t *loc2p = &loc2;

	read(3, loc1p, 4);
	read(4, loc2p, 4);
	write(5, loc1p, 4);
  printf("%i %i\n",  loc1, loc2);
}
