n=4;l=3;m=2;N=100;
[A,B,C,D]=drmodel(n,l,m);
u=randn(N,m);
y=dlsim(A,B,C,D,u);


[S,R]=dordom(u,y,2*n);
[S,R2]=dordom(u,y,2*n,R);
S
