clc; close all; clear all;
% audio files
filename1 = 'had_m.wav'; filename2 = 'had_f.wav';

% info
[y,Fs] = audioread(filename2); 
info = audioinfo(filename2)
N = length(y);

% Get the total time of signal
Total_Time = audioinfo(filename2).Duration();

% time domain
t = linspace(0,Fs,N); % start 0, multiply fs (1/t) to end time

% time array in seconds
time_array = 0:seconds(1/Fs):seconds(Total_Time);
time_array = time_array(1:end-1);

% plot time
figure;
plot(time_array,y);
xlabel('Time (s)');
ylabel('Amplitude');