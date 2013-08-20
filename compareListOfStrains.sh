set -e
date
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample1.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample2.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample3.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample4.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample5.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample6.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample7.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample8.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample9.bin | wc &
./compareStrainsBinaryC  /eupath/data/htsSnpsPrototype/fakeData/sample11.bin /eupath/data/htsSnpsPrototype/fakeData/sample10.bin | wc &
exit
