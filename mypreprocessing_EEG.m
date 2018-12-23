function [EEG_data,EEG_event]=mypreprocessing_EEG(data_part_1,data_part_2)
% This function first will merge the data
% and then will do some preprocessing on that.
% INPUT: two part of the data
% OUTPUT: preprocessed EEG and the samples
% that events will be happend in them
load(data_part_1);
 subject_part1=squeeze(data);% remove the singletone dimention
 load(data_part_2);
 subject_part2=squeeze(data);
 subject=[subject_part1,subject_part2];
 %%    eeglab
%   importdata
 EEG= pop_importdata('data',subject,'dataformat','matlab','setname','subject','srate',512);
 % import event
  EEG_without_event = pop_chanevent( EEG, 35, 'edge','leading','delchan','on', 'delevent','on' ); 
   % remove channel baseline means from an epoched or continuous EEG dataset
   EEG_removed_baseline=pop_rmbase( EEG_without_event);
   % frequency filter
 EEG_frequency_filtered = pop_eegfiltnew(EEG_removed_baseline, 0.4,40);
 % reject data
  EEG_removed_first_2sec=  pop_select(EEG_frequency_filtered, 'notime', [0 2],'nochannel',[1]);
   % extract data and event from EEG struct
  EEG_data=EEG_removed_first_2sec.data;
  EEG_event=cell2mat(struct2cell(EEG_removed_first_2sec.event));
end