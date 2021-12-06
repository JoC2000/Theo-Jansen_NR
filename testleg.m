clearvars;clc;close all;
%Initial guess for NR algorithm
t1=2.46; t2=1.23; t3=3.57; t4=2.73; t5=5.25; t6=3.97; t7=5; t8=2.49;

tl1=pi-2.46; tl2=pi-1.23; tl3=5.76; tl4=pi-2.73; tl5=4.54;...
    tl6=4.89; tl7=4.36; tl8=pi-2.49;

N=361;

gamma=99.10*pi/180;

sc=1;

plot_strandbeest(t1,t2,t3,t4,t5,t6,t7,t8,N,gamma,sc);