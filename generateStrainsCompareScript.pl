#!/usr/bin/perl

my ($strainsDir, $ref, $final) = @ARGV;

die "usage: perl generateStrainsCompareScript.pl strains_dir ref_file final_file\n" unless scalar(@ARGV) == 3;

if ($strainsDir =~ /(.+)\/$/) { $strainsDir = $1 }   # strip trailing /

# get list of files into array

my @comparators;

opendir(my $dh, $strainsDir) || die "can't opendir $strainsDir: $!";
foreach my $strainFile (readdir($dh)) {
  push(@comparators, $strainFile) unless ($strainFile !~ /\.bin$/ || "$strainsDir/$strainFile" eq $ref);
}
closedir $dh;

my $fifoCursor = 0;

print "set -e\n";
print "date\n";
print "mkfifo ";
for (my $i = 1; $i <= scalar(@comparators) *2; $i++) {
  print "fifo$i ";
}
print "\n";

my @mergeQueue;
foreach my $comparator (@comparators) {
  $fifoCursor++;
  print "./compareStrains $ref $strainsDir/$comparator > fifo$fifoCursor &\n";
  push(@mergeQueue, $fifoCursor);
}

while(1) {
  my $fifo1 = "fifo" . pop(@mergeQueue);
  my $fifo2 = "fifo" . pop(@mergeQueue);
  if (scalar(@mergeQueue) == 0) {
    print "./unionLocations $fifo1 $fifo2 > $final &\n";
    last;
  } else {
    $fifoCursor++;
    push(@mergeQueue, $fifoCursor);
    print "./unionLocations $fifo1 $fifo2 > fifo$fifoCursor &\n";
  }
}
print "wait\n";
print "rm ";
for (my $i = 1; $i <= scalar(@comparators) *2; $i++) {
  print "fifo$i ";
}
print "\n";
print "date\n";
print "exit\n";
