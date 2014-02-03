f <- read.table("svd.dat")
m <- as.matrix(f)
res <- svd(f)

u <- res$d
d <- diag(res$d)
v <- res$v

v2d <- v[,1:2]
# plot2d <- u[,1:2] %*% d[1:2,1:2]
plot2d2 <- m %*% v2d

write.table(plot2d2,file="plot2d2.res",  row.names = FALSE, col.names = FALSE)