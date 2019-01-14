function output=extract_VEP(VEP)
% in this function we should give the EEG data and samples that
% event occurred  to extract Visual Evoked Potential for each channel
% first the function extract the samples after each event and then
% the output will be extracted with averaging
% INPUT:
% VEP.EEG_data= the eeg data that you give to the function
% VEP.event_samples= the samples that trigger were happened in them
% VEP.number_of_sample= The number of samples after events that you
% want to extract VEP ;
% VEP.channel_number= The channels that you want extract VEP from them;
% VEP.number_of_event=The number of events that occure during
% the EEG data;
% Output: the VEP that extracted from your data the number of second
% dimention in output depends on number of your channel
% for example if you had 32 channel the number of second dimention will be 32


epoch=zeros(length(VEP.channel_number),VEP.number_of_sample,VEP.number_of_event);%preallocating for epochs
for event=1:VEP.number_of_event
    % for each event we extract samples after event
    
    epoch(:,:,event)= VEP.EEG_data(VEP.channel_number,(VEP.event_samples(1,event):VEP.event_samples(1,event)+(VEP.number_of_sample-1)));
end
output=mean(epoch,3);% extract VEP with averaging
output=output';

end