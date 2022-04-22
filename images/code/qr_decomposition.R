
A <- matrix(
  c(
    1, 2, 3, 
    2, 4, 6, 
    3, 3, 3
  ), nrow=3)
A

QR <- qr(A)

Q <- qr.Q(QR)
Q

R <- qr.R(QR)
R

Q %*% R

Q %*% t(Q)
