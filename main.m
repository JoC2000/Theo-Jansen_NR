%% 4 legged strandbeest using NR algorithm

% Author: José Canales Avellaneda
% Date: 08/12/2021
%%
clc;clearvars;close all;

%Initial guess for NR algorithm
t1_1=2.46; t2_1=1.23; t3_1=3.57; t4_1=2.73; t5_1=5.25; t6_1=3.97; t7_1=5; t8_1=2.49;
t1_2=2.46; t2_2=1.23; t3_2=3.57; t4_2=2.73; t5_2=5.25; t6_2=3.97; t7_2=5; t8_2=2.49;

%Number of samples
N=361;

%Scale value for the Theo Jansen mechanism
sc=1;

%Constant angle in lower triangle member
gamma=99.10*pi/180;

%Distances between fixed points
a = 7.8*sc;
b = 38*sc;

x0=[0;0];   %Ground pin 0
x1=[-b;-a]; %Ground pin 1

%Pre-allocation
%Crank angle
ti=zeros(1,N);
%Storage for variable angles
[theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8]=deal...
    (zeros(1,N));
%Plot vectors
Li = NaN(2,N);
L1 = NaN(2,N);
L2 = NaN(2,N);
L3 = NaN(2,N);
L4 = NaN(2,N);
L5 = NaN(2,N);
L6 = NaN(2,N);
L7 = NaN(2,N);
L8 = NaN(2,N);
L9 = NaN(2,N);

phase_1=pi/2;
phase_2=-pi/2;

z_1=1;
z_2=30;
for k=1:N
[t1_1,t2_1,t3_1,t4_1,t5_1,t6_1,t7_1,t8_1,eli_1,el1_1,el2_1,el3_1,el4_1,el5_1,el6_1,el7_1,el8_1,el9_1] = ...
    Jansen_NR(t1_1,t2_1,t3_1,t4_1,t5_1,t6_1,t7_1,t8_1,gamma,k,sc,phase_1);

[t1_2,t2_2,t3_2,t4_2,t5_2,t6_2,t7_2,t8_2,eli_2,el1_2,el2_2,el3_2,el4_2,el5_2,el6_2,el7_2,el8_2,el9_2] = ...
    Jansen_NR(t1_2,t2_2,t3_2,t4_2,t5_2,t6_2,t7_2,t8_2,gamma,k,sc,phase_2);

plot_strandbeest(t1_1,t2_1,t3_1,t4_1,t5_1,t6_1,t7_1,t8_1,eli_1,el1_1,el2_1,el3_1,el4_1,el5_1,...
    el6_1,el7_1,el8_1,el9_1,k,N,sc,z_1);
hold on
plot_strandbeest(t1_2,t2_2,t3_2,t4_2,t5_2,t6_2,t7_2,t8_2,eli_2,el1_2,el2_2,el3_2,el4_2,el5_2,...
    el6_2,el7_2,el8_2,el9_2,k,N,sc,z_2);
% mov(k)=getframe(gcf);
end
%Video maker
% video = VideoWriter('Jansen_TEST.avi','Uncompressed AVI');
% video.FrameRate = 60;
% open(video)
% writeVideo(video,mov);
% close(video)
