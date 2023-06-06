%% Main Program For LPV Controller DD Robot
clear all
close all
clc
% Definizione Modello Cinematico
A_f = @(v,w)[0 w 0;-w 0 v;0 0 0];
B   = [1 0;0 0;0 1];
% Definizione Limiti Velocità
vMin =     1;
vMax =     5;
wMin =    -5;
wMax =     5;
T_s  =   0.1;
x0   = [-30;0;0];
% Ottenimento Guadagni Controllo
[K1,K2,K3,K4] = LPVGainScheduling(A_f,B,vMin,vMax,wMin,wMax);