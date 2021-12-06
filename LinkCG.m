% LinkCG.m
% calculates the vectors associated with the center of mass of a
% two or three pin link.
%
% *** Inputs ***
% a = length of link from pin A to pin B
% c = length from pin A to pin C (zero if two-pin link)
% gamma = angle between AB and AC (zero if two-pin link)
% xbar = [xbar,ybar]coordinates of CM in local coordinate system
% theta = angle of link in global coordinate system
%
% *** Outputs ***
% eAg,nAg = unit vector and normal point A to CM
% LAg = length from point A to CM
% sgA = normal to vector from CM to A
% sgB = normal to vector from CM to B
% sgC = normal to vector from CM to C
function [eAg,nAg,LAg,sgA,sgB,sgC] = LinkCG(a,c,gamma,xbar,theta)
    rAB = a*[ 1; 0]; % local vector from A to B
    rAC = c*[cos(gamma); sin(gamma)]; % local vector from A to C
    rgA = [ -xbar(1); -xbar(2)]; % local vector from CM to A
    rgB = rAB + rgA; % local vector from CM to B
    rgC = rAC + rgA; % local vector from CM to C
    LAg = norm(rgA); % length from A to CM
    eAg = -(1/LAg)*rgA; % unit vector from A to CM
    nAg = [-eAg(2); eAg(1)]; % unit normal of vector from A to CM
    sgA = [-rgA(2); rgA(1)]; % local vector normal to rGA
    sgB = [-rgB(2); rgB(1)]; % local vector normal to rGB
    sgC = [-rgC(2); rgC(1)]; % local vector normal to rGC
    R = [cos(theta) -sin(theta); % rotation matrix
         sin(theta) cos(theta)];
    % transform to global coordinate system
    sgA = R*sgA; sgB = R*sgB; sgC = R*sgC;
    eAg = R*eAg; nAg = R*nAg;
end