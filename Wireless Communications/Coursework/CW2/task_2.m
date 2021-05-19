clc
clear all
close all

addpath('./functions/')

SNR_dB = -10:20;
smaple_num = 10000;

C_2_2 = zeros(2,length(SNR_dB));
C_4_2 = zeros(2,length(SNR_dB));
C_2_4 = zeros(2,length(SNR_dB));
for i = 1:length(SNR_dB)
    % CSIT
    C_2_2(1,i) = CSITCapacity(2,2,SNR_dB(i),smaple_num);
    C_4_2(1,i) = CSITCapacity(4,2,SNR_dB(i),smaple_num);    
    C_2_4(1,i) = CSITCapacity(2,4,SNR_dB(i),smaple_num);
    
    % CDIT
    C_2_2(2,i) = CDITCapacity(2,2,SNR_dB(i),smaple_num);
    C_4_2(2,i) = CDITCapacity(4,2,SNR_dB(i),smaple_num);    
    C_2_4(2,i) = CDITCapacity(2,4,SNR_dB(i),smaple_num);   
end

%% plotting
LineWidth = 1;
plot(SNR_dB,C_2_2(1,:),'-o','color',[0,0,1],'LineWidth',LineWidth);
hold on;
plot(SNR_dB,C_4_2(1,:),'-x','color',[1,0,0],'LineWidth',LineWidth);
plot(SNR_dB,C_2_4(1,:),'-s','color',[0,0,0],'LineWidth',LineWidth);

plot(SNR_dB,C_2_2(2,:),'--o','color',[0,0,1],'LineWidth',LineWidth);
plot(SNR_dB,C_4_2(2,:),'--x','color',[1,0,0],'LineWidth',LineWidth);
plot(SNR_dB,C_2_4(2,:),'--s','color',[0,0,0],'LineWidth',LineWidth);
grid on;
legend('2x2 (CSIT)','4x2 (CSIT)','2x4 (CSIT)','2x2 (CDIT)','4x2 (CDIT)','2x4 (CDIT)');
xlabel('SNR (dB)');
ylabel('Ergodic capacity (bps/Hz)');
set(gca,'YTick',0:1:16);

