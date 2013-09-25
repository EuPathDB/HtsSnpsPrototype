#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <sys/types.h> // to get pid
#include <unistd.h>    // to get pid
main(int argc, char *argv[]) {
	FILE *f1;
	FILE *f2;

  int32_t loc1;
  int32_t *loc1p = &loc1;
  char bp1;
  char *bp1p = &bp1;

  int32_t loc2;
  int32_t *loc2p = &loc2;
  char bp2;
  char *bp2p = &bp2;
	time_t now;
  struct tm *current;

	int pid;
	FILE *fp;
	char buffer [50];
	
	/*
	pid = getpid();
	sprintf(buffer, "%i", pid);
	fp = fopen(buffer, "w");
	fprintf(fp, "start: compareStrains %s %s\n", argv[1], argv[2]);
	fclose(fp);
	*/

	//	fprintf(stderr, "start: compareStrains %s %s\n", argv[1], argv[2]);

	if ( argc != 3 ) {
		printf( "usage: %s file1 file2\n", argv[0] );
		return -1;
	}

	f1 = fopen(argv[1], "rb");
	if (f1 == 0) {
		printf( "Can't open file1 '%s' \n", argv[1] );
		return -1;
	}
	f2 = fopen(argv[2], "rb");
	if (f2 == 0) {
		printf( "Can't open file2 '%s' \n", argv[2] );
		return -1;
	}

	int f1got;
	int f2got;
	f1got = fread(loc1p, 4, 1, f1);  f1got = fread(bp1p, 1, 1, f1);
	f2got = fread(loc2p, 4, 1, f2);  f2got = fread(bp2p, 1, 1, f2);

	while(1 == 1) {
		while (loc1 < loc2 && f1got != 0) { 
			if (bp1 != 5) fwrite(loc1p, 4, 1, stdout); 

			f1got = fread(loc1p, 4, 1, f1);  f1got = fread(bp1p, 1, 1, f1);
		}
		while (loc1 > loc2 && f2got != 0) { 
			if (bp2 != 5) fwrite(loc2p, 4, 1, stdout);
			f2got = fread(loc2p, 4, 1, f2);  f2got = fread(bp2p, 1, 1, f2);
		}
		if (loc1 == loc2) {
			if (bp1 != bp2 && bp1 != 5 && bp2 != 5) fwrite(loc2p, 4, 1, stdout);
			f1got = fread(loc1p, 4, 1, f1);  f1got = fread(bp1p, 1, 1, f1);
			f2got = fread(loc2p, 4, 1, f2);  f2got = fread(bp2p, 1, 1, f2);
		}
		if (f1got == 0) {	
			f2got = fread(loc2p, 4, 1, f2);  f2got = fread(bp2p, 1, 1, f2);
		}
		if (f2got == 0) {
			f1got = fread(loc1p, 4, 1, f1);  f1got = fread(bp1p, 1, 1, f1);
		}
		if (f1got == 0 && f2got ==0) break;
	}
	fclose(f1);
	fclose(f2);
	//	time(&now);
	//  current = localtime(&now);
	//	fprintf(stderr, "done: %i:%i:%i compareStrains %s %s\n", current->tm_hour, current->tm_min, current->tm_sec, argv[1], argv[2]);
	return 0;
}

