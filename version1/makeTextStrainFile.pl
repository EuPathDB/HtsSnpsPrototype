use strict;
my $i=0;
my $bp = 1;
my $range = 500;
srand 1;
my @x = ('a', 'c', 'g', 't');
my $inc;
while($i++ < 5000000) {
  $inc = int(rand($range));
  $bp += $inc;
  my $s = 'u';
  $s = $x[$i % 4 - 1] unless $inc % 10;
  print "$bp:$s\n";
}
