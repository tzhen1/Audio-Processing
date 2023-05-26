clc; close all; clear all;
filename1 = 'had_m.wav'; filename2 = 'had_f.wav';

% male or female audiofile
[y,Fs] = audioread(filename2); 
info = audioinfo(filename2)

% choose 100ms sample  
t_start = 100e-3; % start 
t_end = 200e-3;
t_segment = t_start:1/Fs:t_end;
start_sample = floor(t_start * Fs);
end_sample = floor(t_end * Fs);

sample_range = [start_sample, end_sample]; 

% Get the new wave form the set selected part of the signal
[y_seg, Fs_seg] = audioread(filename2,sample_range);
Total_Time = audioinfo(filename2).Duration(); %change file

% new audio for Q4 pitch, comment do stop overwrite
%audiowrite("had_m_seg.wav",y_seg, Fs_seg);
%audiowrite("had_f_seg.wav",y_seg, Fs_seg);

% plot time 100ms segment
% subplot(2,1,1);
% plot(t_segment,y_seg);
% xlabel('Time (s)'); ylabel('Amplitude'); grid;

% frequency
N = length(y_seg); % lenght of DFT
freq = linspace(-Fs/2,Fs/2,N);
y_dft = fftshift(fft(y_seg)); %fft
mag = abs(y_dft);
mag_dB = 20*log10(mag);

subplot(2,1,1);
plot(freq,mag);
xlabel('Frequency'); ylabel('Magnitude');

% phase
phase = unwrap(angle(y_dft));

subplot(2,1,2);
plot(freq,phase);
xlabel('Frequency'); ylabel('Phase');


