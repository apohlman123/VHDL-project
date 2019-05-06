x1 = 0:0.01:6.28;
x2 = 0:0.001:6.28;

y1 = sin(x1);
y2 = sin(50000*x2);

%plots for simulation screenshots
%plot(x1,y1);
%plot(x2,y2);




%my earnest attempt at file manipulation
%ultimately added samples to an array of integers in VHDL file

%y_passL = int8(127*sin(x1));
%y_passR = int8(127*sin(50000*x2));
%y_npassL = int8(127*sin(50000*x2));
%y_npassR = int8(127*sin(x1));

%bin_y_passL = dec2bin(typecast(int8(y_passL),'uint8'));
%bin_y_passR = dec2bin(typecast(int8(y_passR),'uint8'));

%plot(x2,y_passR);
%disp(y_passL);

%dlmwrite('sin_waveL.txt',y_passL)
%dlmwrite('sin_waveR.txt',y_passR)


% % %%simple sine wave for testing
% x = [0:200];
% y18bit = int8(127*sin(x));
% y116bit = int16(32767*sin(x));
% %disp(y116bit);
% %y124bit = sin(x);
% y132bit = int32(4294967296*sin(x));
% %plot(x,y1);
% dlmwrite('sin_wave8bit.txt',y18bit,'delimiter','\r')
% dlmwrite('sin_wave16bit.txt',y116bit,'delimiter','\r')
% %dlmwrite('sin_wave24bit.txt',y124bit,'delimiter','\r')
% dlmwrite('sin_wave32bit.txt',y132bit,'delimiter','\r')
% 
% phase_shift = pi/2;
% y28bit = int8(127*sin(x-phase_shift));
% y216bit = int16(32767*sin(x-phase_shift));
% %y224bit = sin(x-phase_shift);
% y232bit = int32(4294967296*sin(x-phase_shift));
% %plot(x,y2);
% dlmwrite('sin_phase_shift8bit.txt',y28bit,'delimiter','\r')
% dlmwrite('sin_phase_shift16bit.txt',y216bit,'delimiter','\r')
% %dlmwrite('sin_phase_shift24bit.txt',y224bit,'delimiter','\r')
% dlmwrite('sin_phase_shift32bit.txt',y232bit,'delimiter','\r')
% 
% random_noise = 0.3*randn(1,length(x));
% y38bit = int8(127*(sin(x) + random_noise));
% y316bit = int16(32767*(sin(x) + random_noise));
% %y324bit = sin(x) + random_noise;
% y332bit = int32(4294967296*(sin(x) + random_noise));
% %plot(x,y3);
% dlmwrite('sin_wave_noisy8bit.txt',y38bit,'delimiter','\r')
% dlmwrite('sin_wave_noisy16bit.txt',y316bit,'delimiter','\r')
% %dlmwrite('sin_wave_noisy8bit.txt',y324bit,'delimiter','\r')
% dlmwrite('sin_wave_noisy32bit.txt',y332bit,'delimiter','\r')
