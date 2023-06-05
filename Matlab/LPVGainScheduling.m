function [K1,K2,K3,K4] = LPVGainScheduling(A_f,B,vMin,vMax,wMin,wMax)
% costruzione vertici politopo
A_V1 = A_f(vMax,wMax);
A_V2 = A_f(vMax,wMin);
A_V3 = A_f(vMin,wMin);
A_V4 = A_f(vMin,wMax);
% incognite problema
X    = sdpvar(3,3);
W1   = sdpvar(2,3);
W2   = sdpvar(2,3);
W3   = sdpvar(2,3);
W4   = sdpvar(2,3);
% LMIs
F1  = ([(A_V1*X+B*W1)+(A_V1*X+B*W1)']<=0);
F2  = ([(A_V1*X+B*W2)+(A_V1*X+B*W2)']<=0);
F3  = ([(A_V1*X+B*W3)+(A_V1*X+B*W3)']<=0);
F4  = ([(A_V1*X+B*W4)+(A_V1*X+B*W4)']<=0);

F5  = ([(A_V2*X+B*W1)+(A_V2*X+B*W1)']<=0);
F6  = ([(A_V2*X+B*W2)+(A_V2*X+B*W2)']<=0);
F7  = ([(A_V2*X+B*W3)+(A_V2*X+B*W3)']<=0);
F8  = ([(A_V2*X+B*W4)+(A_V2*X+B*W4)']<=0);

F9  = ([(A_V3*X+B*W1)+(A_V3*X+B*W1)']<=0);
F10 = ([(A_V3*X+B*W2)+(A_V3*X+B*W2)']<=0);
F11 = ([(A_V3*X+B*W3)+(A_V3*X+B*W3)']<=0);
F12 = ([(A_V3*X+B*W4)+(A_V3*X+B*W4)']<=0);

F13 = ([(A_V4*X+B*W1)+(A_V4*X+B*W1)']<=0);
F14 = ([(A_V4*X+B*W2)+(A_V4*X+B*W2)']<=0);
F15 = ([(A_V4*X+B*W3)+(A_V4*X+B*W3)']<=0);
F16 = ([(A_V4*X+B*W4)+(A_V4*X+B*W4)']<=0);

F17 = ([X]>= 0);
% risoluzione LMIs
F   = F1+F2+F3+F4+F5+F6+F7+F8+F9+F10+F11+F12+F13+F14+F15+F16+F17;
ops = sdpsettings('solver','sedumi');
solvesdp(F,[],ops);

% guadagni
X   = double(X);
W1  = double(W1);
W2  = double(W2);
W3  = double(W3);
W4  = double(W4);
K1  = W1 / X;
K2  = W2 / X;
K3  = W3 / X;
K4  = W4 / X;