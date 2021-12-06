%% Variable initialization
clearvars;close all;clc;

%Theo Jansen dimensions to be scaled

%Scale
sc=1;

li = 15*sc;
l1 = 50*sc;
l2 = 41.5*sc;
l3 = 55.8*sc;
l4 = 40.1*sc;
l5 = 39.4*sc;
l6 = 61.9*sc;
l7 = 39.3*sc;
l8 = 36.7*sc;

%Dimension nos considered in NR algorithm
l9 = 49*sc;

a = 7.8*sc;
b = 38*sc;

gamma=-99.10*pi/180;
%module of distance
l_sep=sqrt(a^2+b^2);
%angle
t_sep=pi-0.2025;

%Initial guess for Newton-Raphson algorithm

N=361;
x0=[0;0];   %Ground pin 0
x1=[b;-a];  %Ground pin 1
%Initial guesses for NR algorithm
t1=pi-2.46; t2=pi-1.23; t3=5.76; t4=pi-2.73; t5=4.54;...
    t6=4.89; t7=4.36; t8=pi-2.49;


%Repeated vectors
U21=zeros(2,1);

%Pre-allocation for loop optimization
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

figure(1)
for k=1:N
    ti(k) = pi/2+(k-1)*-pi/180;
    [eli,nli] = UnitVector(ti(k));
    
    %Newton Raphson Method
    for i = 1:100 %Number of iterations
        [el1,nl1] = UnitVector(t1);
        [el2,nl2] = UnitVector(t2);
        [el3,nl3] = UnitVector(t3);
        [el4,nl4] = UnitVector(t4);
        [el5,nl5] = UnitVector(t5);
        [el6,nl6] = UnitVector(t6);
        [el7,nl7] = UnitVector(t7);
        [el8,nl8] = UnitVector(t8);
        [el9,nl9] = UnitVector(t8+gamma);
        
        [el_sep,nl_sep]=UnitVector(t_sep);
        
        %Phi matrix
        phi(:,1) = [li*eli+l1*el1+l_sep*el_sep-l2*el2;
                    li*eli+l1*el1+l3*el3+l_sep*el_sep-l4*el4;
                    li*eli+l6*el6+l_sep*el_sep-l7*el7;
                    li*eli+l1*el1+l3*el3+l5*el5+l_sep*el_sep-...
                    l7*el7-l8*el8];
        %Matrix with variables
        J=[l1*nl1,-l2*nl2,zeros(2,6);
           l1*nl1,U21,l3*nl3,-l4*nl4,zeros(2,4);
           zeros(2,5),l6*nl6,-l7*nl7,U21;
           l1*nl1,U21,l3*nl3,U21,l5*nl5,U21,-l7*nl7,-l8*nl8];      
        
        % - inv(J)*phi
        dq = -J\phi;
        
        t1=t1+dq(1);
        t2=t2+dq(2);
        t3=t3+dq(3);
        t4=t4+dq(4);
        t5=t5+dq(5);
        t6=t6+dq(6);
        t7=t7+dq(7);
        t8=t8+dq(8);
        
        if norm(phi) < 0.00001
            disp(strcat('Convergence at iteration:',num2str(i)));
            break
        end  
    end
    
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
    plot3([1,1],-[x0(1) Li(1,k)],[x0(2) Li(2,k)],'Color',color)     %crank
    hold on;
    
    %Plot triangular members
    %Upper triangle
    patch([1 1 1],-[x1(1) L1(1,k) L3(1,k)],...
         [x1(2) L1(2,k) L3(2,k)],cBlu,...
         'EdgeColor',cBlu,'LineWidth',2,'FaceAlpha',0.5)
    %Lower triangle
    patch([1 1 1],-[L6(1,k) L5(1,k) L9(1,k)],...
         [L6(2,k) L5(2,k) L9(2,k)],cBlu,...
         'EdgeColor',cBlu,'LineWidth',2,'FaceAlpha',0.5)
        
    plot3([1,1],-[Li(1,k) L1(1,k)],[Li(2,k) L1(2,k)],'Color',color)  %l1
    plot3([1,1],-[x1(1) L2(1,k)],[x1(2) L2(2,k)],'Color',color)      %l2
    plot3([1,1],-[L1(1,k) L3(1,k)],[L1(2,k) L3(2,k)],'Color',color)  %l3
    plot3([1,1],-[x1(1) L4(1,k)],[x1(2) L4(2,k)],'Color',color)      %l4
    plot3([1,1],-[L4(1,k) L5(1,k)],[L4(2,k) L5(2,k)],'Color',color)  %l5
    plot3([1,1],-[Li(1,k) L6(1,k)],[Li(2,k) L6(2,k)],'Color',color)  %l6
    plot3([1,1],-[x1(1) L7(1,k)],[x1(2) L7(2,k)],'Color',color)      %l7
    plot3([1,1],-[L6(1,k) L8(1,k)],[L6(2,k) L8(2,k)],'Color',color)  %l8
    plot3([1,1],-[L6(1,k) L9(1,k)],[L6(2,k) L9(2,k)],'Color',color)  %l9
    %Member determined by other members
    plot3([1,1],-[L5(1,k) L9(1,k)],[L5(2,k) L9(2,k)],'Color',color) 
            
    %Pin names
%     text(x0(1),x0(2),'0','FontWeight','bold','Color','r')
%     text(x1(1)+2,x1(2),'1','FontWeight','bold','Color','r')
%     text(Li(1,k)+1,Li(2,k)+1,'A','FontWeight','bold','Color','r')
%     text(L1(1,k)+1,L1(2,k)+1,'B','FontWeight','bold','Color','r')
%     text(L3(1,k)-4,L3(2,k),'C','FontWeight','bold','Color','r')
%     text(L7(1,k)+1,L7(2,k),'D','FontWeight','bold','Color','r')
%     text(L5(1,k)-4,L5(2,k),'E','FontWeight','bold','Color','r')    
%     text(L9(1,k)+1,L9(2,k),'F','FontWeight','bold','Color','r')
        
    %Drawing trajectory
    p1=plot3(ones(1,361),-L9(1,:),L9(2,:),'-.r','LineWidth',1.2);
    hold off;
       
    %Plot parameters
    title('Theo Jansen Mechanism')
%     xlim([-50 50]);
%     ylim([-120 50]);
    xlabel('x');
    ylabel('y');
    grid on
    axis equal
    pause(0.01)
%     pelicula(k)=getframe(gcf);
end

% figure(2)
% plot(L9(2,:))

%Video maker
% video = VideoWriter('Jansen.avi','Uncompressed AVI');
% video.FrameRate = 60;
% open(video)
% writeVideo(video,pelicula);
% close(video)