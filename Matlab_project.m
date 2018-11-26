% In this Script we will load the EEG data and will do some processing 
% on it, in some part of running You should eneter the input
% or click on the buttom
% Before run this script You should run eeglab in your Matlab one time
% all requirements function and files are in Matalab Project file
clc
clear 
close all
% Loading and merging data
 load('N1_15_04_2017_11_15_45_0000.mat');
 subject1_part1_N=squeeze(data);% remove the singletone dimention
 load('N1_15_04_2017_11_15_45_0001.mat');
 subject1_part2_N=squeeze(data);
 subject1_N=[subject1_part1_N,subject1_part2_N];
%%    eeglab
%   importdata
 EEG= pop_importdata('data','subject1_N','dataformat','matlab','setname','subject1_N','srate',512);
 % import event
  EEG_without_event = pop_chanevent( EEG, 35, 'edge','leading','delchan','on', 'delevent','on' ); 
   % remove channel baseline means from an epoched or continuous EEG dataset
   EEG_removed_baseline=pop_rmbase( EEG_without_event);
   % frequency filter
 EEG_frequency_filtered = pop_eegfiltnew(EEG_removed_baseline, 0.4,40);
 % reject data
  EEG_removed_first_2sec=  pop_select(EEG_frequency_filtered, 'notime', [0 2],'nochannel',[1]);
   % import location of the channels
    EEG_fixed_location = pop_chanedit(EEG_removed_first_2sec, 'load', 'channel_location.ced' );
    
     %% ICA
   EEG_run_ICA = pop_runica(EEG_fixed_location, 'icatype','runica','chanind',[1:32] );
   
   % remove eye-blinking artifact component 

  EEG_removed_eyeArtifact= pop_selectcomps(  EEG_run_ICA ,[1:32]);
  
  % in this part you should enter number of source from the map
  number_of_source=input('Look at 32 sources and enter the number of source that related to eye-blinking artifact(the red region accumulates in the front of head): ');
  EEG_preprocessed = pop_subcomp( EEG_removed_eyeArtifact,number_of_source);
  % extract data and eventfrom EEG struct
  EEG_data=EEG_preprocessed.data;
  EEG_event=cell2mat(struct2cell(EEG_preprocessed.event));
  samples_of_event_inData=EEG_event(1,:);
  % separate trigger for each visual pathway
event_samples_Magno=samples_of_event_inData(1,[1,3,5,8,9,18,19,22,29,30,32,35,36,40,41]);
event_samples_Konio=samples_of_event_inData(1,[2,4,6,10,11,15,16,21,23,24,27,31,33,38,39,43,47]);
event_samples_Parvo=samples_of_event_inData(1,[7,12,13,14,17,20,25,26,28,34,37,42,44,45,46]);
%% extract epochs from 9 occipitial channels for 3 visual pathways
% obtain VEP for Magno pathway
 VEP_Magno=extract_VEP(EEG_data,event_samples_Magno);
 % obtain VEP fo Konio pathway
  VEP_Konio=extract_VEP(EEG_data,event_samples_Konio);
  % obtain VEP fo Parvo pathway
   VEP_Parvo=extract_VEP(EEG_data,event_samples_Parvo);

 % plotting Figure for 3 visual pathway
 % for example: we will make a figure for 7th channel
 VEP_Magno=VEP_Magno(:,:,7);
 VEP_Konio=VEP_Konio(:,:,7);
 VEP_Parvo=VEP_Parvo(:,:,7);
 
 
fig = figure;
    fig.PaperUnits = 'centimeters';
    fig.Units = 'centimeters';
    fig.PaperPosition = [1 2 11.6 5];
    fig.PaperSize = [11.7 8.5];
    fig.Position = [1 2 11.7 8.5];
    
  T=0:1/512:312/512;
 max_Magno = find(VEP_Magno == max(VEP_Magno));% extract the exact sample of P100 in Magno
 plot(1000*T,VEP_Magno,'-ko','MarkerIndices',max_Magno,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Magno=max_Magno*1000*(1/512);% extract the exact time of P100 in Magno
 hold on
  max_Konio = find(VEP_Konio == max(VEP_Konio));% extract the exact sample of P100 in Konio
 plot(1000*T,VEP_Konio,'-bo','MarkerIndices',max_Konio,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Konio=max_Konio*1000*(1/512);% extract the exact time of P100 in Konio
  hold on
  max_Parvo = find(VEP_Parvo == max(VEP_Parvo));% extract the exact sample of P100 in Konio
 plot(1000*T,VEP_Parvo,'-go','MarkerIndices',max_Parvo,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
Exact_time_P100_Parvo=max_Parvo*1000*(1/512);% extract the exact time of P100 in Parvo
 legend('Magno','Parvo','Konio')
 xlim([0 600])
 ylim([-15 15])
 xlabel('ms')
 ylabel('microV')
 title('VEP for 3 visual pathways')
 set(gca,...
    'Units','centimeters',...
    'YTick',-15:5:15,...
    'XTick',0:100:600,...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',10,...
    'FontName','Arial')

 box off
 % table in the figure
 cnames = {'msec'};
    rnames = {'P100_Magno','P100_Parvo','P100_Konio'};
     column_data=[Exact_time_P100_Magno,Exact_time_P100_Konio,Exact_time_P100_Parvo]';
        uitable('Data', column_data,'ColumnName',cnames,... 
            'RowName',rnames ,'Position',[215 40 187 76]);
 