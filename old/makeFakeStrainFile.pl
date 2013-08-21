use strict;
my ($outputFile, $seed, $snp_count) = @ARGV;
die "usage:  makeFakeSnpsFile.pl output_file seed snp_count\n" unless scalar(@ARGV) == 3;
my $i=0;
my $bp = 1;
my $range = 500;

srand $seed;
my $inc;
open(my $out, '>:raw', $outputFile) || die "can't open: $!\n";
while($i++ < $snp_count) {
  $inc = int(rand($range)) + 1;
  $bp += $inc;
  my $s = 5;
  $s = $i % 4 unless $inc % 10;
  print $out pack("I c", $bp, $s);
}
