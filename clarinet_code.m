clear all
close all
clc

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% This is a script that codes a physical model of a clarinet using digial
% waveguides.
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defining the initial parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sample rate
Fs = 44100;

% Error checking
if isnumeric(Fs)==false
    error('Sample rate must be a positive integer number');
elseif floor(Fs)~= ceil(Fs) || Fs<= 80 || Fs > 1000000
    error('Insert a positive integer number in the range 80 to 1000000');    
end
        
% Number of time steps
N = 32000;
if isnumeric(N)==false
    error('Sample rate must be a positive integer number');
elseif floor(N)~= ceil(N) || N<= 0
    error('Insert a positive integer number');
end

% Speed of sound (m)
c = 340;
if isnumeric(c) == false || c<300 || c>400
    error('c is the speed of sound and its is value is around 340m/s');
end

% Length of the clarinet (m)
L = 0.67;
if isnumeric(L) == false || L>1 || L<0.5
    error('A clarinet is in average 0.67 m long!');
end

% Length of each delay line
dLength = round((L/c)*Fs);

% Initializing the delay lines
d1 = zeros(dLength,1);
d2 = zeros(dLength,1);

% Pointer index initialization
ptr = 1;

% Variable to store the ‘previous’ value of the forward going travelling wave
delayedend = 0;

% Pressure evolution within the mouthpiece
p_MP = zeros(N, 1);


% Vector for pressure signal in player mouth
p_in = zeros(N, 1);

Tf = round(N/Fs);

p_in(1: round((1/40)*Fs)) = linspace(0, 0.5,round((1/40)*Fs));
p_in(round((1/40)*Fs)+1:round((1/40)*Fs)+round(0.5*Fs)) = linspace(0.5, 0.5,round(0.5*Fs));
p_in(round((1/40)*Fs)+round(0.5*Fs)+1:round((1/40)*Fs)+round(0.5*Fs)+round(1/60*Fs)) = linspace(0.5, 0,round(1/60*Fs));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementing the algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main simulation loop
for n = 1:N
    
   % Temporary variable
   d1out = d1(ptr);
   
   % Updating the p_MP vector
   p_MP(n) = d2(ptr);
   
   % Pressure difference across the clarinet reed
   delta_p = p_MP(n) - p_in(n);
   
   % Reflection coefficient
   r = 0.1 - 1.1*delta_p;
   
   % Updating d1
   d1(ptr) = p_in(n) + r*delta_p;
   
   % Incrementing p_MP to include the pressure reflected from the mouthpiece
   p_MP(n) = p_MP(n) + d1(ptr);
   
   % Applting a filter to represent the energy loss
   delayendnext=d1out;
   
   % New backward going travelling wave
   d2(ptr) = -0.49*(d1out + delayedend);
   
   % Updating delayedend
   delayedend = delayendnext;
   
   % Bounding r to the range 0 to 1
   if max(abs(r))>1
       r = r/max(abs(r));
   end
   
   % Updating the pointer
   ptr = ptr+1;
   
   % Checking the value of ptr
   if ptr>dLength
       ptr = 1;
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Playing and plotting the final output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plotting the final pressure waveform
plot(p_MP);
xlabel('Time(Samples)');
ylabel('Pressure Amplitude');

% Creating the final .wav file
audiowrite('clarinet_output.wav',p_MP, Fs, 'BitsPerSample', 16);

