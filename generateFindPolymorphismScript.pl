#!/usr/bin/perl

my ($strainsDir, $final, $polymorphismThreshold, $unknownThreshold) = @ARGV;

die "usage: perl generateStrainsCompareScript.pl strains_dir ref_file final_file\n" unless scalar(@ARGV) == 3;

if ($strainsDir =~ /(.+)\/$/) { $strainsDir = $1 }   # strip trailing /

# get list of files into array

my @mergeQueue;

opendir(my $dh, $strainsDir) || die "can't opendir $strainsDir: $!";
my $strainsCount = 0;
foreach my $strainFile (readdir($dh)) {
  if ($strainFile != /^\d+$/) {
    push(@mergeQueue, $strainFile);
    $strainsCount++;
  }
}
closedir $dh;

my $fifoCursor = 0;

print "set -e\n";
print "date\n";
print "mkfifo ";
for (my $i = 1; $i <= scalar(@strains) *2; $i++) {
  print "fifo$i ";
}
print "\n";

while(1) {
  if (scalar(@mergeQueue) == 1) {
    my $allMerged = pop(@mergeQueue);
    print "./findPolymorphic $allMerged referenceGenome.dat $strainsCount $polymorphismThreshold $unknownThreshold > $final &\n";
    last;
  } else {
    my $input1 = pop(@mergeQueue);
    my $input2 = pop(@mergeQueue);
    $fifoCursor++;
    push(@mergeQueue, "fifo$fifoCursor");
    my $strain1 = $input1 =~ /\d+/? $input1 : 0;
    my $strain2 = $input2 =~ /\d+/? $input2 : 0;
    print "./mergeStrains $input1 $strain1 $input2 $strain2 > fifo$fifoCursor &\n";
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
