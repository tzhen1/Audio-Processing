clc; close all; clear all;

% audio files
filename1 = 'had_m.wav'; filename2 = 'had_f.wav';

% info
[y,Fs] = audioread(filename2); 
info = audioinfo(filename2)
