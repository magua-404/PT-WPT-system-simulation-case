%计算E类功放用来实现无线电能传输系统各个参数的小程序

%定义输入变量
L = 28.279*10^(-6);  %线圈自感值
k12 = 0.5;    %线圈实际的耦合系数
w0 = 100*10^3*2*pi;    %系统的固有谐振频率
R = 10;  %系统的负载电阻大小

%输入E类功放供电直流电压，程序可算出输出功率，反之亦然
% 不可以两个变量都输入，不输入的变量附值0即可
V1 = 0; %E类功放供电直流电压
Po = 5;   %系统输出功率
%% 计算部分
C = (1/w0)^2/L; %计算谐振子电阻

w1 = w0^2-2*(R/(2*L))^2;    %计算工作角频率所需第一项
w2 = 1-k12^2;   %计算工作角频率所需第二项
w3 = w0^4;  %计算工作角频率所需第三项
w_low = sqrt(w1/w2-sqrt(w1^2/w2^2-1/w2*w3));    %计算工作角频率低频分支
w_high = sqrt(w1/w2+sqrt(w1^2/w2^2-1/w2*w3));   %计算工作角频率高频分支
f_low = w_low/(2*pi);   %计算工作频率低频分支
f_high = w_high/(2*pi); %计算工作频率高频分支
f_w0 = w0/(2*pi);   %计算固有频率值

Lb_low = pi*(pi^2-4)/16*R/w_low;    %计算低频分支对应的E类功放剩余电感
Lb_high = pi*(pi^2-4)/16*R/w_high;  %计算高频分支对应的E类功放剩余电感
C1_low = 8/(pi*(pi^2+4)*w_low*R);   %计算低频分支对应E类功放开关管总并联电容
C1_high = 8/(pi*(pi^2+4)*w_high*R); %计算高频分支对应E类功放开关管总并联电容

Lb_w0 = pi*(pi^2-4)/16*R/w0;    %计算临界点对应的E类功放剩余电感
C1_w0 = 8/(pi*(pi^2+4)*w0*R);   %计算临界点对应E类功放开关管总并联电容

if V1 == 0
    V1_out = sqrt(Po*(pi^2+4)*R/8); %计算E类功放直流侧所需供电电压
else
    Po_out = 8*V1^2/((pi^2+4)*R);    %计算系统的输出功率
end

if V1 == 0
    Vrm = 4/sqrt(pi^2+4)*V1_out;
else
    Vrm = 4/sqrt(pi^2+4)*V1;    %计算系统输出电压幅值
end

%% 打印结果
fprintf('\n');
fprintf('系统的固有角频率 w0=%e\n',w0);
fprintf('谐振子电容 C=%e\n',C);
if V1 == 0
    fprintf('E类功放直流侧所需供电电压 V1=%e\n',V1_out);
    fprintf('系统输出电压幅值 Vrm=%e\n',Vrm);
end
if Po == 0
    fprintf('系统输出功率 Po=%e\n',Po_out);
    fprintf('系统输出电压幅值 Vrm=%e\n',Vrm);
end
fprintf('\n');
fprintf('低频分支结果： \n');
fprintf('工作角频率 w=%e\n',w_low);
fprintf('工作频率 f=%e\n',f_low);
fprintf('E类功放剩余电感 Lb=%e\n',Lb_low);
fprintf('E类功放并联总电容 C1=%e\n',C1_low);
fprintf('\n');
fprintf('高频分支结果： \n');
fprintf('工作角频率 w=%e\n',w_high);
fprintf('工作频率 f=%e\n',f_high);
fprintf('E类功放剩余电感 Lb=%e\n',Lb_high);
fprintf('E类功放并联总电容 C1=%e\n',C1_high);
fprintf('\n');
fprintf('临界点分支结果： \n');
fprintf('工作频率 f=%e\n',f_w0);
fprintf('E类功放剩余电感 Lb=%e\n',Lb_w0);
fprintf('E类功放并联总电容 C1=%e\n',C1_w0);

