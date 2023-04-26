%{
syms t T0 k

%Potenciax = 1/T0*[int(((-4/T0)*t - 3)^2,t,-T0, -T0+(T0/4))+ int(((4/T0)*t + 1)^2,t,-T0/4,0) + int(((-4/T0)*t + 1)^2,t,0,T0/4) + int(((4/T0)*t - 3)^2,t,T0-(T0/4),T0)]

Potencia_prom_x = 1/T0*[int(((-4/T0)*t - 3)^2,t,-T0, -T0+(T0/4))+ int(((4/T0)*t + 1)^2,t,-T0/4,0)]

k = 8; 
ck_x = 1/T0*[int(((-4/T0)*t - 3)*exp(-i*2*pi*k/T0*t),t,-T0, -T0+(T0/4))+ int(((4/T0)*t + 1)*exp(-i*2*pi*k/T0*t),t,-T0/4,0)]
%}

%Ejecricio 3: Transformada de Fourier%


fs = 1000;
N_per = 5;


%{
t_1 = -T/2:1/fs:T/2;
t_1 = t_1(1:length(t_1)-1);
x_1 = zeros(size(t_1));
x_1(t_1>-T/4 & t_1<T/4) = 1;

x = repmat(x_1, N_per);

fig = figure('Position', [200 100 1000 600]);

subplot(2,2,[1 2])
plot(t,x,'LineWidth',1.5)
ylim([-0.2 1.2])
grid on
title('Se�al temporal')
xlabel('Tiempo [s]')
ylabel('Amplitud [V]')

%}
%k = 0:50;

%T = 1/50
t = (0:8191)/8192;


serie=1/4;
%{
for k=1:10
s= ((1/4)*(sinc((1/4)*k)).^2).*exp(1j*2*pi*(k/T)*t);  
serie = serie + s;
end
%}

for k=1:1000
s =((1/24)*(sinc(k/24))^2)*(1 + exp(-1j*0.38*pi*k) + exp(-1j*pi*(49/60)*k) + exp(-1j*pi*k) + exp(-1j*pi*(89/75)*k) + exp(-1j*pi*(43/24)*k))*exp(1j*2*pi*(k/(6*T))*t);  
serie = serie + s;
end

subplot(1,1,1)
plot(t,serie)
title('Funcion X(t)')
xlabel('t')
ylabel('X(t)')




%{
f = -6/T:1/T:6/T;
Xf = (T/4)*(sinc((T/4)*f)).^2;
Yf = ((T/4)*(sinc((T/4)*f)).^2).*(1 + exp(-1j*2*pi*1.14*T*f) + exp(-1j*2*pi*2.45*T*f) + exp(-1j*2*pi*3*T*f) + exp(-1j*2*pi*3.56*T*f) + exp(-1j*2*pi*5.37*T*f));
subplot(1,1,1)
Data1 = [f,f];
Data2 = [abs(Xf),abs(Yf)];

stem(Data1,Data2,'.','MarkerSize',13)
%stem(f,abs(Yf),'.','MarkerSize',13)
title('M�dulo de la Transformada de Fourier de y(t)')
xlabel('f')
ylabel('|X(f)|')
%}

%{
subplot(2,2,4)
a = abs(Ck) < 1e-5;
fase = angle(Ck);
fase(a) = NaN;
stem(k,fase,'.','MarkerSize',13)
title('Fase de los coeficientes de la serie de Fourier')
xlabel('k')
ylabel('arg(Ck)')
%}