use strict;
my ($outputFile, $seed) = @ARGV;
die "usage:  makeFakeSnpsFile.pl output_file seed" unless scalar(@ARGV) == 2;
my $i=0;
my $bp = 1;
my $range = 500;

srand $seed;
my @x = ('a', 'c', 'g', 't');
my $inc;
open(my $out, '>:raw', $outputFile) || die "can't open: $!";
while($i++ < 5000000) {
  $inc = int(rand($range));
  $bp += $inc;
  my $s = 5;
  $s = $i % 4 - 1 unless $inc % 10;
  print $out pack("I c", $bp, $s);
}
