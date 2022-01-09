%% Assignment 1 Part A - Question 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$%
%  Do not change before line 28.
%  If you have not generated Data1A from GenerateDataAssignment1A.m,
%  do that now.

%  Clearing and preparing the workspace
clear; clc; close all;

%  Load assignment data.
load Data1A;  

% VARIABLES:
% t - Time vector
% T - Period
% additive noise - Your noise waveform
% a0, an, bn - Trig Fourier series variables
% OR
% c0, cn - Complex Fourier series variables
% FS1 - Fourier series approximation
% dnSnd - De-noised resulting wave

%==================================================================
% Refer to the assignment sheet for details on variable naming.
% Names of the variables are important,
% e.g. 'a1' is considered a different variable to 'A1'.
%====Enter your code below this line================================

%% 3.2
%setting up the function for 1 loop
T=5;
samples=44100*5;
t=linspace(0,T, samples+1);
t=t(1:end-1);
x = 3+4*t-t.^(2);
%looping the function up to 20 seconds
min = 0;
max = 20;
x = repmat(x, 1,max/T);
t = linspace(min,max,length(x));

%set the x value to additive_noise
additive_noise = x;

%% 3.3
%finding a0, an, bn
syms t f n Tp

f=3+4*t-t.^(2);

a0 = 1/Tp*(int(f,t,0,Tp));
a0 = simplify(a0);

an(n) = 2/Tp*(int(f*cos(2*n*pi*t/Tp),t,0,Tp));
an = simplify(an);

bn(n) = 2/Tp*(int(f*sin(2*n*pi*t/Tp),t,0,Tp));
bn = simplify(bn);


%% 3.4
%Setting up the variables
N = 5;
a = sym(zeros(N,length(t)));

%looping through the harmonics
for i =1:length(t)
    for n = 1:N
        a(n:N,i) = a(n:N,i)+an(n)*cos(2*pi*n*t(i)/Tp) + bn(n)*sin(2*pi*n*t(i)/Tp);
    end
end
%adding a0
a = a+a0;

%taking the 10th harmonic Fourier series approximation
FS1 = a(5, :);

%Setting the t and Tp values for the evulation process
T=5;
min = 0;
max = 20;
samples=44100*T;
t = linspace(min,max,samples*(max-min)/T);
Tp=5;

%evaulting the 10th harmonic Fourier series approximation
FS1 = eval(FS1);

%% 3.5
%removing the additive noise
dnSnd = noiseSound-FS1.';

%% 3.6
%graphing and listening to the recovered sound
%sound(dnSnd,44100)
figure(1)
plot(t, noiseSound)
title('Graph of the Noise Sound')
xlabel('time(s)')
ylabel('Amplitude')
figure(2)
plot(t, dnSnd)
title('Recovered graph from noise sound')
xlabel('time(s)')
ylabel('Amplitude')