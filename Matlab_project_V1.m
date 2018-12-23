% In this Script we will load the EEG data and will do some processing 
% on it, in some part of running You should click on the buttom
% Before run this script You should run eeglab in your Matlab one time
% all requirements function and files are in the github
clc
clear 
close all

%% Merging and preprocessing data for Healthy subject
[EEG_data_N,EEG_event]=mypreprocessing_EEG('N1_15_04_2017_11_15_45_0000.mat','N1_15_04_2017_11_15_45_0001.mat');
  samples_of_event_inData=EEG_event(1,:);
   % separating trigger for each visual pathway
event_samples_Magno=samples_of_event_inData(1,[1,3,5,8,9,18,19,22,29,30,32,35,36,40,41]);
event_samples_Konio=samples_of_event_inData(1,[2,4,6,10,11,15,16,21,23,24,27,31,33,38,39,43,47]);
event_samples_Parvo=samples_of_event_inData(1,[7,12,13,14,17,20,25,26,28,34,37,42,44,45,46]);

  % extract epochs from 9 occipitial channels for 3 visual pathways
% obtain VEP for Magno pathway
 VEP_Magno_N=extract_VEP(EEG_data_N,event_samples_Magno);
 % obtain VEP fo Konio pathway
  VEP_Konio_N=extract_VEP(EEG_data_N,event_samples_Konio);
  % obtain VEP fo Parvo pathway
   VEP_Parvo_N=extract_VEP(EEG_data_N,event_samples_Parvo);
   % plotting Figure for 3 visual pathway
 % for example: we will make a figure for 7th channel
 VEP_Magno_N=VEP_Magno_N(:,:,7);
 VEP_Konio_N=VEP_Konio_N(:,:,7);
 VEP_Parvo_N=VEP_Parvo_N(:,:,7);
   %% Merging and preprocessing data for MS Patient
[EEG_data_P,~]=mypreprocessing_EEG('P14_09_07_2017_12_16_56_0000.mat','P14_09_07_2017_12_16_56_0001.mat');
  %samples_of_event_inData=EEG_event(1,:);
  % extract epochs from 9 occipitial channels for 3 visual pathways
% obtain VEP for Magno pathway
 VEP_Magno_P=extract_VEP(EEG_data_P,event_samples_Magno);
 % obtain VEP fo Konio pathway
  VEP_Konio_P=extract_VEP(EEG_data_P,event_samples_Konio);
  % obtain VEP fo Parvo pathway
   VEP_Parvo_P=extract_VEP(EEG_data_P,event_samples_Parvo);
   % plotting Figure for 3 visual pathway
 % for example: we will make a figure for 7th channel
 VEP_Magno_P=VEP_Magno_P(:,:,9);
 VEP_Konio_P=VEP_Konio_P(:,:,9);
 VEP_Parvo_P=VEP_Parvo_P(:,:,9);
   
  

 %% plotting Figure for 3 visual pathway  
 % Healthy subject
fig = figure;
    fig.PaperUnits = 'centimeters';
    fig.Units = 'centimeters';
    fig.PaperPosition = [1 2 11.6 5];
    fig.PaperSize = [11.7 15];
    fig.Position = [1 2 11.7 15];
    
  T=0:1/512:202/512;
 max_Magno_N = find(VEP_Magno_N == max(VEP_Magno_N));% extract the exact sample of P100 in Magno
 subplot(2,1,1)
 plot(1000*T,VEP_Magno_N,'-ko','MarkerIndices',max_Magno_N,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Magno_N=max_Magno_N*1000*(1/512);% extract the exact time of P100 in Magno
 hold on
  max_Konio_N = find(VEP_Konio_N == max(VEP_Konio_N));% extract the exact sample of P100 in Konio
 plot(1000*T,VEP_Konio_N,'-bo','MarkerIndices',max_Konio_N,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Konio_N=max_Konio_N*1000*(1/512);% extract the exact time of P100 in Konio
  hold on
  max_Parvo_N = find(VEP_Parvo_N == max(VEP_Parvo_N));% extract the exact sample of P100 in Konio
 plot(1000*T,VEP_Parvo_N,'-go','MarkerIndices',max_Parvo_N,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Parvo_N=max_Parvo_N*1000*(1/512);% extract the exact time of P100 in Parvo
 legend('Magno','Parvo','Konio')
 xlim([0 400])
 ylim([-15 15])
 xlabel('ms')
 ylabel('microV')
 title('VEP for 3 visual pathways Healthy Subject')

 box off
 % MS patient
  subplot(2,1,2)

 max_Magno_P = find(VEP_Magno_P == max(VEP_Magno_P));% extract the exact sample of P100 in Magno
 subplot(2,1,2)
 plot(1000*T,VEP_Magno_P,'-ko','MarkerIndices',max_Magno_P,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Magno_P=max_Magno_P*1000*(1/512);% extract the exact time of P100 in Magno
 hold on
  max_Konio_P = find(VEP_Konio_P == max(VEP_Konio_P));% extract the exact sample of P100 in Konio
 plot(1000*T,VEP_Konio_P,'-bo','MarkerIndices',max_Konio_P,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Konio_P=max_Konio_P*1000*(1/512);% extract the exact time of P100 in Konio
  hold on
  max_Parvo_P = find(VEP_Parvo_P == max(VEP_Parvo_P));% extract the exact sample of P100 in Konio
 plot(1000*T,VEP_Parvo_P,'-go','MarkerIndices',max_Parvo_P,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Parvo_P=max_Parvo_P*1000*(1/512);% extract the exact time of P100 in Parvo
 legend('Magno','Parvo','Konio')
 xlim([0 400])
 ylim([-15 15])
 xlabel('ms')
 ylabel('microV')
 title('VEP for 3 visual pathways MS Patient')

 box off
 % table in the figure Healthy Subject
 cnames = {'msec'};
    rnames = {'P100_Magno','P100_Parvo','P100_Konio'};
     column_data=[Exact_time_P100_Magno_N,Exact_time_P100_Konio_N,Exact_time_P100_Parvo_N]';
        uitable('Data', column_data,'ColumnName',cnames,... 
            'RowName',rnames ,'Position',[215 331 187 76]);
        % table in the figure MS Ptient
 cnames = {'msec'};
    rnames = {'P100_Magno','P100_Parvo','P100_Konio'};
     column_data=[Exact_time_P100_Magno_P,Exact_time_P100_Konio_P,Exact_time_P100_Parvo_P]';
        uitable('Data', column_data,'ColumnName',cnames,... 
            'RowName',rnames ,'Position',[215 61 187 76]);
 