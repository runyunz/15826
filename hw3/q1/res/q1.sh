echo "Q0: Clean up directory"
bin/hadoop fs -rmr /reddit_titles/
bin/hadoop fs -rmr /reddit_output/
echo "---------------------------------------"
echo "Q1: Create directory and upload dataset"
bin/hadoop fs -mkdir /reddit_titles/
bin/hadoop fs -put reddit_titles/reddit_titles.csv /reddit_titles/
echo "---------------------------------------"
echo "Q2: Compile WordCount"
cd ngram
./compile.sh WordCount
cd ..
echo "---------------------------------------"
echo "Q3: Run WordCount and report the number of unique words"
bin/hadoop jar ngram/WordCount.jar WordCount /reddit_titles/ /reddit_output/word_count
echo "Number unique words"
bin/hadoop fs -cat /reddit_output/word_count/part-00000 | wc -l
echo "---------------------------------------"
echo "Q4: Run NGram and Output"
cd ngram
./compile.sh NGram
cd ..
echo "---------------------------------------"
echo "Q5: Report number of bigrams(n=2) occur at least 100 times"
bin/hadoop jar ngram/NGram.jar NGram -Dngram.n=2 -Dngram.m=100 /reddit_titles/ /reddit_output/ngram
echo "Number of trigrams(n=2) occur at least 100 times"
bin/hadoop fs -cat /reddit_output/ngram/part-00000 | wc -l
echo "---------------------------------------"
echo "Q6: List the top 20 most common bigrams and the number of times they occur"
bin/hadoop fs -cat /reddit_output/ngram/part-00000 | sort -nrk 2 | head -n20
echo "---------------------------------------"
echo "Q7: Report number of trigrams(n=3) occur at least 20 times"
bin/hadoop jar ngram/NGram.jar NGram -Dngram.n=3 -Dngram.m=20 /reddit_titles/ /reddit_output/tringram
echo "Number of trigrams(n=3) occur at least 20 times"
bin/hadoop fs -cat /reddit_output/tringram/part-00000 | wc -l
echo "---------------------------------------"
echo "Q8: List the top 20 most common trigrams and the number of times they occur"
bin/hadoop fs -cat /reddit_output/tringram/part-00000 | sort -nrk 2 | head -n20
