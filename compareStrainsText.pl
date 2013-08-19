use strict;
my ($f1, $f2) = @ARGV;

open(F1, $f1);
open(F2, $f2);

my $line1 = <F1>;
my $line2 = <F2>;
my ($loc1, $bp1) = split(/:/, $line1);
my ($loc2, $bp2) = split(/:/, $line2);
while(1) {
  while ($loc1 < $loc2 && $line1) {
    print "$loc1\n" unless $bp1 eq "u\n";
    $line1 = <F1>;
    ($loc1, $bp1) = split(/:/, $line1);
  }
  while ($loc1 > $loc2 && $line2) {
    print "$loc2\n" unless $bp2 eq "u\n";
    $line2 = <F2>;
    ($loc2, $bp2) = split(/:/, $line2);
  }
  if ($loc1 == $loc2) {
    print "$loc1\n" if $bp1 ne $bp2 && $bp1 ne "u\n" && $bp1 ne "u\n";
    $line1 = <F1>;
    $line2 = <F2>;
    ($loc1, $bp1) = split(/:/, $line1);
    ($loc2, $bp2) = split(/:/, $line2);
  }
  $line1 = <F1> unless $line2;
  $line2 = <F2> unless $line1;

  last unless $line1 || $line2;
}
