clc; close all; clear all;
filename1 = 'had_m_seg.wav'; filename2 = 'had_f_seg.wav';

[y,Fs] = audioread(filename2); 
% info = audioinfo(filename2);
y_row = reshape(y,1,[]); % col to row

%quantisation bits level, final part
L = 23; % 7, 15, 23, 31 bits to check sound quality
Max_in = max(y); % max val
Interval = 2*Max_in/L; %split into levels
Max_val = Max_in + Interval;
partition = -Max_in:Interval: Max_in;
codebook = -Max_in:Interval:Max_val;

%linear quantisation, multithresh partion y in L partitions
%[index, quants, distor_linear] = quantiz(y, multithresh(y,L), [multithresh(y,L) Max_in]);

% code from matlab site
[index, quants, distor_linear] = quantiz(y, partition, codebook);

% 5.1 sort coeff large to small YY
%[YY, ind] = sort (abs(Y), 'descend'); %Y(ind(1:coeff)))

% compress quantised signal, get coeff
Y = dct(quants);

% coeff represents 99% energy, % of total = 1
coeff = 1;
while norm(Y((1:coeff)))/norm(Y) < 0.999 
   coeff = coeff + 1; % count until get 99%
end

y_pc = coeff/length(Y)*100; % percent coeff

% coeff that contains remaning 0.1% energy, = 0 
Y((coeff+1:end)) = 0; %ind

% reconstruct sif from compressed
y_recon = idct(Y);

%diff original to reconstruct
diff = y_row - y_recon; 

% Write the new signal as a new audio wave
%audiowrite("had_f_recon_16b.wav",y_recon, Fs); % comment out unuse

% quantisation error
error = quants - y_recon;
v_est = var(error) % error variance

% plot original sig, its reconstruct, diff of 2
subplot (3,1,1);
plot(y);
legend('Original');

subplot (3,1,2);
plot(y_recon);
legend('Compressed & Reconstructed');

subplot (3,1,3);
plot(diff);
legend('Difference');

% play sound
sound(y_recon,Fs)