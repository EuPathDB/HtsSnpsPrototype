#include <stdio.h>
#include <stdint.h>
#include <string.h> 

// using global variables to cut down on stack pushing operations.
FILE *f1;
FILE *f2;
int polymorphismThreshold;
int unknownsThreshold;
int strainCount;
char *sourceIdPrefix;
  

int16_t seq1;
int16_t *seq1p = &seq1;
int32_t loc1;
int32_t *loc1p = &loc1;
char a1;  // allele
char *a1p = &a1;
char p1;  // product
char *p1p = &p1;
int8_t s1;  // strain
int8_t *s1p = &s1;

// reference genome
int16_t refSeq = 0;
int16_t *refSeq_p = &refSeq;
int32_t refLoc = 0;
int32_t *refLoc_p = &refLoc;
char refAllele; 
char *refAllele_p = &refAllele;
char refProduct;
char *refProduct_p = &refProduct;

int a_count = 0;
int c_count = 0;
int g_count = 0;
int t_count = 0;
int U_count = 0; // unknown
int sumCount = 0;
int product;
int nonSyn;

main(int argc, char *argv[]) {

	if ( argc != 5 ) {
		printf( "usage: %s strainFile refGenomeFile strainCount polymorphismThreshold\n", argv[0] );
		return -1;
	}
	strainCount = atoi(argv[3]);
	polymorphismThreshold = atoi(argv[4]);

	f1 = fopen(argv[1], "rb");
	if (f1 == 0) {
		printf( "Can't open strainFile '%s' \n", argv[1] );
		return -1;
	}

	f2 = fopen(argv[1], "rb");
	if (f2 == 0) {
		printf( "Can't open refGenomeFile '%s' \n", argv[2] );
		return -1;
	}

	int f1got;
	int prevSeq = seq1;
	int prevLoc = loc1;

	// prime things by reading, but not processing, first SNP
	f1got = readStrainRow();
	product = p1;
	while (seq1 == prevSeq && loc1 == prevLoc && f1got != 0) {
		if (a1 == 1) a_count++;
		else if (a1 == 2) c_count++;
		else if (a1 == 3) g_count++;
		else if (a1 == 4) t_count++;
		else U_count++;
		sumCount++;
		if (product != p1) nonSyn = 1;
		f1got = readStrainRow();		
	}

	// read and process all the rest of the SNPs
	while(f1got != 0) {
		if (seq1 != prevSeq && loc1 != prevLoc) {
			processSnp(); // process prev SNP and clear counts
			product = p1; // get first product as a look-ahead
		}
		if (a1 == 1) a_count++;
		else if (a1 == 2) c_count++;
		else if (a1 == 3) g_count++;
		else if (a1 == 4) t_count++;
		else U_count++;
		sumCount++;
		if (p1 != product) nonSyn = 1; 
		product = p1;
		f1got = readStrainRow();
	}	
	processSnp(); // process final snp

	fclose(f1);
	fclose(f2);
	return 0;
}

int readStrainRow() {
	fread(seq1p, 2, 1, f1);  
	fread(loc1p, 4, 1, f1);  
	fread(a1p, 1, 1, f1); 
	fread(p1p, 1, 1, f1);
	return fread(s1p, 1, 1, f1);
}

getRefGenomeInfo(int16_t seq, int32_t loc) {
	while(refSeq != seq && refLoc != loc) {
		fread(refSeq_p, 2, 1, f2);  
		fread(refLoc_p, 4, 1, f2);  
		fread(refAllele_p, 1, 1, f2); 
		fread(refProduct_p, 1, 1, f2);
	}
}

processSnp() {

	if (U_count <= unknownsThreshold) {

		// get reference genome allele and product for this SNP
		getRefGenomeInfo(seq1, loc1);
		int ref_count = strainCount - sumCount; // sum_count includes unknowns

		if (ref_count > 0 && refProduct != product) nonSyn = 1;  // we saw some ref alleles, might have a second product

		// find major allele
		int *major_count;
		major_count =  &a_count;
		if (c_count > *major_count) major_count = &c_count;
		if (g_count > *major_count) major_count = &g_count;
		if (t_count > *major_count) major_count = &t_count;
		if (ref_count > *major_count) major_count = &ref_count;

		int polyMorphisms = sumCount - *major_count;
		if (polyMorphisms >= polymorphismThreshold) {
			printf("", sourceIdPrefix, seq1, loc1, U_count, polyMorphisms, nonSyn);
		}
	}
	a_count = 0;
	c_count = 0;
	g_count = 0;
	t_count = 0;
	U_count = 0;
	sumCount = 0;
}


