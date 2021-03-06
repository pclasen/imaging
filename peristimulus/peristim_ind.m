function [] = peristim_ind(sub,roi,plt)
% extract run level perstimulus HRF from FIR models for an ROI and plot

dir = ['~/Documents/MIG/',sub,'/feat/P2/M2/glm/peristimts/'];

%% Phase two conditions and runs
condition = {'TswSF';'TswNF'};
run = {'R1';'R2';'R3';'R4';'R5';'R6';'R7';'R8'};

%% extract run level peristimulus for an ROI
ts = [];
index = 1;

for i = 1:length(condition)
    for j = 1:length(run)
       
        file = [dir,run{j},'_',condition{i},'_',roi,'.txt'];
        load_ts = dlmread(file);
        ts(index,:) = load_ts';
        index = index+1;
    end % j
end % i

psts.ts = ts;
psts.ts_sad = ts(1:8,:);
psts.ts_neutral = ts(9:16,:);

psts.ts_mean = mean(psts.ts);
psts.ts_mean_sad = mean(psts.ts_sad);
psts.ts_mean_neutral = mean(psts.ts_neutral);

save([dir,'/data/',roi,'.mat'],'psts');
    
%% plot
if plt == 0
    return;
    
elseif plt == 1;
    
    % constants
    x = 1:14;
    xx = 1:.25:14;
    txt1 = {'Target'};
    txt2 = {'Maintain Face ("Stay")'};
    txt3 = {'Switch to Scene ("Switch")'};
    
    % open figure
    fig = figure; hold on;
    set(gcf, 'Name', roi);
    
    % first subplot: all conditions/runs
    subplot(3,1,1);
    y = psts.ts_mean;
    yy = spline(x,y,xx);
    plot(xx,yy,'b-','LineWidth',2); hold on; % blue
    grid on;
    title('All Conditions');
    ylabel('PE');
    % event markers
    ax = axis;
    axis([1 14 ax(3) ax(4)]);
    tk = gca;
    tk.XTickLabel = [3 5 7 9 11 13 15]; 
    plot([1 1],ax(3:4),'r-','LineWidth',2); hold on;
    plot([3 3],ax(3:4),'r-','LineWidth',2); hold on;
    plot([7 7],ax(3:4),'r-','LineWidth',2); hold on;
    plot([11 11],ax(3:4),'r-','LineWidth',2); hold on;
    plot([11.5 11.5],ax(3:4),'r-','LineWidth',1); hold on;
    plot([12 12],ax(3:4),'r-','LineWidth',1); hold on;
    % add text
    text(1.6,(ax(3)+.2),txt1);
    text(3.6,(ax(3)+.2),txt2);
    text(7.2,(ax(3)+.2),txt3);

    
    % second subplot: sad faces
    subplot(3,1,2);
    y = psts.ts_mean_sad;
    yy = spline(x,y,xx);
    plot(xx,yy,'m-','LineWidth',2); hold on; % orange
    grid on;
    title('Sad Faces');
    ylabel('PE');
    % event markers
    ax = axis;
    axis([1 14 ax(3) ax(4)]);
    %tk = gca;
    %tk.XTickLabel = [0 4 6 8 10 12 14]; 
    plot([1 1],ax(3:4),'r-','LineWidth',2); hold on;
    plot([3 3],ax(3:4),'r-','LineWidth',2); hold on;
    plot([7 7],ax(3:4),'r-','LineWidth',2); hold on;
    plot([11 11],ax(3:4),'r-','LineWidth',2); hold on;
    plot([11.5 11.5],ax(3:4),'r-','LineWidth',1); hold on;
    plot([12 12],ax(3:4),'r-','LineWidth',1); hold on;
    % add text
    text(1.6,(ax(3)+.2),txt1);
    text(3.6,(ax(3)+.2),txt2);
    text(7.2,(ax(3)+.2),txt3);
    
    % third subplot: neutral faces
    subplot(3,1,3);
    y = psts.ts_mean_neutral;
    yy = spline(x,y,xx);
    plot(xx,yy,'g-','LineWidth',2); hold on; % green
    grid on;
    title('Neutral Faces');
    ylabel('PE');
    % event markers
    ax = axis;
    %tk = gca;
    %tk.XTickLabel = [0 4 6 8 10 12 14]; 
    axis([1 14 ax(3) ax(4)]);
    plot([1 1],ax(3:4),'r-','LineWidth',2); hold on;
    plot([3 3],ax(3:4),'r-','LineWidth',2); hold on;
    plot([7 7],ax(3:4),'r-','LineWidth',2); hold on;
    plot([11 11],ax(3:4),'r-','LineWidth',2); hold on;
    plot([11.5 11.5],ax(3:4),'r-','LineWidth',1); hold on;
    plot([12 12],ax(3:4),'r-','LineWidth',1); hold on;
    % add text
    text(1.6,(ax(3)+.2),txt1);
    text(3.6,(ax(3)+.2),txt2);
    text(7.2,(ax(3)+.2),txt3);
    
    % overall x label
    xlabel('seconds')
    
    % print to file as .png
    print(fig,[dir,'/plots/',roi,'.png'],'-dpng');

end

end


