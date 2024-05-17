-- Load data from HDFS
episode4Dialogues = LOAD 'hdfs:///user/lalitham/episodeIV_dialogues.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);
episode5Dialogues = LOAD 'hdfs:///user/lalitham/episodeV_dialogues.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);
episode6Dialogues = LOAD 'hdfs:///user/lalitham/episodeVI_dialogues.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);

-- Filter out the first 2 lines from each file 
rank4 = RANK episode4Dialogues;
dialouges4 = FILTER rank4 BY (rank_epi4dia > 2);
rank5 = RANK episode5Dialogues;
dialouges5 = FILTER rank5 BY (rank_epi5dia > 2);
rank6 = RANK episode6Dialogues;
dialouges6 = FILTER rank6 BY (rank_epi6dia > 2);

-- Merge the three inputs
input = UNION dialouges4, dialouges5, dialouges6;

-- Group by name
grpName = GROUP input BY name;

-- Count the number of lines by each character
names = FOREACH grpName GENERATE $0 as name, COUNT($1) AS no_of_lines;
namesOrder = ORDER names BY no_of_lines DESC;

--Store result in HDFS
STORE namesOrder into 'hdfs:///user/lalitham/pigOutput1' USING PigStorage('\t');