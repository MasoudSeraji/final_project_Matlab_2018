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

epoch_occiptal_channel=zeros(15,203,9);%preallocating
% extract channel 24 until 32 (Occipital channels)
 for i=24:32
     epoch=zeros(15,203);%preallocating for epochs
for m=1:15
    % for each event we extract 313 samples after event
     epoch(m,:)= EEG_data(i,(event_samples(1,m):event_samples(1,m)+202));
     
end

epoch_occiptal_channel(:,:,i-23)=epoch;

 end
  output=mean(epoch_occiptal_channel);% extract VEP with averaging 
end