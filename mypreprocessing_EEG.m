function [EEG_data,EEG_event]=mypreprocessing_EEG(EEG)
% This function first will recieve the EEG structure
% and then will do some preprocessing on that.
% INPUT: EEG structure 
% EEG.lowband=the lowband frequency for bandpass filtering
% EEG.highband=the highband frequency for bandpass filtering
% EEG.data=the 32 channels EEG that recorded with gtech
% EEG.eventChannel=event channel number
% EEG.removed_first_secs=the seconds that we want to remove from the start
% point of recording
% EEG.SR=sampling rate of data
% EEG.Num_time_channel=time channel number.
% EEG.Num_data_channel=data channels number.
% OUTPUT: preprocessed EEG and the samples
% that events will be happend in them

 %%    eeglab
%   importdata
 EEG_eeglab= pop_importdata('data',EEG.data,'dataformat','matlab','setname','data','srate',EEG.SR);
 % import event
  EEG_without_event = pop_chanevent(EEG_eeglab, EEG.eventChannel, 'edge','leading','delchan','on', 'delevent','on' ); 
   % remove channel baseline means from an epoched or continuous EEG dataset
   EEG_removed_baseline=pop_rmbase( EEG_without_event, [], []);
   % frequency filter
 EEG_frequency_filtered = pop_eegfiltnew(EEG_removed_baseline, EEG.lowband,EEG.highband);
 % reject data
  EEG_removed_first_2sec=  pop_select(EEG_frequency_filtered, 'notime', [0 EEG.removed_first_secs],'nochannel',EEG.Num_time_channel);
   % extract data and event from EEG struct
  EEG_data=EEG_removed_first_2sec.data;
  EEG_event=cell2mat(struct2cell(EEG_removed_first_2sec.event));
end