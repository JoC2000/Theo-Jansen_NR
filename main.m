%% 4 legged strandbeest using NR algorithm

% Author: José Canales Avellaneda
% Date: 08/12/2021
%%
clc;clearvars;close all;

%Initial guess for NR algorithm for every leg
t1_1=2.46; t2_1=1.23; t3_1=3.57; t4_1=2.73; t5_1=5.25; t6_1=3.97; t7_1=5; t8_1=2.49;
t1_2=2.46; t2_2=1.23; t3_2=3.57; t4_2=2.73; t5_2=5.25; t6_2=3.97; t7_2=5; t8_2=2.49;
t1_3=pi-2.46; t2_3=pi-1.23; t3_3=5.76; t4_3=pi-2.73; t5_3=4.54; t6_3=4.89; t7_3=4.36; t8_3=pi-2.49;
t1_4=pi-2.46; t2_4=pi-1.23; t3_4=5.76; t4_4=pi-2.73; t5_4=4.54; t6_4=4.89; t7_4=4.36; t8_4=pi-2.49;
%Number of samples
N=361;

%Scale value for the Theo Jansen mechanism
sc=1;

%Constant angle in lower triangle member
gamma_r=99.10*pi/180;
gamma_l=-gamma_r;

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

t_sep_r=0.2025;
t_sep_l=pi-0.2025;

z_1=1;
z_2=30;

side_leg_f="front";
side_leg_b="back";

dir_forward=1;
dir_backwards=-1;

for k=1:N
[t1_1,t2_1,t3_1,t4_1,t5_1,t6_1,t7_1,t8_1,eli_1,el1_1,el2_1,el3_1,el4_1,el5_1,el6_1,el7_1,el8_1,el9_1] = ...
    Jansen_NR(t1_1,t2_1,t3_1,t4_1,t5_1,t6_1,t7_1,t8_1,gamma_r,t_sep_r,k,sc,phase_1,dir_forward);

[t1_2,t2_2,t3_2,t4_2,t5_2,t6_2,t7_2,t8_2,eli_2,el1_2,el2_2,el3_2,el4_2,el5_2,el6_2,el7_2,el8_2,el9_2] = ...
    Jansen_NR(t1_2,t2_2,t3_2,t4_2,t5_2,t6_2,t7_2,t8_2,gamma_r,t_sep_r,k,sc,phase_2,dir_forward);

[t1_3,t2_3,t3_3,t4_3,t5_3,t6_3,t7_3,t8_3,eli_3,el1_3,el2_3,el3_3,el4_3,el5_3,el6_3,el7_3,el8_3,el9_3] = ...
    Jansen_NR(t1_3,t2_3,t3_3,t4_3,t5_3,t6_3,t7_3,t8_3,gamma_l,t_sep_l,k,sc,phase_1,dir_forward);

[t1_4,t2_4,t3_4,t4_4,t5_4,t6_4,t7_4,t8_4,eli_4,el1_4,el2_4,el3_4,el4_4,el5_4,el6_4,el7_4,el8_4,el9_4] = ...
    Jansen_NR(t1_4,t2_4,t3_4,t4_4,t5_4,t6_4,t7_4,t8_4,gamma_l,t_sep_l,k,sc,phase_2,dir_forward);

plot_strandbeest(t1_1,t2_1,t3_1,t4_1,t5_1,t6_1,t7_1,t8_1,eli_1,el1_1,el2_1,el3_1,el4_1,el5_1,...
    el6_1,el7_1,el8_1,el9_1,k,N,sc,z_1,side_leg_f);
hold on
plot_strandbeest(t1_2,t2_2,t3_2,t4_2,t5_2,t6_2,t7_2,t8_2,eli_2,el1_2,el2_2,el3_2,el4_2,el5_2,...
    el6_2,el7_2,el8_2,el9_2,k,N,sc,z_2,side_leg_f);
plot_strandbeest(t1_3,t2_3,t3_3,t4_3,t5_3,t6_3,t7_3,t8_3,eli_3,el1_3,el2_3,el3_3,el4_3,el5_3,...
    el6_3,el7_3,el8_3,el9_3,k,N,sc,z_1,side_leg_b);
plot_strandbeest(t1_4,t2_4,t3_4,t4_4,t5_4,t6_4,t7_4,t8_4,eli_4,el1_4,el2_4,el3_4,el4_4,el5_4,...
    el6_4,el7_4,el8_4,el9_4,k,N,sc,z_2,side_leg_b);
hold off
mov(k)=getframe(gcf);
pause(0.01)
end

%Video maker
video = VideoWriter('Jansen_TEST.avi','Uncompressed AVI');
video.FrameRate = 60;
open(video)
writeVideo(video,mov);
close(video)
