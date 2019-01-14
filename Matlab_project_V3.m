% In this Script we will load the EEG data and will do some processing
% on it.
% Before run this script You should run eeglab in your Matlab one time
% all requirements function and files are in the github
clc
clear
close all
SR=512;
location_Magno_trigger=[1,3,5,8,9,18,19,22,29,30,32,35,36,40,41];
location_Konio_trigger=[2,4,6,10,11,15,16,21,23,24,27,31,33,38,39,43,47];
location_Parvo_trigger=[7,12,13,14,17,20,25,26,28,34,37,42,44,45,46];
channel_for_Normal=7;
channel_for_patient=9;
Magno_data_row=1;
Konio_data_row=2;
Parvo_data_row=3;
number_of_sample=203;
number_of_channel=9;
number_of_visualpathway=3;

%% Merging and preprocessing data for Healthy subject
% making EEG struct for preprocessing
EEG.lowband=0.4;
EEG.highband=40;
EEG.data='N1a.mat';
EEG.eventChannel=35;
EEG.removed_first_secs=2;
EEG.SR=512;
EEG.Num_time_channel=1;
EEG.Num_data_channel=2:34;

[EEG_data_preprocessed_N,EEG_event]=mypreprocessing_EEG(EEG);
samples_of_event_inData=EEG_event(1,:);
% separating trigger for each visual pathway
event_samples(Magno_data_row,:)=samples_of_event_inData(1,location_Magno_trigger);
event_samples(Konio_data_row,:)=samples_of_event_inData(1,location_Konio_trigger(1,1:15));
event_samples(Parvo_data_row,:)=samples_of_event_inData(1,location_Parvo_trigger);

% extract epochs from 9 occipitial channels for 3 visual pathways
% obtain VEP for Magno,Konio, and Parvo pathways
% I put the data of Magno, Konio, and Parvo in the
% first, second, and third row of third dimention of VEP_N
% and VEP_P respectively.
VEP_N=zeros(number_of_sample,number_of_channel,number_of_visualpathway);
% VEP.EEG_data=EEG_data_preprocessed_N;
% VEP.event_samples=event_samples;
% VEP.number_of_sample=203;
% VEP.channel_number=24:32;

for VisualPathway_type=1:3
    VEP.EEG_data=EEG_data_preprocessed_N;
    VEP.event_samples=event_samples(VisualPathway_type,:);
    VEP.number_of_sample=203;
    VEP.channel_number=24:32;
    VEP.number_of_event=15;
    VEP_N(:,:,VisualPathway_type)=extract_VEP(VEP);
end

%% Merging and preprocessing data for MS Patient
EEG.data='P14a.mat';
[EEG_data_preprocessed_P,~]=mypreprocessing_EEG(EEG);
% extract epochs from 9 occipitial channels for 3 visual pathways
% obtain VEP for Magno,Konio, and Parvo pathways
% I put the data of Magno, Konio, and Parvo in the
% first, second, and third row of third dimention of VEP_N
% and VEP_P respetively
VEP_P=zeros(number_of_sample,number_of_channel,number_of_visualpathway);
for VisualPathway_type=1:3
    VEP.EEG_data=EEG_data_preprocessed_P;
    VEP.event_samples=event_samples(VisualPathway_type,:);
    VEP.number_of_sample=203;
    VEP.channel_number=24:32;
    VEP.number_of_event=15;
    VEP_P(:,:,VisualPathway_type)=extract_VEP(VEP);
end

%% plotting Figure for 3 visual pathway
% Healthy subject and MS patients
fig = figure;
fig.PaperUnits = 'centimeters';
fig.Units = 'centimeters';
fig.PaperPosition = [1 2 11.6 5];
fig.PaperSize = [11.7 15];
fig.Position = [1 2 11.7 15];
myplot(VEP_N,VEP_P,channel_for_Normal,channel_for_patient);

