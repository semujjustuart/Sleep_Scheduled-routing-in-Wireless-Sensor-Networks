%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                            ESSTBRP Protocol                           
%                                                                      
%                           By: stuart                                
%                           Supervisor: 1.Prof. Pan Zhuojin                     
%                                       2.Dr.Zhen                      
%                          Shenyang Aerospace University  
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Network Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
xm =100;
ym =100;
sink.x= 0.5 * xm;
sink.y= 0.5 * ym;
Bx = sink.x;
By = sink.y;
  plot(Bx,By,'k*')
  hold on
beacon_length = 20;
%ctl_length=100;
data_length=4000;%
En = 0.5; %Initial energy of all nodes
Range = 5; % I consider 5m,  
ETX=50*10^(-9);
ERX=50*10^(-9);
%Transmit Amplifier statuss
Efs=10*10^(-12);
Eamp=0.0013*10^(-12);
%Data Aggregation Energy
EDA=5*10^(-9);
do=sqrt(Efs/Eamp);
node_number= 100;
dis_to_bs =0;
rmax= 3000;
send_P = 0;
send_to_sink_P=0;  
begin_to_send = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Network Partitioning into Four regions.Each region having equal number of
%nodes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for i=1:1:node_number%nodes area wise distribution
    if(i<26)
        S3(i).xd=rand*50;
        S3(i).yd=rand*50;
           plot(S3(i).xd,S3(i).yd,'ro')
%          xlabel('X-Coordinate(m)','FontSize',14);
%           ylabel('Y-Coordinate(m)','FontSize',14);
          hold on
        S3(i).E=En;
        S3(i).Q=0;
    end
    if(i>25 && i<51)
        S3(i).xd=rand*50;
        S3(i).yd=50+rand*50;
           plot(S3(i).xd,S3(i).yd,'go')
           hold on
        S3(i).E=En;
        S3(i).Q=0;
    end
    if(i>50 && i<76)
        S3(i).xd=50+rand*50;
        S3(i).yd=50+rand*50;
           plot(S3(i).xd,S3(i).yd,'mo')
          hold on
        S3(i).E=En;
        S3(i).Q=0;
    end
    if(i>75&& i<101)
        S3(i).xd=50+rand*50;
        S3(i).yd=rand*50;
        
          plot(S3(i).xd,S3(i).yd,'bo')
           hold on
        S3(i).E=En;
        S3(i).Q=0;
    end%%%%%%%
end

 x=[50,50];
 y=[0,100];
 plot(x,y , 'k-')
 hold on;
% 
 x=[0,100];
 y=[50,50];
 plot(x,y , 'k-')
 hold on;




