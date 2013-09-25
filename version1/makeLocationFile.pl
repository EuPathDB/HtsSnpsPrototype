use strict;
my ($outputFile, $seed) = @ARGV;
die "usage:  makeFakeSnpsFile.pl output_file seed" unless scalar(@ARGV) == 2;
my $i=0;
my $bp = 1;
my $range = 5;

srand $seed;
my $inc;
open(my $out, '>:raw', $outputFile) || die "can't open: $!";
while($i++ < 10) {
  $inc = int(rand($range)) + 1;
  $bp += $inc;
  print $out pack("I", $bp);
}
