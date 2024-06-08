%定义变量(电路参数和耦合模参数二选一输入)
%耦合模参数
% taoR = 15600*2;    %定义接收线圈损耗
% taoT = 15600*2;    %定义发射线圈损耗
% taoL = 17858737/40;  %定义负载损耗
% w0 = 10000000;  %定义原副线圈固有频率
% F = 707.1068;   %定义系统激励
%电路参数
RL = 10;    %定义负载电阻
RT = 0.2; %定义发射侧回路电阻
RR = 0.2; %定义接收侧回路电阻
Uin = 10;   %定义输入电压的有效值
L = 28.279*10^(-6); %定义线圈电感
w0 = 1/sqrt(L*63.6313*10^(-12));   %定义系统工作频率

%% 输入变量处理
taoR = RR/(2*L);
taoT = RT/(2*L);
taoL = RL/(2*L);
F = Uin/(2*sqrt(L));

%% 绘制输出功率曲面

Po =@(k,w) 2.*taoL.*(abs(k.*F./(k.^2+taoT.*(taoR+taoL)-(w0-w).^2+1i.*(taoT.*(w-w0)+(taoR+taoL).*(w-w0))))).^2;  %接收侧谐振子能量


fsurf(Po,[0*w0/2 0.2*w0/2 20*10^6 28*10^6]); %绘制功率曲面
xlabel('k');
ylabel('w');
zlabel('Po');
zlim([0 20]);

hold on;

%% 绘制输出功率在固有频率处的曲线

k = 0*w0/2:1:0.2*w0/2;   %定义自变量
Po_gu = 2.*taoL.*abs(k.*F./(k.^2+taoT.*(taoR+taoL)+1i)).^2;  %接收侧谐振子能量在固有频率处的值
w0x = w0.*k./k;

plot3(k,w0x,Po_gu,'--g','LineWidth',4);  %绘制输出功率在固有频率处的曲线

hold on;

%% 绘制输出功率在PT对称解处的曲线(耦合模解)

k = (taoR+taoL):1:0.2*w0/2;   %定义自变量
w_PTHigh = (w0 + sqrt(k.^2 - (taoR + taoL).^2)); %根据耦合系数算出对称频率点（高频分支）
Po_PTHigh =2.*taoL.*(abs(k.*F./(k.^2+taoT.*(taoR+taoL)-(w0-(w0 + sqrt(k.^2 - (taoR + taoL).^2))).^2+1i.*(taoT.*((w0 + sqrt(k.^2 - (taoR + taoL).^2))-w0)+(taoR+taoL).*((w0 + sqrt(k.^2 - (taoR + taoL).^2))-w0))))).^2;

plot3(k,w_PTHigh,Po_PTHigh,'-r','LineWidth',4);  %绘制输出功率在PT对称解高频分支处的曲线
hold on;

w_PTLow = (w0 - sqrt(k.^2 - (taoR + taoL).^2)); %根据耦合系数算出对称频率点（低频分支）
Po_PTLow = 2.*taoL.*(abs(k.*F./(k.^2+taoT.*(taoR+taoL)-(w0-(w0 - sqrt(k.^2 - (taoR + taoL).^2))).^2+1i.*(taoT.*((w0 - sqrt(k.^2 - (taoR + taoL).^2))-w0)+(taoR+taoL).*((w0 - sqrt(k.^2 - (taoR + taoL).^2))-w0))))).^2;

plot3(k,w_PTLow,Po_PTLow,'-r','LineWidth',4);  %绘制输出功率在PT对称解高频分支处的曲线
hold on;

xlabel('k');
ylabel('w');
zlabel('Po');


%% 绘制谐振无线电能的功率最大点（阻抗匹配时的最大输出功率）

% k_Wmax = sqrt(taoT*(taoL-taoR));    %得到阻抗匹配时的k值
% Po_Wmax = k_Wmax^2*F^2/(2*taoT*(k_Wmax^2+taoT*taoR));   %得到阻抗匹配时的最大功率点
% 
% scatter3(k_Wmax,w0,Po_Wmax,100,'filled',"red");    %绘制阻抗匹配时的最大功率点
% hold on;

%% 绘制效率曲面

% xiaolv =@(k,w) 2.*taoL.*abs(k.*F./(k.^2+taoT.*(taoR+taoL)-(w0-w).^2+1i.*(taoT.*(w-w0)+(taoR+taoL).*(w-w0)))).^2./(2.*taoT.*abs((taoR+taoL+1i.*(w-w0)).*F./(k.^2+taoT.*(taoR+taoL)-(w0-w).^2+1i.*(taoT.*(w-w0)+(taoR+taoL).*(w-w0)))).^2+2.*(taoR+taoL).*abs(k.*F./(k.^2+taoT.*(taoR+taoL)-(w0-w).^2+1i.*(taoT.*(w-w0)+(taoR+taoL).*(w-w0)))).^2);
% 
% fsurf(xiaolv,[0*w0/2 0.2*w0/2 0.8*w0 1.2*w0]); %绘制效率曲面
% 
% xlabel('k');
% ylabel('w');
% zlabel('Po');
