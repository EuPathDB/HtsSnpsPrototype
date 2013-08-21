#include <stdio.h>
#include <stdint.h>
#include <string.h>
main(int argc, char *argv[]) {
	FILE *f1;

  int32_t loc1;
  int32_t *loc1p = &loc1;

	if ( argc != 2 ) {
		printf( "usage: %s file1\n", argv[0] );
		return -1;
	}

	f1 = fopen(argv[1], "rb");
	if (f1 == 0) {
		printf( "Can't open file1 '%s' \n", argv[1] );
		return -1;
	}
	int f1got;
	f1got = fread(loc1p, 4, 1, f1);

	while(f1got != 0) {
		printf("%i\n",  loc1);
		f1got = fread(loc1p, 4, 1, f1);
	}
	fclose(f1);
	return 0;
}

