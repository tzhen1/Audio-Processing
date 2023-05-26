clc; close all; clear all;

% use segment audio
filename1 = 'had_m_seg.wav'; filename2 = 'had_f_seg.wav';

[y,Fs] = audioread(filename2);

f0 = pitch(y,Fs) % fundamental freq over t
average = mean(f0)

pitch(y,Fs)