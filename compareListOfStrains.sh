set -e
date
mkfifo f100 f101 f102 f103 f104 f105 f106 f107 f108 f109
mkfifo f201 f202 f203 f204 f205
mkfifo f301 f302
mkfifo f401
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample1.bin > f100 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample2.bin > f101 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample3.bin > f102 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample4.bin > f103 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample5.bin > f104 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample6.bin > f105 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample7.bin > f106 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample8.bin > f107 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample9.bin > f108 &
./compareStrains  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample10.bin > f109 &
./mergeLocations f100 f101 > f201 &
./mergeLocations f102 f103 > f202 &
./mergeLocations f104 f105 > f203 &
./mergeLocations f106 f107 > f204 &
./mergeLocations f108 f109 > f205 &
./mergeLocations f201 f202 > f301 &
./mergeLocations f203 f204 > f302 &
./mergeLocations f301 f302 > f401 &
./mergeLocations f401 f205 > /eupath/data/htsSnpsPrototype/fakeData/final &
wait
date
rm f100 f101 f102 f103 f104 f105 f106 f107 f108 f109
rm f201 f202 f203 f204 f205
rm f301 f302
rm f401
exit
