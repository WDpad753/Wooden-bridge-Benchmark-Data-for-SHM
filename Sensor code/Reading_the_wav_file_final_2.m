%% Reading the sensor signal data and plotting the figures:

% Clearing:
close all; clear; clc

% Reading the file:
folder = 'Wooden Bridge Time Histories\May 18';
audio_files = dir(fullfile(folder,'*.wav'));

% Setting the variables for sampling frequnecy and time period:
Fs = 1096;
samples = [1,2*Fs];
clear y Fs

% Creating variables:
l1 = 0;
l2 = 0;
data1 = zeros(1,1);
data2 = zeros(1,1);

% reading the audio files:
for k = 1:numel(audio_files)
  filename = audio_files(k).name;
  full_file_name = fullfile(folder,filename);
  [y, fs] = audioread(full_file_name, samples);
  
  % Plotting the graph of acceleration:
  for ci = 2:16
      % Display the signal:
      sen_val = ci-1;
      figure(sen_val),
      plot(y(:,ci));
      xlabel('Time (s)');
      ylabel('Acceleration (ms^-2)');
      title("Single video Sensor " + sen_val + " Data");

      % Converting the time domain signal into frequency domain:
      L = length(y(:,ci));
      Y = fft(y(:,ci));
      P2 = abs(Y/L);
      P1 = P2(1:L/2+1);
      P1(2:end-1) = 2*P1(2:end-1);
      f = fs*(0:(L/2))/L;
      
      % Plotting the graph of frequency domain:
      figure(sen_val+1),
      plot(f,P1) 
      title("Single-Sided Amplitude Spectrum of S(t)")
      xlabel("f (Hz)")
      ylabel("|P1(f)|")
      
      pause(10);
% 
%       % Saving the data into a text file:
%       finalfilename = [int2str(k),'.txt'];
%       save(finalfilename, 'y', '-ascii');
  end
  clf
end
