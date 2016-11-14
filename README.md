# hiv-grade

This is a combination of scripts that we use to call the online hiv-grade services which you can find on http://www.hiv-grade.de/ or http://www.hiv-grade.de/cms/grade/homepage/

You need to prepare some settings before the scripts can be used (those settings/arguments will be different depending on your dataset).

To ease the explanation, we suppose our initial fasta file is called sequences.fasta and contains fasta sequences in the format

```
>1
AA-GGTT ...
>2
TT-GGAT ...
```

etc

The online webservice from hiv-grade cannot handle big input files at once. That's why we'll cut our original input file into small subfiles before we start.
This is done by first of all creating a folder output
```
mkdir output
```
and then calling the fasta_split.pl script as follows
```
perl fasta_split.pl --input_file sequences.fasta --output_dir output/ --seqs_per_file=50
```

This will create x new fasta files in the output folder which each fasta containing 50 sequences.

Before we can call the hiv-grade analysis script, we need to install Forkmanager because we want to run all the processes in parallel.
This can be done as follows (as sudo best):
```
cpan Parallel::ForkManager
```
Also install JSON if necessary
```
sudo cpan JSON
```


You'll have to replace the variable $MAX_PROCESSES variable in loop_files.pl (line 7) to the amount of maximum processes you want to run at the same time. Basically, how many concurrent requests can be made to the hiv-grade website (e.g. 4).
Next we'll call the script.
```
perl loop_files.pl
```

This will analyse the fasta file on the hiv-grade website and output the result as a JSON file in the output folder.
By default the algorithms used are 'GRADE', 'ANRS', 'HIVDB', 'Rega'
If you would like to use less or more algorithms (more is obviously dependent on the availability) this can be done by changing line 39 in hiv-grade.pl
```
'Algorithms'   => ['GRADE', 'ANRS', 'HIVDB', 'Rega'],
```
to suit your needs

If everything goes well, you should now end up with x JSON files which we'll combine to a csv file with our java class JSONParser.java
Before we use this file, make sure that you replace the locations in the Java class with the correct paths
```
javac -cp json-20160810.jar:. JSONParser.java
java -cp json-20160810.jar:. JSONParser
```

Change 
File dir = new File("/Users/ewout/Documents/Kristof/script/output");
String basePath = "/Users/ewout/Documents/Kristof/script/output/";
 in JSONParser.java as well to the correct folder, and recompile. 
