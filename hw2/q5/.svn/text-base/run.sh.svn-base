
echo "Build Table and Number of 1 degree connections"
cat q0.sql
#echo "Results: "
sqlite3 patents.db < q0.sql

echo "Number of nodes"
cat q1.sql
echo "Results: "
time sqlite3 patents.db < q1.sql

echo "Number of 1 hop connections"
cat q2.sql
echo "Results: "
time sqlite3 patents.db < q2.sql

echo "The out degree distributoin"
cat q3.sql
sqlite3 patents.db < q3.sql > distribution.txt

# For example, you can use gnuplot to generate the plot from distribution.txt
# Should output q4-2.eps
#gnuplot degreeDistribution.dem

# Note for Q4-4 there is no code to run.  Just include your answer
echo "For Q4.4, there is an unusual number of nodes with out degree X"

echo "Average out degree"
cat q5.sql
echo "Results: "
sqlite3 patents.db < q5.sql

echo "Maximum out degree"
cat q6.sql
echo "Results: "
sqlite3 patents.db < q6.sql


echo "Total number of 2 hop away neighbors"
cat q7.sql
# Note given this will take a long time to run, comment it out to not run by default
#time sqlite3 patents.db < q6.sql

# If this takes over an hour for you, fill in the following answers:
echo "Q4.7.a: The following statements are true:"

# Include any intermediary queries needed to calculate the values.
echo "Q4.7.b numbers:"
cat q7b.sql 
echo "Results:"
sqlite3 patents.db < q7b.sql
