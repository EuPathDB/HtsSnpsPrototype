use strict;

my ($start, $end, $snp_count) = @ARGV;
die "usage:  perl makeMultipleFakeStrainFiles.pl start end snp_count\n" unless scalar(@ARGV) == 3;

for (my $i=$start; $i<=$end; $i++) {
  my $cmd = "perl makeFakeStrainFile.pl /eupath/data/htsSnpsPrototype/strains/sample$i.bin $i $snp_count";
  print STDERR "$cmd\n";
  `$cmd`;
}
