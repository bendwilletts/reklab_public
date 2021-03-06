 function [A,C]  =  cestac(R,n) 
 % cestac    Estimates the matrices A and C of a LTI state 
%           space model using the result of the preprocessor 
%           routines cordxx (cordom, cordpo, etc.). 
%           General model structure: 
%                  . 
%                  x(t) = Ax(t) + Bu(t) + w(t) 
%                  y(t) = Cx(t) + Du(t) v(t) 
%          For more information about the disturbance properties see 
%          the help pages for the preprocessor cordxx functions. 
% 
% Syntax: 
%      [A,C]=cestac(R,n); 
% 
% Input: 
%  R       Data structure obtained from cordxx, containing the 
%          triangular factor and additional information 
%          (such as i/o dimension etc.). 
%  n       Order of system to be estimated. 
% 
% Output: 
%  A,C     Estimated system matrices. 
% 
% See also: cordom, cordpi, cordpo, cestbd 
 
%  --- This file is generated from the MWEB source cmoesp.web --- 
% 
% Bert Haverkamp, 16-10-1997 
% Copyright(c) 1997 Bert Haverkamp 
 
 
 if nargin==0 
  help cestac 
  return 
end 
 if ~isempty(R) 
  if ~isstruct(R) 
    error('R should be a stucture, generated by cordxx.') 
  end 
  if isfield(R,'m') 
    m = R.m; 
    if (m<0) 
      error('Illegal value for number of inputs in R.m') 
    end 
  else 
    error('The field R.m does not exist.') 
  end 
  if isfield(R,'l') 
    l = R.l; 
    if (l<0) 
      error('Illegal value for number of outputs in R.l') 
    end 
  else 
    error('The field R.l does not exist.') 
  end 
  if isfield(R,'i') 
    i = R.i; 
    if (i<3) 
      error('Illegal value for the block matrix parameter in R.i') 
    end 
  else 
    error('The field R.i does not exist.') 
  end 
  if isfield(R,'a') 
    a = R.a; 
    if (a==0) 
      error('Illegal value for the filter parameter R.a') 
    end 
  else 
    error('The field R.a does not exist.') 
  end 
  if isfield(R,'n') 
    n = R.n; 
    if (n>i * l) 
      error(['The order is too large. It should be smaller than ' ... 
      'R.i times R.l.']) 
    else 
      error('The field R.n does not exist.') 
    end 
  end 
  if isfield(R,'Un') 
    Un = R.Un; 
    il  =  i * l; 
    if ~(all(size(Un)==[il,il])) 
      error('The field R.Un has wrong size.') 
    end 
  else 
      error('The field R.Un does not exist.') 
    end 
  end 
 
 
 if (n>i * l) 
  error(['The order is too large. It should be smaller than i times #outputs.l']) 
end 
 
 
 
 
 
 % find A and C 
Aw  =  Un(1:il-l,1:n)\ Un(l+1:il,1:n); 
Cw  =  Un(1:l,1:n); 
I = eye(n); 
A = a * (I+Aw) * inv(I-Aw); 
C = Cw * inv(I-Aw); 
  
 

