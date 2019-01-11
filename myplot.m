function myplot(VEP_N,VEP_P,channel_for_Normal,channel_for_patient)
% this function get the VEP for healthy subjects and MS patient
% and plot 3 figure in 3 subplot that show the delay of P100 
% component between healthy subject and MS patient
% INPUT: VEP of healthy subject and MS patientand the channels for
% both of them to plot
% OUTPUT: a figure with 3 subplot
SR=512;
number_of_sample=203;

    x_arrow_psition(1,:)=[0.36 0.56];
    x_arrow_psition(2,:)=[0.39 0.71];
    x_arrow_psition(3,:)=[0.41 0.645];
    y_arrow_position(1,:)=[0.895 0.895];
    y_arrow_position(2,:)=[0.61 0.61];
    y_arrow_position(3,:)=[0.28 0.28];
    dim_text_position(1,:)=[0.36 0.46 0.47 0.47];
    dim_text_position(2,:)=[0.45 0.25 0.37 0.37];
    dim_text_position(3,:)=[0.43 0.05 0.27 0.27];
    figure_tit(1,:)='VEP for Magno pathway';
    figure_tit(2,:)='VEP for Konio pathway';
    figure_tit(3,:)='VEP for Parvo pathway';
  T=0:1/SR:(number_of_sample-1)/SR;
  % I put the data of Magno, Konio, and Parvo in the
  % first, second, and third row of third dimention of VEP_N
  % and VEP_P, respectively.
   for  VisualPathway_type=1:3
       subplot(3,1,VisualPathway_type)
 max_N = find(VEP_N(:,channel_for_Normal, VisualPathway_type) == max(VEP_N(:,channel_for_Normal,VisualPathway_type)));% extract the exact sample of P100 in Magno
 plot(1000*T,VEP_N(:,channel_for_Normal,VisualPathway_type),'-bo','MarkerIndices',max_N,...
    'MarkerFaceColor','red',...
    'MarkerSize',5)
 hold on
max_P = find(VEP_P(:,channel_for_patient, VisualPathway_type) == max(VEP_P(:,channel_for_patient,VisualPathway_type)));% extract the exact sample of P100 in Magno

 plot(1000*T,VEP_P(:,channel_for_patient,VisualPathway_type),'-ro','MarkerIndices',max_P,...
    'MarkerFaceColor','blue',...
    'MarkerSize',5)
 legend('N','P')
 xlim([0 350])
 ylim([-15 15])
 xlabel('ms')
 ylabel('microV')
  title(figure_tit(VisualPathway_type,:))
 annotation('doublearrow',x_arrow_psition(VisualPathway_type,:),y_arrow_position(VisualPathway_type,:),'Color',[0.5 0.5 0.5],'HeadStyle','plain','Head1Width',3,'Head2Width',3,'LineWidth',0.7,'Head1Length',3.5,'Head2Length',3.5);
 annotation('textbox',dim_text_position(VisualPathway_type,:),'String','delay(P100)','FitBoxToText','on','FontName','Arial','FontSize',10,'FontWeight','bold','LineStyle','none');
 box off

  end

end