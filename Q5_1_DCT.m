clc; close all; clear all;
% compress a speech sig, DCT
filename1 = 'had_m_seg.wav'; filename2 = 'had_f_seg.wav';

[y,Fs] = audioread(filename2); 
info = audioinfo(filename2);

% compress signal, coeff 
Y = dct(y);
% plot(Y);

% 5.1 sort coeff large to small YY
[YY, ind] = sort (abs(Y), 'descend');

% coeff represents 99% energy
coeff = 1; % 100%
while norm(Y(ind(1:coeff)))/norm(Y) < 0.8
   coeff = coeff + 1; % count until get 99%
end
needed = coeff;

y_pc = coeff/length(Y)*100; % percent coeff

% coeff that contains remaning 0.1% energy, = 0 
Y(ind(needed+1:end)) = 0; 

% reconstruct sif from compressed
y_recon = idct(Y);

%diff original to reconstruct
diff = y - y_recon;

% Write the new signal as a new audio wave
%audiowrite("had_f_recon.wav",y_recon, Fs);

% plot original sig, its reconstruct, diff of 2
subplot (3,1,1);
plot(y)
legend('Original')

subplot (3,1,2);
plot(y_recon)
legend('Compressed & Reconstructed')

subplot (3,1,3);
plot(diff)
legend('Difference')