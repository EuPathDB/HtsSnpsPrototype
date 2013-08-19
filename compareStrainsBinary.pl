use strict;
my ($f1, $f2) = @ARGV;

open(F1, '<', $f1) || die "can't open f1";
open(F2, '<', $f2) || die "can't open f2";
binmode(F1);
binmode(F2);

$/ = \5; ## set binary record size

# the input data is two files each containing a list of 5 byte records.
# the first 4 bytes are a 32 bit int (a genome location) and 5th is a value (1-5) for that location.
# the program scans both inpust and returns locations unique to each,
# as well as shared locations where the value is different (unless the value
# is a 5).   There is a meaning to all this in the domain of genomics and
# polymorphism which is another story.

my $line1 = <F1>; # read a record from file 1
my $line2 = <F2>;
my ($loc1, $bp1) = unpack ('I c', $line1); # unpack it into the location and value
my ($loc2, $bp2) = unpack ('I c', $line2);
while(1) {
  while ($loc1 < $loc2 && $line1) { # $line1 evaluates to false if EOF
    print "$loc1\n" unless $bp1 == 5;
    $line1 = <F1>;
    ($loc1, $bp1) = unpack ('I c', $line1);
  }
  while ($loc1 > $loc2 && $line2) {
    print "$loc2\n" unless $bp2 == 5;
    $line2 = <F2>;
    ($loc2, $bp2) = unpack ('I c', $line2);
  }
  if ($loc1 == $loc2) {
    print "$loc1\n" if $bp1 != $bp2 && $bp1 != 5 && $bp2 != 5;
    $line1 = <F1>;
    $line2 = <F2>;
    ($loc1, $bp1) = unpack ('I c', $line1);
    ($loc2, $bp2) = unpack ('I c', $line2);
  }
  $line1 = <F1> unless $line2;
  $line2 = <F2> unless $line1;

  last unless $line1 || $line2;
}
