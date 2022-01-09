%% Assignment 2, Part 3 (Choosing a landing site)
%  Do not change before line 32
%  You will need to have generated A2P3Data.mat from 
%  GenerateAssignment2Data.m before working with this file.

%  Clearing and preparing the workspace
clear; clc; close all;

%  Load assignment data from A2P3Data.mat.
load('A2P3Data.mat');  

%==================================================================
%
% Refer to the assignment sheet for details.
% Names of the variables are important,
% e.g. 'a1' is considered a different variable to 'A1'.
% Make sure variables have been declared as they appear in the brief.
%
% t - time domain vector
% k - frequency vector
% SIG - Fourier Transform
% T - selected value
% sigNoise - estimated noise signal
% a0,an,bn - Trigonometric Fourier Series Coefficients
% OR
% c0,cn - Complex Fourier Series Coefficients
% sigNoise_fs - approximation of noise
% im1 - image 1
% im2 - image 2
% 
%====Enter your code below this line================================

%% Part 3.1

%Displaying the image
figure(1)
imshow(reshape(sig(1,:), 480,640));
title('First Signal Noisy Image')

%% Part 3.2
%Setting the sampling frequency and working out the time period of samples
%As well as the length of the signal for the time and frequency vectors
fs = 1000;
Ts = 1/fs;
Ls = length(sig);

%Creating the time vector
t = (0:Ts:Ls*Ts);
t = t(1:end-1);

%Creating the frequency vector
k = linspace(-fs/2, fs/2,Ls+1);
k = k(1:end-1);

%% Part 3.3
%Plotting the signal in the time domain for the first 3 seconds
figure(2)
plot(t,sig(1,:))
xlim([0 3]);
title('Magnitude of sig 1 in time domain')
xlabel('Time (sec)')
ylabel('Magnitude')

%Plotting the signal in the frequency domain
SIG = fft(sig(1,:));
figure(3)
plot(k,fftshift(abs(SIG)))
title('Magnitude of sig 1 in frequency domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

%Period of the noise is is around 0.360
%band limiting is around 243.5 to 259.5 in positive and negative

%Setting the T variable to what the approximate period of the noise
T = candidateT(2);

%% Part 3.4

%Getting the estimated noise for a single period
sigNoiseSinglePeriod = estimateNoise(sig(1,:), T);

%Adjusting to create the estimated noise for the length of the actual
%signal
numberOfCopies = ceil(length(sig)/length(sigNoiseSinglePeriod));
sigNoise = repmat(sigNoiseSinglePeriod,numberOfCopies, 1);
sigNoise = sigNoise(1:length(sig));

%Plotting the first signal and the estimated noise in the time domain for
%the first 3 seconds of the signals
figure(4)
subplot(2,1,1)
plot(t,sig(1,:))
xlim([0 3]);
title('Magnitude of sig 1 in the time domain')
xlabel('Time(sec)')
ylabel('Magnitude')
subplot(2,1,2)
plot(t,sigNoise)
xlim([0 3]);
title('Magnitude of estimated noise in the time domain')
xlabel('Time(sec)')
ylabel('Magnitude')

%% Part 3.5
%Finding a0 through averaging the first period of the signal
a0 = mean(sigNoiseSinglePeriod); 

N = 358; %Number of discrete data
Tp = N*Ts; %Time Period

ffreq = 2*pi/Tp; %Fundamental frequency

ti = linspace(0,Tp,N+1); %Creating a time period for calculation
fhat = sigNoiseSinglePeriod; %Signal that will be used for the coefficients
%Setting the first sample to the average of the last and the first
fhat(1) = (sigNoiseSinglePeriod(1)+sigNoiseSinglePeriod(N+1))/2;
%clearing the last variable since the first is the average of the first and
%last
fhat(N+1) = [];
%Using fft to find the fourier transform of fhat for N number of samples
F = fft(fhat,N);
%an is typically equal to 2/Number of samples * the intergral of the
%function*cos(2*pi*n*t*f0), the function*cos part is equal to the index of
%the fourier transform found in F, but only the real part
an = (2/N)*real(F);
%same with bn, but the imaginary part and the signal is flipped
bn = (-2/N)*imag(F);

%Creating a vector from 0 to N number of samples
j = 0:N;
%Finding the part of the unit circle is in using the fundamental frequency
%for finding the fourier approximate
omega = j*ffreq;
%number of harmonics
L = 5;
%Setting up a variable to hold all the information
fapprox = an(1)*ones(size(ti));
%Looping through the number of harmonics the fourier approximate is found
%by the sum of an at that value multiplied by cos of the (2*pi/Tp)*the time
%at that point + bn at that value multiplied by sin of the (2*pi/Tp)*the time
% at that point. Looping through the number of harmonics adds to the degree
% that the fourier approximate is accurate
for j=1:L;
    fapprox = fapprox +an(j+1)*cos(omega(j+1)*ti)+bn(j+1)*sin(omega(j+1)*ti);
end

%% Part 3.6
%Since a0 is only really when at time 0 of a signal the first vaule of a0
%has to be changed by minusing a0 to the value But the overall approximate
%will still need to be minused by a0 to fully remove the DC bias
an(1) = an(1)-a0;
fapprox = fapprox.';
fapprox = fapprox-a0;

%% Part 3.7
%Copying the fourier approximate to fit the length of the signal
sigNoise_fs = repmat(fapprox,numberOfCopies, 1);
sigNoise_fs = sigNoise_fs(1:length(sig));

%Plotting the estimage noise generated through the function as well as the
%fourier coefficients approximated noise
figure(5)
subplot(2,1,1)
plot(t,sigNoise)
xlim([0 0.359]);
title('Magnitude of estimated noise in the time domain')
xlabel('Time(sec)')
ylabel('Magnitude')
subplot(2,1,2)
plot(t,sigNoise_fs)
xlim([0 0.359]);
title('Magnitude of the approximated noise in the time domain using 5 harmonics')
xlabel('Time(sec)')
ylabel('Magnitude')

%% Part 3.9
%Subtracting noise from the signal
im1 = sig(1,:) - sigNoise_fs.';
%Displaying the denoised image
figure(6)
imshow(reshape(im1, 480,640));
title('Denoised first signal using 5 harmonics')

%% Part 3.9 more harmonics
%New number of harmonics
L = 15;
%New fourier approximate variable
NewFapprox = an(1)*ones(size(ti));
%Looping through the new number of harmonics and storing it in the new
%fourier approximate variable.
for j=1:L;
    NewFapprox = NewFapprox +an(j+1)*cos(omega(j+1)*ti)+bn(j+1)*sin(omega(j+1)*ti);
end
%subtracting the DC bias from the signal
NewFapprox = NewFapprox-a0;
%Transposing the signal
NewFapprox = NewFapprox.';
%Copying the new fourier approximate to fit the length of the signal
sigNoise_fs = repmat(NewFapprox,numberOfCopies, 1);
sigNoise_fs = sigNoise_fs(1:length(sig));

%Plotting the new graph of the estimated noise
figure(7)
subplot(2,1,1)
plot(t,sigNoise)
xlim([0 0.359]);
title('Magnitude of estimated noise in the time domain')
xlabel('Time(sec)')
ylabel('Magnitude')
subplot(2,1,2)
plot(t,sigNoise_fs)
xlim([0 0.359]);
title('Magnitude of the approximated noise in the time domain using 15 harmonics')
xlabel('Time(sec)')
ylabel('Magnitude')

%Resetting im1 to the first signal minused the new approximated noise
im1(1,:) = sig(1,:) - sigNoise_fs.';

%Displaying the new image
figure(8)
imshow(reshape(im1(1,:), 480, 640));
title('Denoised image signal using 15 harmonics')

%% Part 3.10
%Setting a temp value to the fourier transform of the first image signal
SIGtemp = fft(im1(1,:));
%ensuring each index has a correct value
SIGtempReal = real(SIGtemp).*(abs(real(SIGtemp))>1e-6);
SIGtempIm = imag(SIGtemp).*(abs(imag(SIGtemp))>1e-6);
SIGtemp = SIGtempReal+1i*(SIGtempIm);
%Shifting the signal
SIGtemp = fftshift(SIGtemp);
%finding the middle index
middle = length(sig)/2;
%Each index in frequency domain is worth 307.2 in time domain so since the
%bandwidth noise is from around 243.5 to 259.5 in positive and negative
%domains from the middle index it needs to go out 74803 indexs at the same
%value it is currently, then remove the values for 4915 indexs and keeping
%the same value for the rest of the signal. A filter index is made like.
filter = [ones(1,73882) zeros(1,4915) ones(1,74803) ones(1,74803) zeros(1,4915) ones(1,73882)];
%multiplying the temp variable with the filter
SIGtemp = SIGtemp.*filter;
%Storing the real component of the inverse fourier transform in im2
im2(1,:) = real(ifft(SIGtemp));
%Displying the fully denoised image
figure(9)
imshow(reshape(im2(1,:), 480, 640));
title('Denoised first image signal using 15 harmonics and a bandwith filter')

%% Part 3.11
%removing the periodic signal from the original signals and storing them in
%their own part of the im1 arrray
im1(2,:) = sig(2,:) - sigNoise_fs.';
im1(3,:) = sig(3,:) - sigNoise_fs.';
im1(4,:) = sig(4,:) - sigNoise_fs.';
im1(5,:) = sig(5,:) - sigNoise_fs.';

%Plotting each figure to find where the bandwidth noise is in each signal
%so an appropiate filter can be made.
figure(10)
subplot(2,2,1)
%White noise is around 226.4 to 240.9
plot(k, fftshift(abs(fft(sig(2,:)))));
title('Magnitude of sig 2 in frequency domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(2,2,2)
%White noise is around 248 to 262.3
plot(k, fftshift(abs(fft(sig(3,:)))));
title('Magnitude of sig 3 in frequency domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(2,2,3)
%White noise is around 247.7 to 261.7
plot(k, fftshift(abs(fft(sig(4,:)))));
title('Magnitude of sig 4 in frequency domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
subplot(2,2,4)
%White noise is around 226.9 to 242.8
plot(k, fftshift(abs(fft(sig(5,:)))));
title('Magnitude of sig 5 in frequency domain')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

%removing the bandwidth noise using a similar technique in part 3.10 using
%their own filter created based on their noise.
SIGtemp = fft(im1(2,:));
SIGtempReal = real(SIGtemp).*(abs(real(SIGtemp))>1e-6);
SIGtempIm = imag(SIGtemp).*(abs(imag(SIGtemp))>1e-6);
SIGtemp = SIGtempReal+1i*(SIGtempIm);
SIGtemp = fftshift(SIGtemp);
filter = [ones(1,79595) zeros(1,4455) ones(1,69550) ones(1,69550) zeros(1,4455) ones(1,79595)];
SIGtemp = SIGtemp.*filter;
im2(2,:) = real(ifft(SIGtemp));

SIGtemp = fft(im1(3,:));
SIGtempReal = real(SIGtemp).*(abs(real(SIGtemp))>1e-6);
SIGtempIm = imag(SIGtemp).*(abs(imag(SIGtemp))>1e-6);
SIGtemp = SIGtempReal+1i*(SIGtempIm);
SIGtemp = fftshift(SIGtemp);
filter = [ones(1,73021) zeros(1,4394) ones(1,76185) ones(1,76185) zeros(1,4394) ones(1,73021)];
SIGtemp = SIGtemp.*filter;
im2(3,:) = real(ifft(SIGtemp));

SIGtemp = fft(im1(4,:));
SIGtempReal = real(SIGtemp).*(abs(real(SIGtemp))>1e-6);
SIGtempIm = imag(SIGtemp).*(abs(imag(SIGtemp))>1e-6);
SIGtemp = SIGtempReal+1i*(SIGtempIm);
SIGtemp = fftshift(SIGtemp);
filter = [ones(1,73206) zeros(1,4301) ones(1,76093) ones(1,76093) zeros(1,4301) ones(1,73206)];
SIGtemp = SIGtemp.*filter;
im2(4,:) = real(ifft(SIGtemp));

SIGtemp = fft(im1(5,:));
SIGtempReal = real(SIGtemp).*(abs(real(SIGtemp))>1e-6);
SIGtempIm = imag(SIGtemp).*(abs(imag(SIGtemp))>1e-6);
SIGtemp = SIGtempReal+1i*(SIGtempIm);
SIGtemp = fftshift(SIGtemp);
filter = [ones(1,79012) zeros(1,4884) ones(1,69704) ones(1,69704) zeros(1,4884) ones(1,79012)];
SIGtemp = SIGtemp.*filter;
im2(5,:) = real(ifft(SIGtemp));

figure(11)
subplot(2,3,1)
imshow(reshape(im2(1,:), 480, 640));
title('First signal cleaned')
subplot(2,3,2)
imshow(reshape(im2(2,:), 480, 640));
title('Second signal cleaned')
subplot(2,3,3)
imshow(reshape(im2(3,:), 480, 640));
title('Third signal cleaned')
subplot(2,3,4)
imshow(reshape(im2(4,:), 480, 640));
title('Foruth signal cleaned')
subplot(2,3,6)
imshow(reshape(im2(5,:), 480, 640));
title('Fifth signal cleaned')


%% Part 3.12 to get resolution of the images in the report

%Displaying each image
%figure(11)
%imshow(reshape(im2(2,:), 480, 640));
%title('Denoised second image signal using 15 harmonics and a bandwith filter')

%figure(12)
%imshow(reshape(im2(3,:), 480, 640));
%title('Denoised third image signal using 15 harmonics and a bandwith filter')

%figure(13)
%imshow(reshape(im2(4,:), 480, 640));
%title('Denoised fourth image signal using 15 harmonics and a bandwith filter')

%figure(14)
%imshow(reshape(im2(5,:), 480, 640));
%title('Denoised fifth image signal using 15 harmonics and a bandwith filter')

