use strict;
my ($outputFile, $seed, $snp_count) = @ARGV;
die "usage:  makeFakeSnpsFile.pl output_file seed snp_count\n" unless scalar(@ARGV) == 3;

srand $seed;
open(my $out, '>:raw', $outputFile) || die "can't open: $!\n";
for (my $snp = 0; $snp < $snp_count; $snp++) {
  if (rand(1) < .5) {
    my $allele = int(rand(20)) + 1;
    $allele = 5 if $allele > 4;
    print $out pack("I c", $snp, $allele);
  }
}
