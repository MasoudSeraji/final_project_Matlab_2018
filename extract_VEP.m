function output=extract_VEP(EEG_data,event_samples)
% in this function we should give the EEG data and samples that
% event occurred  to extract Visual Evoked Potential for each channel
% first the function extract the 203 samples after each event and then 
% the output will be extracted with averaging 
% INPUT: EEG_data: the eeg data that you give to the function
%        event_samples: the samples that trigger were happened in them
% Output: the VEP that extracted from your data the number of third
% dimention in output depends on number of your channel
% for example if you had 32 channel the number of third dimention will be 32
number_of_sample=203;
number_of_channel=9;
number_of_event=15;
epoch_occiptal_channel=zeros(number_of_event,number_of_sample,number_of_channel);%preallocating
 for eegchannel=24:32
     epoch=zeros(number_of_event,number_of_sample);%preallocating for epochs
for event=1:number_of_event
    % for each event we extract 203 samples after event
     epoch(event,:)= EEG_data(eegchannel,(event_samples(1,event):event_samples(1,event)+(number_of_sample-1)));
     
end

epoch_occiptal_channel(:,:,eegchannel-23)=epoch;

 end
  output=mean(epoch_occiptal_channel);% extract VEP with averaging 
 
end