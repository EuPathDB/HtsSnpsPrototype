use strict;
my ($f1, $f2) = @ARGV;

open(F1, '<', $f1) || die "can't open f1";
open(F2, '<', $f2) || die "can't open f2";
binmode(F1);
binmode(F2);

$/ = \5; ## set record size

my @file1;
while(<F1>) {
  my ($loc1, $bp1) = unpack ('I c', $_);
  push(@file1,($loc1, $bp1));
}
my $file1sz = scalar(@file1);
my $i = 0;
my $start = time();
my $line2 = <F2>;
my ($loc2, $bp2) = unpack ('I c', $line2);
print STDERR "hello\n";
while(1) {
  while ($file1[$i] < $loc2 && $i < $file1sz) {
    print "$file1[$i]\n" unless $file1[$i+1] == 5;
    $i += 2;
  }
  while ($file1[$i] > $loc2 && $line2) {
    print "$loc2\n" unless $bp2 == 5;
    $line2 = <F2>;
    ($loc2, $bp2) = unpack ('I c', $line2);
  }
  if ($file1[$i] == $loc2) {
    print "$file1[$i]\n" if $file1[$i+1] != $bp2 && $file1[$i+1] != 5 && $bp2 != 5;
    $i+=2;
    $line2 = <F2>;
    ($loc2, $bp2) = unpack ('I c', $line2);
  }
  $i += 2 unless $line2;
  $line2 = <F2> unless $i < $file1sz;

  last unless $i < $file1sz || $line2;
}
my $end = time() - $start;
print STDERR "$end\n";
