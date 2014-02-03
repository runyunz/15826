echo "f <- read.table("svd.dat"); res <- svd(f); u <- res$d; d <- diag(res$d); v <- res$v; v2d <- v[,1:2]; plot2d <- u[,1:2] %*% d[1:2,1:2]; write.table(plot2d,file="plot2d.res",  row.names = FALSE, col.names = FALSE)" | R
echo "set term png; set output'plot2d.png'; plot 'plot2d.res'" | gnuplot 