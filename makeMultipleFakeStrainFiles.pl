use strict;

my ($start, $end) = @ARGV;
die "usage:  perl makeMultipleFakeStrainFiles.pl start end\n" unless scalar(@ARGV) == 2;

for (my $i=$start; $i<=$end; $i++) {
  my $cmd = "perl makeFakeStrainFile.pl /eupath/data/htsSnpsPrototype/strains/sample$i.bin $i";
  print STDERR "$cmd\n";
  `$cmd`;
}
