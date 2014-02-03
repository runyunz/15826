echo "Running FDNQ on dataset 0"
#add call to FDNQ here. Say the output of the code is 'dataset0.dat.points'
perl fdnq.pl -q2 dataset0.dat

echo "Plotting correlation integral for dataset 0"
echo "set term pdf; set logscale x; set logscale y; set output'dataset0.pdf'; plot 'dataset0.dat.points' with linespoints" | gnuplot 

echo "Running FDNQ on dataset 1"
#add call to FDNQ here.
perl fdnq.pl -q2 dataset1.dat

echo "Plotting correlation integral for dataset 1"
#plotting code
echo "set term pdf; set logscale x; set logscale y; set output'dataset0.pdf'; plot 'dataset1.dat.points' with linespoints" | gnuplot 

echo "Running FDNQ on dataset 2"
#add call to FDNQ here.
perl fdnq.pl -q2 dataset2.dat

echo "Plotting correlation integral for dataset 2"
#plotting code
echo "set term pdf; set logscale x; set logscale y; set output'dataset0.pdf'; plot 'dataset2.dat.points' with linespoints" | gnuplot 

echo "Running FDNQ on dataset 3"
#add call to FDNQ here.
perl fdnq.pl -q2 dataset3.dat

echo "Plotting correlation integral for dataset 3"
#plotting code
echo "set term pdf; set logscale x; set logscale y; set output'dataset0.pdf'; plot 'dataset3.dat.points' with linespoints" | gnuplot 

echo "Running FDNQ on dataset 4"
#add call to FDNQ here.
perl fdnq.pl -q2 dataset4.dat

echo "Plotting correlation integral for dataset 4"
#plotting code
echo "set term pdf; set logscale x; set logscale y; set output'dataset0.pdf'; plot 'dataset4.dat.points' with linespoints" | gnuplot 
