%% Problem 3 : Simulating the raised cosine method from scratch.

% Parameters
Fs = 1000;          % Sampling frequency (arbitrary)
T = 1/Fs;           % Sampling period
t = -10:T:10;     % Time vector

% Define roll-off factors
rolloff_factors = [0.5, 0.75];
r1 = rolloff_factors(1);   % 0.5
r2 = rolloff_factors(2);   % 0.75

%% Time Domain Analysis

% Generate sinc waveform
sinc_pulse = sinc(t);

% Plot sinc waveform
figure;
subplot(2, 1, 1);
plot(t, sinc_pulse, 'b', 'LineWidth', 2);
hold on;

% Plot raised cosine waveforms for different roll-off factors
r1 = 0.500001;
raised_cosine_pulse_r1 = (sinc(t) .* cos(pi * r1 * t)) ./ (1 - (2 * r1 * t).^2);
plot(t, raised_cosine_pulse_r1, 'r', 'LineWidth', 2);

raised_cosine_pulse_r2 = (sinc(t) .* cos(pi * r2 * t)) ./ (1 - (2 * r2 * t).^2);
plot(t, raised_cosine_pulse_r2, 'g', 'LineWidth', 2);

xlabel('Time');
ylabel('Amplitude');
title('Time Domain Representation');
legend('Sinc Pulse (r = 0)', 'Raised Cosine (r = 0.5)', 'Raised Cosine (r = 0.75)');
grid on;
hold off;

%% Frequency Domain Analysis

% Plot frequency domain representation
subplot(2, 1, 2);

% Compute Fourier transform of sinc waveform
f_sinc = linspace(-Fs/2, Fs/2, size(t, 2));
Sinc_pulse_fft = fftshift(fft(sinc_pulse));

% Plot sinc waveform in frequency domain
    plot(f_sinc(1, 9900 : 10100), abs(Sinc_pulse_fft(1, 9900 : 10100)), 'b', 'LineWidth', 2);
hold on;

% Compute and plot Fourier transform of raised cosine waveforms

Raised_cosine_pulse_fft_r1 = fftshift(abs(fft((sinc(t) .* cos(pi * r1 * t)) ./ (1 - (2 * r1 * t).^2))));
plot(f_sinc(1, 9900 : 10100), (Raised_cosine_pulse_fft_r1(1, 9900 : 10100)), 'r', 'LineWidth', 2);

Raised_cosine_pulse_fft_r2 = fftshift(abs(fft((sinc(t) .* cos(pi * r2 * t)) ./ (1 - (2 * r2 * t).^2))));
plot(f_sinc(1, 9900 : 10100), (Raised_cosine_pulse_fft_r2(1, 9900 : 10100)), 'g', 'LineWidth', 2);

xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain Representation');
legend('Sinc Pulse (r = 0)', 'Raised Cosine (r = 0.5)', 'Raised Cosine (r = 0.75)');
grid on;
hold off;
