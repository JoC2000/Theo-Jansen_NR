%% Newton Raphson Algorithm
 
function[t1,t2,t3,t4,t5,t6,t7,t8,eli,el1,el2,el3,el4,el5,el6,el7,el8,el9] = Jansen_NR(t1,t2,t3,t4,t5,t6,t7,t8,gamma,t_sep,k,sc,phase,dir)

%Inputs
%[t1,t2,t3,t4,t5,t6,t7,t8] -> Initial guess values
%gamma -> constant angle,k -> iteration value for main loop
%sc -> scale value,phase -> phase for crank's starting angle

%Outputs
%[t1,t2,t3,t4,t5,t6,t7,t8] -> Values obtained by NR algorithm for angles
%[eli,el1,el2,el3,el4,el5,el6,el7,el8,el9] -> Values obtained for v.modules

%Members lenght to be scaled
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
%l9 = 49*sc;

%Distance
a = 7.8*sc;
b = 38*sc;

%module of distance
l_sep=sqrt(a^2+b^2);

%Repeated vector
U21=zeros(2,1);

%Crank angle
ti(k) = dir*(phase+(k-1)*pi/180);
[eli,~] = UnitVector(ti(k));

 for i = 1:10 %Number of iterations    
     [el1,nl1] = UnitVector(t1);
     [el2,nl2] = UnitVector(t2);
     [el3,nl3] = UnitVector(t3);
     [el4,nl4] = UnitVector(t4);
     [el5,nl5] = UnitVector(t5);
     [el6,nl6] = UnitVector(t6);
     [el7,nl7] = UnitVector(t7);
     [el8,nl8] = UnitVector(t8);
     [el9,~] = UnitVector(t8+gamma);
        
     [el_sep,~]=UnitVector(t_sep);
        
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
        
%      if norm(phi) < 0.00001
%          disp(strcat('Convergence at iteration:',num2str(i)));
%          break
%      end
 end 
end
