%% Assignment 2, Part 2 (EEG signal analysis)
%  Do not change before line 35
%  You will need to have generated A2P2Data.mat from 
%  GenerateAssignment2Data.m before working with this file.

%  Clearing and preparing the workspace
clear; clc; close all;

%  Load assignment data from A2P1Data.mat.
load('A2P2Data.mat');  

%==================================================================
%
% Refer to the assignment sheet for details.
% Names of the variables are important,
% e.g. 'a1' is considered a different variable to 'A1'.
% Make sure variables have been declared as they appear in the brief.
%
% Ts - sampling period
% t - time domain vector
% MUX - Fourier Transform
% k - frequency vector
% fshift - frequency shifts
% Ashift - magnitude shifts
% Phishift - phase shifts
% xdm - EEG data
% XDM - Fourier Transform
% freqResponse - frequency response of systems
% imp - impulse response of chosen system
% EEG - filtered signals
% eeg - time domain of filtered signals
% eqConv - convolution
%
%====Enter your code below this line================================
%% 2.1
% create time vector
Ts = 1/fs; 
t = linspace(0, Ts*length(muxSignal), length(muxSignal)+1);
t = t(1 : end-1);
% plot muxSignall against time vector
figure(1)
plot(t,muxSignal);
title('plot muxSignal');
xlabel('time vector '); ylabel('amplitude');
% create frequency vector
k = linspace(-fs/2,fs/2,length(muxSignal)+1);
k = k(1 : end-1);
% discrete Fourier tansform 
MUX = fft(muxSignal);
MUX_fftshifted = fftshift(MUX/fs);
% plot the magnitude spectrum of MUX
figure(2)
plot(k,abs(MUX_fftshifted));
title('magnitude spectrum of MUX');
xlabel('frequency vector'); ylabel('magnitude');
%% 2.2
MUX_positive = MUX_fftshifted(k>=0);
positive_k = k(k>=0);
% find of MUX_positive sorting from high to low
positive_peaks= findpeaks(abs(MUX_positive),'SortStr','descend');
% put the value in to positive_peaks from high to low
positive_peaks= positive_peaks(1:5);
% create a empty array fshift to store frequency k location.
fshift = zeros(1,5);
for n =1:5
    %if find the magnitude of signal = peak value return location 
    location = find(abs(MUX_positive)==positive_peaks(n));
    % find freqency k location put in fshift array
    fshift(n)=positive_k(location);
end
% sort vector frequency shift from low to high
 fshift = [fshift(3),fshift(2),fshift(4),fshift(5),fshift(1)];
% find peak amplitude value
Ashift = positive_peaks(1:5);
% sort the amplitude from low to high
Ashift = [Ashift(3),Ashift(2),Ashift(4),Ashift(5),Ashift(1)];
% create a phases of peaks vectors
Phishift = zeros(1,5);
% put value in the phases of peak value
for m = 1:5
    Phishift(m)= angle(MUX_positive(fshift(m)));
end
%% 2.3 
[xdm] = FDMDemux(muxSignal',t,Ashift,fshift,Phishift);
% xdm is a matrix find the value of each row store in xdm_1 ot xdm_5
xdm_1 = xdm(1,:);
xdm_2 = xdm(2,:);
xdm_3 = xdm(3,:);
xdm_4 = xdm(4,:);
xdm_5 = xdm(5,:);
%% 2.4
% calculate the fourier transform of each row
XDM_1 = fft(xdm_1);
XDM_2 = fft(xdm_2);
XDM_3 = fft(xdm_3);
XDM_4 = fft(xdm_4);
XDM_5 = fft(xdm_5);
% calculate the shift fourier tansform based on frequecy fs
XDM1_shifted=fftshift(XDM_1/fs);
XDM2_shifted=fftshift(XDM_2/fs);
XDM3_shifted=fftshift(XDM_3/fs);
XDM4_shifted=fftshift(XDM_4/fs);
XDM5_shifted=fftshift(XDM_5/fs);
% store the result in a marix called XDM
XDM = [XDM1_shifted;XDM2_shifted;XDM3_shifted;XDM4_shifted;XDM5_shifted];
% plot the magnitude spectrum for each data stream
figure(3);
subplot(2,3,1);
plot(k,abs(XDM1_shifted));       
xlabel('Frequency'); ylabel('Magnitude');
title('Magntiude spectrum of XDM1');
subplot(2,3,2);
plot(k,abs(XDM2_shifted));        
xlabel('Frequency'); ylabel('Magnitude');
title('Magntiude spectrum of XDM2');
subplot(2,3,3);
plot(k,abs(XDM3_shifted));      
xlabel('Frequency'); ylabel('Magnitude');
title('Magntiude spectrum of XDM3'); 
subplot(2,3,4);
plot(k,abs(XDM4_shifted));       
xlabel('Frequency'); ylabel('Magnitude');
title('Magntiude spectrum of XDM4');
subplot(2,3,5);
plot(k,abs(XDM5_shifted));         
xlabel('Frequency'); ylabel('Magnitude');
title('Magntiude spectrum of XDM5');
%% 2.4 2.5 display the ppart name and parameters for 5 system 
% and the transfer function in MATLAB
sysInfo(1,:)
factorTF(sys(1))
sysInfo(2,:)
factorTF(sys(2))
sysInfo(3,:)
factorTF(sys(3))
sysInfo(4,:)
factorTF(sys(4))
sysInfo(5,:)
factorTF(sys(5))
%% 2.6  extract the data and plot impulse response of each five systems
system1 = sys(:,1);
system2 = sys(:,2);
system3 = sys(:,3);
system4 = sys(:,4);
system5 = sys(:,5);
figure(4);
subplot(2,3,1);
impulse(system1);
xlabel('time');ylabel('magnitude');
title('impulse response of system one');
subplot(2,3,2);
impulse(system2);
xlabel('time');ylabel('magnitude');
title('impulse response of system two');
subplot(2,3,3);
impulse(system3);
xlabel('time');ylabel('magnitude');
title('impulse response of system three');
subplot(2,3,4);
impulse(system4);
xlabel('time');ylabel('magnitude');
title('impulse response of system four');
subplot(2,3,5);
impulse(system5);
xlabel('time');ylabel('magnitude');
title('impulse response of system five');
%%2.7 
% calculate the frequecy response fro each of the five system substituting
% the s in the transfer fucntions with j2pif
frequency_response1=((1j*2*pi*k).^2)./((1j*2*pi*k + 404.6578 + 1j*404.6578).*(1j*2*pi*k + 404.6578 - 1j*404.6578));
frequency_response2=227427.6629./((1j*2*pi*k + 337.2148 + 1j*337.2148).*(1j*2*pi*k + 337.2148 - 1j*337.2148));
frequency_response3=(12333.8928.*(1j*2*pi*k))./((1j*2*pi*k + 628.3185 + 1j*4486.3923).*(1j*2*pi*k + 628.3185 - 1j*4486.3923));
frequency_response4=65790566.5105./((1j*2*pi*k + 8111.1384 + 1j*0.00012147).*(1j*2*pi*k + 8111.1384 - 1j*0.00012147));
frequency_response5=(18120.7064.*(1j*2*pi*k))./((1j*2*pi*k - 2265.0883 - 1j*3923.248).*(1j*2*pi*k - 2265.0883 + 1j*3923.248)); 
% store them in as rows in the variable freqResponse
freqResponse = [frequency_response1;frequency_response2;frequency_response3;frequency_response4;frequency_response5];
% plot the magenitude and phase response for each of the five systems
figure(5);
subplot(5,2,1);
plot(k,abs(frequency_response1));
xlabel('frequency');ylabel('magnitude');
title('magnintude of frequency response1');
subplot(5,2,2);
plot(k,angle(frequency_response1));
xlabel('frequency');ylabel('phase');
title('phase of frequency response1');
subplot(5,2,3);
plot(k,abs(frequency_response2));
xlabel('frequency');ylabel('magnitude');
title('magnintude of frequency response2');
subplot(5,2,4);
plot(k,angle(frequency_response2));
xlabel('frequency');ylabel('phase');
title('phase of frequency response2');
subplot(5,2,5);
plot(k,abs(frequency_response3));
xlabel('frequency');ylabel('magnitude');
title('magnintude of frequency response3');
subplot(5,2,6);
plot(k,angle(frequency_response3));
xlabel('frequency');ylabel('phase');
title('phase of frequency response3');
subplot(5,2,7);
plot(k,abs(frequency_response4));
xlabel('frequency');ylabel('magnitude');
title('magnintude of frequency response4');
subplot(5,2,8);
plot(k,angle(frequency_response4));
xlabel('frequency');ylabel('phase');
title('phase of frequency response4');
subplot(5,2,9);
plot(k,abs(frequency_response5));
xlabel('frequency');ylabel('magnitude');
title('magnintude of frequency response5');
subplot(5,2,10);
plot(k,angle(frequency_response5));
xlabel('frequency');ylabel('phase');
title('phase of frequency response5');
%% 2.9
% inverse Fourier tansfrom of system 2
ifftshiftfrequency = ifftshift(frequency_response2);
ifftfrequency =ifft(ifftshiftfrequency);
imp = real(ifftfrequency);
figure(6)
plot(imp)
%% 2.10
% multiply the frequency response of the system by each data stream
% in XDM
EEG1 = XDM_1 .* frequency_response2;     
EEG2 = XDM_2 .* frequency_response2;    
EEG3 = XDM_3 .* frequency_response2;    
EEG4 = XDM_4 .* frequency_response2;    
EEG5 = XDM_5 .* frequency_response2;   
% store the result in matix EEG
EEG = [EEG1;EEG2;EEG3;EEG4;EEG5];
% convert back to time demain 
% convert for fft shift(1-5)
ifftshifteeg1=ifftshift(EEG1);
ifftshifteeg2=ifftshift(EEG2);
ifftshifteeg3=ifftshift(EEG3);
ifftshifteeg4=ifftshift(EEG4);
ifftshifteeg5=ifftshift(EEG5);
% convert for fft (1-5)
iffteeg1=ifft(ifftshifteeg1);
iffteeg2=ifft(ifftshifteeg2);
iffteeg3=ifft(ifftshifteeg3);
iffteeg4=ifft(ifftshifteeg4);
iffteeg5=ifft(ifftshifteeg5);
% only pick up the real number
eeg1 =real(iffteeg1);      
eeg2 =real(iffteeg2);      
eeg3 =real(iffteeg3);     
eeg4 =real(iffteeg4);       
eeg5 =real(iffteeg5); 

% put the result in matrix eeg
eeg = [eeg1;eeg2;eeg3;eeg4;eeg5];
% plot the 1-5 signal frequency demain and time demain
figure(7);
subplot(2,1,1);
plot(k,abs(EEG1));
xlabel('frequency');
ylabel('magnitude');
title('EEG signal 1 in frequency demain');
subplot(2,1,2);
plot(t,eeg1);
xlabel('time');
ylabel('amplitude');
title('egg signal 1 in time demain');
figure(8)
subplot(2,1,1);
plot(k,abs(EEG2));
xlabel('frequency');
ylabel('magnitude');
title('EEG signal 2 in frequency demain');
subplot(2,1,2);
plot(t,eeg2);
xlabel('time');
ylabel('amplitude');
title('egg signal 2 in time demain');
figure(9)
subplot(2,1,1);
plot(k,abs(EEG3));
xlabel('frequency');
ylabel('magnitude');
title('EEG signal 3 in frequency demain');
subplot(2,1,2);
plot(t,eeg3);
xlabel('time');
ylabel('amplitude');
title('egg signal 3 in time demain');
figure(10)
subplot(2,1,1);
plot(k,abs(EEG4));
xlabel('frequency');
ylabel('magnitude');
title('EEG signal 4 in frequency demain');
subplot(2,1,2);
plot(t,eeg4);
xlabel('time');
ylabel('amplitude');
title('egg signal 4 in time demain');
figure(11)
subplot(2,1,1);
plot(k,abs(EEG5));
xlabel('frequency');
ylabel('magnitude');
title('EEG signal 5 in frequecy demain');
subplot(2,1,2);
plot(t,eeg5);
xlabel('time');
ylabel('amplitude');
title('egg signal 5 in time demain');
%% 2.11 convolution 
x = linspace(0,1,length(xdm(1,:))+length(imp));
x = x(1:end-1);
eqConv = conv(xdm(1,:),imp);
figure(12)
plot(x,eqConv)
xlabel('time');
ylabel('magnitude');
title('plot the convolution')

















