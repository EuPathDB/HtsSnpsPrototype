set -e
date
mkfifo f100 f101 f102 f103 f104 f105 f106 f107 f108 f109
mkfifo f201 f202 f203 f204 f205
mkfifo f301 f302
mkfifo f401
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample1.bin > f100 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample2.bin > f101 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample3.bin > f102 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample4.bin > f103 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample5.bin > f104 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample6.bin > f105 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample7.bin > f106 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample8.bin > f107 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample9.bin > f108 &
./compareStrains  /eupath/data/htsSnpsPrototype/strains/sample11.bin /eupath/data/htsSnpsPrototype/strains/sample10.bin > f109 &
./unionLocations f100 f101 > f201 &
./unionLocations f102 f103 > f202 &
./unionLocations f104 f105 > f203 &
./unionLocations f106 f107 > f204 &
./unionLocations f108 f109 > f205 &
./unionLocations f201 f202 > f301 &
./unionLocations f203 f204 > f302 &
./unionLocations f301 f302 > f401 &
./unionLocations f401 f205 > /eupath/data/htsSnpsPrototype/fakeData/final &
wait
date
rm f100 f101 f102 f103 f104 f105 f106 f107 f108 f109
rm f201 f202 f203 f204 f205
rm f301 f302
rm f401
exit
