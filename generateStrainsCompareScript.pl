#!/usr/bin/perl

my ($strainsDir, $ref) = @ARGV;
# get list of files into array

my @comparators;
my $ref;

opendir(my $dh, $strainsDir) || die "can't opendir $strainsDir: $!";
foreach my $strainFile (readdir($dh)) {
  push(@comparators, $strainFile) unless ($strainFile =~ /^./ || "$strainsDir/$strainFile" eq $ref);
}
closedir $dh;

my $fifoCursor = 1;

print "set -e";
print "date\n"
print "mkfifo ";
for (my $i = 1; $i <= scalar(@comparators) *2; $i++) {
  print "fifo$i ";
}
print "\n";

my @mergeQueue;
foreach my $comparator (@comparators) {
  print "./compareStrains $ref $comparator > fifo$fifoCursor\n";
  push(@mergeQueue, $fifoCursor);
  $fifoCursor++;
}

while(1) {
  my $fifo1 = "fifo" . pop(@mergeQueue);
  my $fifo2 = "fifo" . pop(@mergeQueue);
  if (scalar(@mergeQueue) == 0) {
    print "./mergLocations $fifo1 $fifo2 > $final\n";
    last;
  } else {
    push(@mergeQueue, $fifoCursor++);
    print "./mergLocations $fifo1 $fifo2 > fifo$fifoCursor\n";
  }
}
print "wait\n";
print "rm ";
for (my $i = 1; $i <= scalar(@comparators) *2; $i++) {
  print "fifo$i ";
}
print "\n";
print "date\n"
print "exit\n"
