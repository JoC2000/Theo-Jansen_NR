function plot_strandbeest(t1,t2,t3,t4,t5,t6,t7,t8,eli,el1,el2,el3,el4,el5,el6,el7,el8,el9,k,N,sc,z,side_leg)

%Member lenghts to be scaled
li = 15*sc;
l1 = 50*sc;
l2 = 41.5*sc;
l3 = 55.8*sc;
l4 = 40.1*sc;
l5 = 39.4*sc;
l6 = 61.9*sc;
l7 = 39.3*sc;
l8 = 36.7*sc;

%Dimension not considered in NR algorithm
l9 = 49*sc;

%Distances
a = 7.8*sc;
b = 38*sc;

x0=[0;0];   %Ground pin 0

if side_leg == "front"
    x1=[-b;-a]; %Ground pin 1
elseif side_leg == "back"
    x1=[b;-a];  %Ground pin 1
else
    error('Wrong input size')
end

%Storage for variable angles
[theta1,theta2,theta3,theta4,theta5,theta6,theta7,theta8]=deal...
    (zeros(1,N));

theta1(k)=t1;
theta2(k)=t2;
theta3(k)=t3;
theta4(k)=t4;
theta5(k)=t5;
theta6(k)=t6;
theta7(k)=t7;
theta8(k)=t8;
    
%Simulation
%Set linewidth for plot
set(groot,'defaultLineLineWidth',3.5)
%Color definition
color = [0.1922    0.2196    0.5686];
cBlu = [0.4000    0.6588    0.8682]; % Pantone 300C
    
%Positions for each point
Li(:,k)=FindPos(x0,li,eli);
L1(:,k)=FindPos(Li(:,k),l1,el1);
L2(:,k)=FindPos(x1,l2,el2);
L3(:,k)=FindPos(L1(:,k),l3,el3);
L4(:,k)=FindPos(x1,l4,el4);
L5(:,k)=FindPos(L4(:,k),l5,el5);
L6(:,k)=FindPos(Li(:,k),l6,el6);
L7(:,k)=FindPos(x1,l7,el7);
L8(:,k)=FindPos(L6(:,k),l8,el8);
L9(:,k)=FindPos(L6(:,k),l9,el9);
    
%Draw the lines
plot3([z,z],-[x0(1) Li(1,k)],[x0(2) Li(2,k)],'Color',color)     %crank
hold on;
    
%Plot triangular members
%Upper triangle
patch([z z z],-[x1(1) L1(1,k) L3(1,k)],...
      [x1(2) L1(2,k) L3(2,k)],cBlu,...
      'EdgeColor',cBlu,'LineWidth',2,'FaceAlpha',0.5)
%Lower triangle
patch([z z z],-[L6(1,k) L5(1,k) L9(1,k)],...
     [L6(2,k) L5(2,k) L9(2,k)],cBlu,...
     'EdgeColor',cBlu,'LineWidth',2,'FaceAlpha',0.5)
        
plot3([z,z],-[Li(1,k) L1(1,k)],[Li(2,k) L1(2,k)],'Color',color)  %l1
plot3([z,z],-[x1(1) L2(1,k)],[x1(2) L2(2,k)],'Color',color)      %l2
plot3([z,z],-[L1(1,k) L3(1,k)],[L1(2,k) L3(2,k)],'Color',color)  %l3
plot3([z,z],-[x1(1) L4(1,k)],[x1(2) L4(2,k)],'Color',color)      %l4
plot3([z,z],-[L4(1,k) L5(1,k)],[L4(2,k) L5(2,k)],'Color',color)  %l5
plot3([z,z],-[Li(1,k) L6(1,k)],[Li(2,k) L6(2,k)],'Color',color)  %l6
plot3([z,z],-[x1(1) L7(1,k)],[x1(2) L7(2,k)],'Color',color)      %l7
plot3([z,z],-[L6(1,k) L8(1,k)],[L6(2,k) L8(2,k)],'Color',color)  %l8
plot3([z,z],-[L6(1,k) L9(1,k)],[L6(2,k) L9(2,k)],'Color',color)  %l9
%Member determined by other members
plot3([z,z],-[L5(1,k) L9(1,k)],[L5(2,k) L9(2,k)],'Color',color) 
       
%Drawing trajectory
%plot3(ones(1,361),-L9(1,:),L9(2,:),'-.r','LineWidth',1.2);
% hold off
       
%Plot parameters
title('Theo Jansen Mechanism')
xlabel('x');
ylabel('y');
grid on
axis equal
% pause(0.01)
end
