
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
beacon_length = 2000;
ctl_length= 300;
data_length=4000;%
En = 0.5; %Initial energy of all nodes
Range = 10; % I consider 5m,  
ETX = 50*10^(-9);
ERX = 50*10^(-9);
%Transmit Amplifier statuss
Efs = 10*10^(-12);
Eamp = 0.0013*10^(-12);
%Data Aggregation Energy
EDA = 5*10^(-9);
do = sqrt(Efs/Eamp);
node_number = 100;
dis_to_bs = 0;
rmax = 4000;
send_P = 0;
send_to_sink_P = 0;  
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
          xlabel('X-Coordinate(m)','FontSize',9);
           ylabel('Y-Coordinate(m)','FontSize',9);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Energy dissipated by each node to send beacon to base station. This is
%done at the start, before Network partitioning
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  Initial_distance_A = zeros(1,25);
  Initial_distance_B = zeros(1,25);
  Initial_distance_C = zeros(1,25);
  Initial_distance_D = zeros(1,25);
%     
 for ii=1:1:25            
          S3(ii).Initial_distance_A  = sqrt((S3(ii).xd-Bx)^2+(S3(ii).yd -By)^2);
 end
  for ii=1:1:25      % calculate energy dissipated by each sensor node to send beacon to base staion (region A)
% %                           
              if  S3(ii).Initial_distance_A > do
                   S3(ii).E= S3(ii).E-(ETX*beacon_length + beacon_length*Eamp*((S3(ii).Initial_distance_A)*(S3(ii).Initial_distance_A)*(S3(ii).Initial_distance_A)*(S3(ii).Initial_distance_A)));
% %                 %disp( S3(ii).E);
             else
                   S3(ii).E= S3(ii).E-(ETX*beacon_length + beacon_length*Efs*(S3(ii).Initial_distance_A)*(S3(ii).Initial_distance_A));
% %                %disp( S3(ii).E);
             end
  end 

  for ii=1:1:25         % calculate energy dissipated by each sensor node to recieve region neighbour information from base station (region A)
%                            
%              
                   S3(ii).E= (S3(ii).E - (ERX*beacon_length));
  end  
 for ii=26:1:50               
        S3(ii).Initial_distance_B    = sqrt((S3(ii).xd-Bx)^2+(S3(ii).yd -By)^2);
 end
  for ii=26:1:50        % calculate energy dissipated by each sensor node to send beacon to base staion (region B)
% %                           
              if   S3(ii).Initial_distance_B  > do
                   S3(ii).E= S3(ii).E-(ETX*beacon_length+beacon_length*Eamp*(( S3(ii).Initial_distance_B)*( S3(ii).Initial_distance_B)*( S3(ii).Initial_distance_B)*( S3(ii).Initial_distance_B)));
% %                 %disp( S3(ii).E);
              else
                   S3(ii).E= S3(ii).E-(ETX*beacon_length+beacon_length*Efs*(S3(ii).Initial_distance_B)*( S3(ii).Initial_distance_B));
% %                %disp( S3(ii).E);
              end
  end 
  for ii=26:1:50         % calculate energy dissipated by each sensor node to recieve region neighbour information from base station (region B)
%                            
%              
                   S3(ii).E= (S3(ii).E - (ERX*beacon_length));
  end   
  for ii=51:1:75            
         S3(ii).Initial_distance_C   = sqrt((S3(ii).xd-Bx)^2+(S3(ii).yd -By)^2);
  end
   for ii=51:1:75      % calculate energy dissipated by each sensor node to send beacon to base staion  (region C)
% %                           
              if      S3(ii).Initial_distance_C > do
                        S3(ii).E= S3(ii).E-(ETX*beacon_length+beacon_length*Eamp*((S3(ii).Initial_distance_C)*(S3(ii).Initial_distance_C)*(S3(ii).Initial_distance_C)*(S3(ii).Initial_distance_C)));
% %                 %disp( S3(ii).E);
              else
                      S3(ii).E= S3(ii).E-(ETX*beacon_length+beacon_length*Efs*( S3(ii).Initial_distance_C)*(S3(ii).Initial_distance_C));
%                 %disp( S3(ii).E);
              end
   end     
%  
  for ii=51:1:75         % calculate energy dissipated by each sensor node to recieve region neighbour information from base station (region C)
%                            
%              
                  S3(ii).E= (S3(ii).E - (ERX*beacon_length));
  end
  
  for ii=76:1:100        
         S3(ii).Initial_distance_D   = sqrt((S3(ii).xd-Bx)^2+(S3(ii).yd -By)^2);
  end
 
  for ii=76:1:100        % calculate energy dissipated by each sensor node to send beacon to base staion (region D)
%                            
              if  S3(ii).Initial_distance_D  > do
                   S3(ii).E= S3(ii).E-(ETX*beacon_length+beacon_length*Eamp*((S3(ii).Initial_distance_D )*(S3(ii).Initial_distance_D )*(S3(ii).Initial_distance_D )*(S3(ii).Initial_distance_D )));
%                  %disp( S3(ii).E);
              else
                   S3(ii).E= S3(ii).E-(ETX*beacon_length+beacon_length*Efs*(S3(ii).Initial_distance_D )*(S3(ii).Initial_distance_D ));
%                 %disp( S3(ii).E);
              end
  end
%  
  for ii=76:1:100        % calculate energy dissipated by each sensor node to recieve region neighbour information from base station (region D)
%                            
%              
                   S3(ii).E= (S3(ii).E - (ERX*beacon_length));
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialization of dead, alive nodes to be used to view simulation results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag_first_dead_t=0;
flag_twenty_dead_t=0;
flag_half_dead_t=0;
flag_all_dead_t=0;

first_dead_t=0;
twenty_dead_t=0;
half_dead_t=0;
all_dead_t=0;

dead_t = 0;



dead1 = 0;
dead2 = 0;
dead3 = 0;
dead4 = 0;

% variables ending with 1, 2, 3, 4 region A,B,C and D respectively




allive1 = 25;
allive2 = 25;
allive3 = 25;
allive4 = 25;

send_to_sink1=0;
send_to_sink2=0;
send_to_sink3=0;
send_to_sink4=0;


%counter for bit transmitted to Base Station
packets_to_bs1 = 0;
packets_to_bs2 = 0;
packets_to_bs3 = 0;
packets_to_bs4 = 0;

distance_to_bs1 = 0;
distance_to_bs2 = 0;
distance_to_bs3 = 0;
distance_to_bs4 = 0;

% RENERGY1 = zeros(1,rmax+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation rounds start here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 for ii=1:node_number
        S3(ii).status = 'U';
      
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    A = zeros(1,25); %inserting  region A nodes in into array A

    for ii=1:1:25
        if S3(ii).E > 0
            A(1)=ii;    
            break;
        end
    end
    
    for ii=2:25
        for j=(A(ii-1)+1):25,
            if S3(j).E>0
                A(ii)=j;  
                break;
            end
        end
    end
    

 
 
    B = zeros(1,25); %inserting  region B nodes in into array B

    for ii=26:1:50
        if S3(ii).E > 0
            B(1)=ii;
            break;
        end
    end
    
    for ii=2:25
        for j=(B(ii-1)+1):50,
            if S3(j).E > 0
                B(ii)=j;
                break;
            end
        end
    end
 

    
   
  C = zeros(1,25); %inserting  region C nodes in into array C

    for ii=51:1:75
        if S3(ii).E > 0
            C(1)=ii;
            break;
        end
    end
    
    for ii=2:25
        for j=(C(ii-1)+1):75,
            if S3(j).E>0
                C(ii)=j;
                break;
            end
        end
    end
    
 
 

    D = zeros(1,25); %inserting  region D nodes in into array D

    for ii=76:1:100
        if S3(ii).E>0
            D(1)=ii;
            break;
        end
    end
    
    for ii=2:25
        for j=(D(ii-1)+1):100,
            if S3(j).E>0
                D(ii)=j;
                break;
            end
        end
    end
    
 
    


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %declare variables and array to be used to establish farthest node from
    %the base staion, then use greedy algorithm to discover neighbour node.
    %This will be used to pair the nodes using the distance SENSING RANGE threshold
    %criteria
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    region_A_distance = zeros(1,25);
    region_A_max_distance = 0;
    region_A_max_node = 0;
   
    region_B_distance = zeros(1,25);
    region_B_max_distance = 0;
    region_B_max_node = 0;
    
    region_C_distance = zeros(1,25);
    region_C_max_distance= 0;
    region_C_max_node = 0;
    
    region_D_distance = zeros(1,25);
    region_D_max_distance = 0;
    region_D_max_node = 0;
 
  
    for ii = 1:25              %obatin farthest node in region A
        S3(A(ii)).region_A_distance  =  sqrt((S3(A(ii)).xd)^2+(S3(A(ii)).yd)^2);
        if region_A_max_distance <  S3(A(ii)).region_A_distance
           region_A_max_distance = S3(A(ii)).region_A_distance;        %%%%
           region_A_max_node =(A(ii));
        end
    end
    for ii=1:25                 %obatin farthest node in region B
        S3(B(ii)).region_B_distance = sqrt((S3(B(ii)).xd)^2+(S3(B(ii)).yd)^2);
        if  region_B_max_distance <  S3(B(ii)).region_B_distance
            region_B_max_distance =  S3(B(ii)).region_B_distance;              %%%%
            region_B_max_node = (B(ii));
        end
    end
    for ii=1:25           %obatin farthest node in region C
        S3(C(ii)).region_C_distance  =  sqrt((S3(C(ii)).xd)^2+(S3(C(ii)).yd)^2);
        if  region_C_max_distance   <     S3(C(ii)).region_C_distance
            region_C_max_distance   =     S3(C(ii)).region_C_distance ;    
            region_C_max_node     = (C(ii));
        end
    end
    for ii=1:25              %obatin farthest node in region D
        S3(D(ii)).region_D_distance  = sqrt((S3(D(ii)).xd)^2+(S3(D(ii)).yd)^2);
        if region_D_max_distance  <  S3(D(ii)).region_D_distance
           region_D_max_distance  =  S3(D(ii)).region_D_distance;  
           region_D_max_node      =  (D(ii));
        end
    end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %This section introduces the Greedy algorithm, Where nodes find closest neighbors, but later node pairing will be executed basing on distance threshold and sensing range 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    connect_distance1 = zeros(1,25);    %this array will hold the distance between all the nodes
    connect_node1     =  zeros(1,25 );        %this array will hold the set of connected nodes according to closest distance between all the nodes
    connect_node1(1)  =  region_A_max_node;                %Pairing of the nodes starts from the farthest node
    connect_distance1(1) = 0;                    %distance to connect to the first node is 0.

% countpaired_A = 0; 

id_a = 1;
for ii = 2:25    
        temp_node1 = 0;
        temp_min_distance1 = inf;
        for j = 1:25 
            b1=0;
            for k = 1:(ii-1)
                if A(j) == connect_node1(k)
                    b1=1;
                    break;
                end
            end
            if b1==0                                                
              
               region_A_distance = sqrt((S3(connect_node1(ii-1)).xd - S3(A(j)).xd)^2 + (S3(connect_node1(ii-1)).yd - S3(A(j)).yd)^2);
                if temp_min_distance1 > region_A_distance
                   temp_min_distance1 = region_A_distance;
                   temp_node1=A(j);
                end
            end
        end
        
        connect_distance1(ii) = temp_min_distance1;
        connect_node1(ii) = temp_node1;
      
     % plot([S3(connect_node1(ii-1)).xd S3(connect_node1(ii)).xd],[S3(connect_node1(ii-1)).yd S3(connect_node1(ii)).yd],'-o');
       % hold on; 

         
                      if S3( connect_node1(ii-1)).status ==  'P'                 % 'P' = Paired        
                                    %S3( connect_node1(ii)).status = 'U';                 % 'U' = UnPaired
                             
                                 continue;
                      else 
                                     
                                       if connect_distance1(ii) <=  Range
                                               S3( connect_node1(ii)).status =  'P';
                                               S3( connect_node1(ii-1)).status =  'P'; 
                                               
                                                S3( connect_node1(ii)).id = id_a;
                                                S3( connect_node1(ii-1)).id = id_a;
                                               
                                               
                                               
%                                                 countpaired_A = countpaired_A + 1;
                                      
                                                id_a = id_a + 1;
%                                  plot([S3(connect_node1(ii-1)).xd S3(connect_node1(ii)).xd],[S3(connect_node1(ii-1)).yd S3(connect_node1(ii)).yd],'-ro');
%                                  
%                                  
%                                  hold on;
%                                   xlabel('X-Coordinate(m)','FontSize',10);
%                                   ylabel('Y-Coordinate(m)','FontSize',10);     
                                       
                                       
                                end
                
                      %PLOT HERE
                                
                  
                      end
                            
                        
                     
end                           
% countunpaired_A = 0;
for ii= 1 :1:25
              if S3(connect_node1(ii)).status == 'U'
                   
                   
                   S3(connect_node1(ii)).mode = 'A';
%  
%                           plot(S3(connect_node1(ii)).xd, S3(connect_node1(ii)).yd,'ro');
%                           hold on;
%                    countunpaired_A = countunpaired_A + 1;
               end

    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


connect_distance2 = zeros(1,25);    %this array will hold the distance between all the nodes
connect_node2 =  zeros(1,25);        %this array will hold the set of connected nodes according to closest distance between all the nodes
connect_node2(1) =  region_B_max_node;               
connect_distance2(1) = 0;                   
 %By use of greedy algorithm discover closest neighbour in region B  



% countpaired_B = 0;
id_b = 1;
for ii=2:25       %
        temp_node2=0;
        temp_min_distance2=inf;
        for j=1:25
            b2=0;
            for k=1:(ii-1)
                if B(j)==connect_node2(k)
                    b2=1;
                    break;
                end
            end
            if b2==0                                                 %%finding the nearest node for any node not connected 
             
               region_B_distance = sqrt((S3(connect_node2(ii-1)).xd - S3(B(j)).xd)^2 + (S3(connect_node2(ii-1)).yd - S3(B(j)).yd)^2);
                if temp_min_distance2 > region_B_distance
                    temp_min_distance2 = region_B_distance;
                    temp_node2 = B(j);
                end
            end
        end
        
        connect_distance2(ii) = temp_min_distance2;
        connect_node2(ii) = temp_node2;
        
            
             if S3( connect_node2(ii-1)).status ==  'P'
                           %S3( connect_node2(ii)).status =  'U'        
                             
                                 continue;
                                 
                        else 
                                  
                                    if connect_distance2(ii) <=  Range 
                                    
                          
                                           S3( connect_node2(ii)).status =  'P';
                                           S3( connect_node2(ii-1)).status =  'P'; 
                                     
                                                              S3( connect_node2(ii)).id = id_b;
                                                              S3( connect_node2(ii-1)).id = id_b;
                                           
                                           id_b = id_b+1;
%                                            
%                                             countpaired_B = countpaired_B + 1;
                                      
%                                       
%                                       plot([S3(connect_node2(ii-1)).xd S3(connect_node2(ii)).xd],[S3(connect_node2(ii-1)).yd S3(connect_node2(ii)).yd],'-go');
%                                       hold on;
                                   
                                 
%      
                                    end
                
                   
                                
                
             end
                 
% %                         
                          
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% countunpaired_B = 0;
for ii= 1 :1:25
               if (S3(connect_node2(ii)).status == 'U' )
                   
                   S3(connect_node2(ii)).mode = 'A';
 
%                         plot(S3(connect_node2(ii)).xd, S3(connect_node2(ii)).yd,'go');
%                         hold on;
%                    countunpaired_B = countunpaired_B + 1;
               end

    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

connect_distance3 = zeros(1,25);    %this array will hold the distance between all the nodes
connect_node3 =  zeros(1,25);        %this array will hold the set of connected nodes according to closest distance between all the nodes
connect_node3(1) =  region_C_max_node;                
connect_distance3(1) = 0;                    %distance to connect to the first node( region_C_max_node) is 0.

% countpaired_C = 0;
id_c = 1;
for ii=2:25    
        temp_node3 = 0;
        temp_min_distance3 = inf;
        for j=1:25
            b3=0;
            for k=1:(ii-1)
                if C(j)==connect_node3(k)
                    b3=1;
                    break;
                end
            end
            if b3==0                                                 %%finding the nearest node for any node not connected in chain
             
               region_C_distance = sqrt((S3(connect_node3(ii-1)).xd - S3(C(j)).xd)^2 + (S3(connect_node3(ii-1)).yd - S3(C(j)).yd)^2);
                if temp_min_distance3 > region_C_distance
                    temp_min_distance3 = region_C_distance;
                    temp_node3  = C(j);
                end
            end
        end
        
        connect_distance3(ii)=temp_min_distance3;
        connect_node3(ii)=temp_node3;
     
                      
               if S3( connect_node3(ii-1)).status ==  'P'
                                    
                            % S3( connect_node3(ii-1)).status =  'U'
                                 continue;
                              else
                                  
                                   if connect_distance3(ii) <=  Range
                                  
                              
                                      S3( connect_node3(ii)).status =  'P';
                                      S3( connect_node3(ii-1)).status =  'P'; 
                                     
                                                          S3( connect_node3(ii)).id = id_c;
                                                          S3( connect_node3(ii-1)).id = id_c;
                                      
                                                         id_c = id_c + 1;
                                      

                                   

%                                       plot([S3(connect_node3(ii-1)).xd S3(connect_node3(ii)).xd],[S3(connect_node3(ii-1)).yd S3(connect_node3(ii)).yd],'-mo');
%                                       hold on;
                                 
                                   

%                         
%      
                                  end
                
                   
                                
                     
               end
                   
              
                              
                  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% countunpaired_C = 0;
for ii= 1 :1: 25
               if (S3(connect_node3(ii)).status == 'U' )
                   
                   S3(connect_node3(ii)).mode = 'A';
 
%                         plot(S3(connect_node3(ii)).xd, S3(connect_node3(ii)).yd,'mo');
%                         hold on;
%                    countunpaired_C = countunpaired_C + 1;
               end

    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    connect_distance4 = zeros(1,25 );    %this array will hold the distance between all the nodes
    connect_node4 =  zeros(1,25 );         
    connect_node4(1) =  region_D_max_node;                
    connect_distance4(1) = 0;                    
    %count = 1

% countpaired_D = 0;

id_d = 0;
for ii=2:25   
        temp_node4=0;
        temp_min_distance4=inf;
        for j=1:25
            b4=0;
            for k=1:(ii-1)
                if D(j)==connect_node4(k)
                    b4=1;
                    break;
                end
            end
            if b4 ==0                                          
              
               region_D_distance = sqrt((S3(connect_node4(ii-1)).xd - S3(D(j)).xd)^2 + (S3(connect_node4(ii-1)).yd - S3(D(j)).yd)^2);
                if temp_min_distance4 > region_D_distance
                    temp_min_distance4 = region_D_distance;
                    temp_node4 = D(j);
                end
            end
        end
        
        connect_distance4(ii)=temp_min_distance4;
        connect_node4(ii)=temp_node4;

       % plot([S3(connect_node4(ii-1)).xd S3(connect_node4(ii)).xd],[S3(connect_node4(ii-1)).yd S3(connect_node4(ii)).yd],'-o');
       % hold on;
         
                   if S3( connect_node4(ii-1)).status ==  'P'
                                   %S3( connect_node4(ii-1)).status =  'U'
                             
                                 continue;
                                 
                                 
                   else
                              if connect_distance4(ii) <=  Range    
                             
                                           S3( connect_node4(ii)).status =  'P';
                                           S3( connect_node4(ii-1)).status =  'P'; 
                                     
                                             S3( connect_node4(ii)).id = id_d
                                             S3( connect_node4(ii-1)).id = id_d
                                           
                                           id_d = id_d + 1;
                                           
                                           
%                                            countpaired_D = countpaired_D + 1;
                                   
                                      
 
                                  
                                 
%                                  plot([S3(connect_node4(ii-1)).xd S3(connect_node4(ii)).xd],[S3(connect_node4(ii-1)).yd S3(connect_node4(ii)).yd],'-bo');
%                                   hold on;

%                         
     
                              end
                
                   
                                
              
                   end
                   
                            
end 
      

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                
% countunpaired_D = 0;
for ii= 1 :1:25
               if (S3(connect_node4(ii)).status == 'U' )
                   
                   S3(connect_node4(ii)).mode = 'A';
%  
%                      plot(S3(connect_node4(ii)).xd, S3(connect_node4(ii)).yd,'bo');
%                       hold on;
%                    countunpaired_D = countunpaired_D + 1;
               end

    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for r = 0:rmax     
    r
  
   
    dead_t = 0;
    energy1(r+1)=0;

    
dead1 = 0;
dead2 = 0;
dead3 = 0;
dead4 = 0;
    
% packets_to_bs1 = 0;
% packets_to_bs2 = 0;
% packets_to_bs3 = 0;
% packets_to_bs4 = 0;

for ii = 1:node_number
    
    if (S3(ii).E <= 0)
            
            dead_t = dead_t+1;
             %Establish when 1% of the nodes die
            if (dead_t == 1)
                if(flag_first_dead_t==0)
                    first_dead_t = r+1;
                    flag_first_dead_t=1;
                end
            end
               %Establish when 20% of the nodes die
            if(dead_t == 0.2*node_number)
                if(flag_twenty_dead_t==0)
                   twenty_dead_t = r+1;
                    flag_twenty_dead_t=1;
                end
            end
            %Establish when 50% of the nodes die
            if(dead_t == 0.5*node_number)
                if(flag_half_dead_t==0)
                    half_dead_t = r+1;
                    flag_half_dead_t=1;
                end
            end
            if(dead_t==node_number)
                if(flag_all_dead_t==0)
                    all_dead_t = r+1;
                    flag_all_dead_t=1;
                end
            end
    else 
        energy1(r+1)=energy1(r+1)+S3(ii).E; 
    end
    
end


    for ii=1:1:25               
        if (S3(ii).E <= 0)
            dead1 = dead1+1;
            
        end
    end
    for ii=26:1:50                          
        if (S3(ii).E <= 0)
            dead2=dead2+1;
            
        end
    end
    for ii=51:1:75
        if (S3(ii).E<=0)
            dead3 = dead3+1;
            
        end
    end
    for ii=76:1:100            
        if (S3(ii).E <= 0)
            dead4=dead4+1;
           
        end
    end
    STATISTICS3(r+1).ALLIVE1 = allive1 - dead1;      %In this round, these are the remaining  alive nodes in region A
                          
    STATISTICS3(r+1).ALLIVE2 = allive2 - dead2;        %In this round, these are the remaining  alive nodes in region B
                          
    STATISTICS3(r+1).ALLIVE3 = allive3 - dead3;        %In this round, these are the remaining  alive nodes in region C
                        
    STATISTICS3(r+1).ALLIVE4 = allive4 - dead4;        %In this round, these are the remaining  alive nodes in region D
                       
    
    STATISTICS3(r+1).DEAD5  =  dead1+dead2+dead3+dead4;  %(total number of dead nodes after a round)
 
    STATISTICS3(r+1).ALLIVE5 = (STATISTICS3(r+1).ALLIVE1+STATISTICS3(r+1).ALLIVE2+STATISTICS3(r+1).ALLIVE3+STATISTICS3(r+1).ALLIVE4);%total number of all allive nodes in a round from all the regions
    


 for ii = 2 : 25
       
     if (S3(connect_node1(ii)).status == 'P')
             % if (S3(ActiveNodeListSet_A(ii)).status == 'P')
         if S3(connect_node1(ii-1)).id == S3(connect_node1(ii)).id
            
      
                                    
                                      if  S3(connect_node1(ii-1)).E >= 0.05 && S3(connect_node1(ii)).E >= 0.05
                                          
                                                S3(connect_node1(ii-1)).mode =  'A';  
                                                  S3(connect_node1(ii)).mode =  'S'; 
                                            
                                              
                                             elseif S3(connect_node1(ii-1)).E < 0.05 && S3(connect_node1(ii)).E >= 0.05
                                          
                                                S3(connect_node1(ii-1)).mode =  'S';  
                                                S3(connect_node1(ii)).mode =  'A'; 
                                            
                                                
                                             else  
                                                 if S3(connect_node1(ii-1)).E< 0.05 && S3(connect_node1(ii)).E  < 0.05
                                              
                                                        if S3(connect_node1(ii-1)).E > S3(connect_node1(ii)).E
                                                            
                                                            if S3(connect_node1(ii-1)).E > 0
                                                              S3(connect_node1(ii-1)).mode =  'A';  
                                                              S3(connect_node1(ii)).mode =  'S'; 
                                                            end
                                                        else
                                                              if S3(connect_node1(ii)).E > 0
                                                              S3(connect_node1(ii-1)).mode =  'S';  
                                                              S3(connect_node1(ii)).mode =  'A';
                                                              end
                                                        end
                                                 end  
             
                                      end
        end  
     
    end
end 
 
 
 
  x=[50,50];
  y=[0,100];
  plot(x,y , 'k-')
  hold on;
% % 
  x=[0,100];
  y=[50,50];
 plot(x,y , 'k-')
 hold on;









count1 = 0;
%if STATISTICS3(r+1).ALLIVE1~= 0
for ii= 1: 25
      if (S3(connect_node1(ii)).E > 0)
               if (S3(connect_node1(ii)).mode == 'A')
          
                count1 =  count1 + 1;
               end
      end
    
end
ActiveNodeList_A =  count1 ;
ActiveNodeListSet_A = zeros(1,ActiveNodeList_A );


a1 = 1;
for ii= 1: 25
      if (S3(connect_node1(ii)).E > 0)
               if (S3(connect_node1(ii)).mode == 'A')
                ActiveNodeListSet_A(a1)= (connect_node1(ii));
                a1 = a1+1;
               end
      end
    
end


  Q_max_A=0;
  %send_to_sink1=0;
  L_node1 = send_to_sink1;
    for ii=1:ActiveNodeList_A 
        
    
           if (S3(ActiveNodeListSet_A(ii)).status == 'P')
               
         
     
          distance_to_bs(ActiveNodeListSet_A(ii)) = sqrt((S3(ActiveNodeListSet_A(ii)).xd-Bx)^2+(S3(ActiveNodeListSet_A(ii)).yd-By)^2);%%
          S3(ActiveNodeListSet_A(ii)).Q = S3(ActiveNodeListSet_A(ii)).E/distance_to_bs(ActiveNodeListSet_A(ii));%%ratio between the energy and distance of each node to BS
          if  Q_max_A < S3(ActiveNodeListSet_A(ii)).Q
              Q_max_A = S3(ActiveNodeListSet_A(ii)).Q;
              L_node1= ActiveNodeListSet_A(ii);%finding most optimal leader with highest weight
          end
          end
      
   end
  send_to_sink1 = L_node1;
  %disp(send_to_sink1);
for ii= 1:ActiveNodeList_A      %Establish adjacency matrix,A1, the associated cost(distance) of the unweighted graph problem

  
         for j=1:ActiveNodeList_A
            
              region_A1_distance = sqrt((S3(ActiveNodeListSet_A(ii)).xd - S3(ActiveNodeListSet_A(j)).xd)^2 + (S3(ActiveNodeListSet_A(ii)).yd - S3(ActiveNodeListSet_A(j)).yd)^2);
           
             
              A1(ii,j) = region_A1_distance;
             
              %keep track of the index of the nodes
              S3(ActiveNodeListSet_A(ii)).index_A = ii;
              S3(ActiveNodeListSet_A(j)).index_A = j; 
             
         end
  
end
%disp(A1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Minimum Spanning Tree Construction starts here. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ch = 0
k = 1;
N1 = ActiveNodeList_A - 1;
for ii = 1: ActiveNodeList_A
    if ActiveNodeListSet_A(ii) ==  send_to_sink1
        continue;
    else
        
       not_in_tree1(k) = ActiveNodeListSet_A(ii);
       k = k + 1;
        
    end
end
not_in_tree1 = not_in_tree1(:);  %not_in_tree holds the set of nodes not yet included in the tree


%  for ii = 1: N1
%       
%      disp(S3(not_in_tree(ii)).index_A);
%      fprintf('\n');
%  
%  end
[number1,number1] = size(A1);
intree1 = [send_to_sink1];  %send_to_sink1 is the root node, so it is the first node in the tree
number_in_tree1 = 1; 
number_of_edges1 = 1;


while number_in_tree1 < number1,
mincost1 = Inf;                            
  for i=1:number_in_tree1,               
    
	for j=1:N1,
	
        %ii = intree(i); 
        
        ii = S3(intree1(i)).index_A;

	    jj = S3(not_in_tree1(j)).index_A;
        
        
      
	    if A1(ii,jj) < mincost1, 
	  
        mincost1 = A1(ii,jj); 
		
		b =  A1(ii,jj); 
		jsave1 = j; 
		
		iisave1 = intree1(i);
		jjsave1 = not_in_tree1(j);  
        end;
   end;
end;
  distance1(number_of_edges1)= b;
  parent1(number_of_edges1) = iisave1;
  child1(number_of_edges1)  = jjsave1;
  
  S3(iisave1).child = ch + 1

  number_of_edges1 = number_of_edges1 + 1;   
  number_in_tree1 = number_in_tree1 + 1; 
  
  intree1 = [intree1; jjsave1];   
  
 for j = jsave1 + 1  :   N1,    %basically remove the node from the list of nodes not yet in the tree
     
       not_in_tree1(j-1) =  not_in_tree1(j);

end;
N1 = N1 - 1;  

end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for g=1:number_of_edges1 - 1
% % % % % % % 
% % % % % % % 
%        plot([S3(parent1(g)).xd S3(child1(g)).xd],[S3(parent1(g)).yd S3(child1(g)).yd],'-ko');
%        xlabel('X-Coordinate(m)','FontSize',10);
%        ylabel('Y-Coordinate(m)','FontSize',10);
%        hold on;  
% % %       if S3(parent1(g)) == send_to_sink1
% % %        plot(S3(parent1(g)).xd,S3(parent1(g)).xd,'bo')
% % %         hold on;
% %     
% end  
 
 
 
 
distance_to_bs1 = sqrt((S3(send_to_sink1).xd-Bx)^2+(S3(send_to_sink1).yd-By)^2);
if S3(send_to_sink1).E > 0
           if ((distance_to_bs1)> do)
            S3(send_to_sink1).E = S3(send_to_sink1).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*((distance_to_bs1)*(distance_to_bs1)*(distance_to_bs1)*(distance_to_bs1) )); 
               S3(send_to_sink1).E = S3(send_to_sink1).E - (ERX*data_length) ; 
           else 
            S3(send_to_sink1).E = S3(send_to_sink1).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*((distance_to_bs1)*(distance_to_bs1) )); 
            S3(send_to_sink1).E = S3(send_to_sink1).E - (ERX*data_length) ; 
           end
     %packets_to_bs1 =  packets_to_bs1+ 1;  % count packet if received by base station
end 


for g=1:number_of_edges1-1 % All other nodes in the tree dissipate this energy 
 if S3(child1(g)).E > 0
    if (distance1(g)> do)

            S3(child1(g)).E=S3(child1(g)).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*( distance1(g)*distance1(g)*distance1(g)*distance1(g) ));  
             S3(child1(g)).E  = S3(child1(g)).E - (ERX*data_length) ; 
           else 
            S3(child1(g)).E= S3(child1(g)).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*( distance1(g)*distance1(g) ));  
            S3(child1(g)).E  = S3(child1(g)).E - (ERX*data_length) ;
    end
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Region A ends Introduction of region  B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 for ii = 2 : 25
       
    if S3(connect_node2(ii)).status == 'P'
     
       
        if S3(connect_node2(ii-1)).id == S3(connect_node2(ii)).id
            
           
                                    
                                          if  S3(connect_node2(ii-1)).E >= 0.05 && S3(connect_node2(ii)).E >= 0.05
                                         
                                                S3(connect_node2(ii-1)).mode =  'A';  
                                                  S3(connect_node2(ii)).mode =  'S'; 
                                              
                                              
                                             elseif S3(connect_node2(ii-1)).E < 0.05&& S3(connect_node2(ii)).E >= 0.05
                                               
                                                S3(connect_node2(ii-1)).mode =  'S';  
                                                S3(connect_node2(ii)).mode =  'A'; 
                                             
                                                
                                             else  
                                                 if S3(connect_node2(ii-1)).E< 0.05&& S3(connect_node2(ii)).E  < 0.05
                                              
                                                        if S3(connect_node2(ii-1)).E > S3(connect_node2(ii)).E
                                                             if S3(connect_node2(ii-1)).E > 0
                                                             S3(connect_node2(ii-1)).mode =  'A';  
                                                              S3(connect_node2(ii)).mode =  'S'; 
                                                             end
                                                        else
                                                              if S3(connect_node2(ii)).E > 0
                                                              S3(connect_node2(ii-1)).mode =  'S';  
                                                              S3(connect_node2(ii)).mode =  'A';
                                                              end
                                                        end
                                                 end  
             
                                          end
        end  
     
     
     
   end

 end
count2 = 0;

for ii= 1: 25
      if (S3(connect_node2(ii)).E > 0)
               if (S3(connect_node2(ii)).mode == 'A')
                count2 =  count2 + 1;
               end
      end
    
end
ActiveNodeList_B=  count2 ;
ActiveNodeListSet_B = zeros(1,ActiveNodeList_B );

m2 = 1;
for ii= 1: 25
      if (S3(connect_node2(ii)).E > 0)
               if (S3(connect_node2(ii)).mode == 'A')
                ActiveNodeListSet_B(m2)= (connect_node2(ii));
               m2 =m2 + 1;
               end
      end
    
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Establish cluster head for region B, criteria: ResidualEnergy(i)/d(i,sink) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
Q_max_B=0;
   %send_to_sink2=0;
   L_node2=send_to_sink2;     
   for ii=1:ActiveNodeList_B 
       
  
         if (S3(ActiveNodeListSet_B(ii)).status == 'P')
       
         distance_to_bs(ActiveNodeListSet_B(ii))=sqrt((S3(ActiveNodeListSet_B(ii)).xd-Bx)^2+(S3(ActiveNodeListSet_B(ii)).yd-By)^2);%%
         S3(ActiveNodeListSet_B(ii)).Q = S3(ActiveNodeListSet_B(ii)).E/distance_to_bs(ActiveNodeListSet_B(ii));%%ratio between the energy and distance of each node to BS
         if  Q_max_B < S3(ActiveNodeListSet_B(ii)).Q
             Q_max_B = S3(ActiveNodeListSet_B(ii)).Q;
             L_node2 = ActiveNodeListSet_B(ii);
         end
         end
   
  end
  send_to_sink2 = L_node2;
 % disp(send_to_sink2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii= 1:ActiveNodeList_B      %Establish adjacency matrix,A1, the associated cost of the unweighted graph problem
  

         for j=1:ActiveNodeList_B
                
              region_B1_distance = sqrt((S3(ActiveNodeListSet_B(ii)).xd - S3(ActiveNodeListSet_B(j)).xd)^2 + (S3(ActiveNodeListSet_B(ii)).yd - S3(ActiveNodeListSet_B(j)).yd)^2);
           
             
              B1(ii,j) = region_B1_distance;
             
              %keep track of the index of the nodes
              S3(ActiveNodeListSet_B(ii)).index_B = ii;
              S3(ActiveNodeListSet_B(j)).index_B = j; 
               
         end
  
end
%disp(B1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Minimum Spanning Tree Construction starts here. First establish Adjacency
% matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k2 = 1;
N2 = ActiveNodeList_B - 1;
for ii = 1: ActiveNodeList_B
    if ActiveNodeListSet_B(ii) ==  send_to_sink2
        continue;
    else
       
       not_in_tree2(k2) = ActiveNodeListSet_B(ii);
       k2 = k2 + 1;
       
    end
end
not_in_tree2 = not_in_tree2(:);  %not_in_tree holds the set of nodes not yet included in the tree


%  for ii = 1: N1
%       
%      disp(S3(not_in_tree(ii)).index_A);
%      fprintf('\n');
%  
%  end
[number2,number2] = size(B1);
intree2 = [send_to_sink2];  
number_in_tree2 = 1; 
number_of_edges2 = 1;


while number_in_tree2 < number2,
mincost2 = Inf;                            
 for i=1:number_in_tree2,               
    
  for j=1:N2,
	
        %ii = intree(i); 
        
        ii = S3(intree2(i)).index_B;

	    jj = S3(not_in_tree2(j)).index_B;
        
        
      
	   if B1(ii,jj) < mincost2, 
	  
           mincost2 = B1(ii,jj); 
		
		   b =  B1(ii,jj); 
		   jsave2 = j; 
		
		   iisave2 = intree2(i);
		   jjsave2 = not_in_tree2(j);  
        end;
   end;
end;
  distance2(number_of_edges2)= b;
  parent2(number_of_edges2) = iisave2;
  child2(number_of_edges2)  = jjsave2;

  number_of_edges2 = number_of_edges2 + 1;   
  number_in_tree2 = number_in_tree2 + 1; 
  
  intree2 = [intree2; jjsave2];   
  
 for j = jsave2 + 1  :   N2,   
     
       not_in_tree2(j-1) =  not_in_tree2(j);

end;
N2 = N2 - 1;  

end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      for g=1:number_of_edges2 - 1
% % % % % % % 
% % % % % % % 
%        plot([S3(parent2(g)).xd S3(child2(g)).xd],[S3(parent2(g)).yd S3(child2(g)).yd],'-ko');
%        hold on;    
%      end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculate dissipated energy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distance_to_bs2 = sqrt((S3(send_to_sink2).xd-Bx)^2+(S3(send_to_sink2).yd-By)^2);
if S3(send_to_sink2).E > 0
            if ((distance_to_bs2)> do)
            S3(send_to_sink2).E=S3(send_to_sink2).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*((distance_to_bs2)*(distance_to_bs2)*(distance_to_bs2)*(distance_to_bs2) )); 
             S3(send_to_sink2).E  =  S3(send_to_sink2).E - (ERX*data_length) ; 
            else 
            S3(send_to_sink2).E= S3(send_to_sink2).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*((distance_to_bs2)*(distance_to_bs2))); 
             S3(send_to_sink2).E  =  S3(send_to_sink2).E - (ERX*data_length) ;
            end
        % packets_to_bs2 =  packets_to_bs2 + 1;
end 
for g=1:number_of_edges2-1
    
 if S3(child2(g)).E > 0
    if (distance2(g)> do)
            S3(child2(g)).E = S3(child2(g)).E - ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*( distance2(g)*distance2(g)*distance2(g)*distance2(g) ));  
            S3(child2(g)).E  = S3(child2(g)).E - (ERX*data_length) ; 
           else 
            S3(child2(g)).E = S3(child2(g)).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*( distance2(g)*distance2(g))); 
            S3(child2(g)).E  = S3(child2(g)).E - (ERX*data_length) ;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End or region  B  Introduce region  C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 for ii = 2 : 25
     if S3(connect_node3(ii)).status == 'P'
     
       
        if S3(connect_node3(ii-1)).id == S3(connect_node3(ii)).id
            
         %if S3(ii-1).E > 0        
                                    
                                          if  S3(connect_node3(ii-1)).E >= 0.05 && S3(connect_node3(ii)).E >= 0.05
                                          
                                                S3(connect_node3(ii-1)).mode =  'A';  
                                                  S3(connect_node3(ii)).mode =  'S'; 
                                              
                                              
                                             elseif S3(connect_node3(ii-1)).E < 0.05&& S3(connect_node3(ii)).E >= 0.05
                                             
                                                S3(connect_node3(ii-1)).mode =  'S';  
                                                S3(connect_node3(ii)).mode =  'A'; 
                                             
                                                
                                             else  
                                                 if S3(connect_node3(ii-1)).E< 0.05&& S3(connect_node3(ii)).E  < 0.05
                                              
                                                        if S3(connect_node3(ii-1)).E > S3(connect_node2(ii)).E
                                                            if S3(connect_node3(ii-1)).E > 0
                                                             S3(connect_node3(ii-1)).mode =  'A';  
                                                              S3(connect_node3(ii)).mode =  'S'; 
                                                            end
                                                        else
                                                               if S3(connect_node3(ii)).E > 0
                                                              S3(connect_node3(ii-1)).mode =  'S';  
                                                              S3(connect_node3(ii)).mode =  'A';
                                                               end
                                                        end
                                                end  
             
         end
     end  
     
     
     
 end

 end




count3 = 0;
%if STATISTICS3(r+1).ALLIVE1~= 0
for ii= 1: 25
      if (S3(connect_node3(ii)).E > 0)
               if (S3(connect_node3(ii)).mode == 'A')
                count3 =  count3 + 1;
               end
      end
    
end
ActiveNodeList_C =  count3 ;
ActiveNodeListSet_C = zeros(1,ActiveNodeList_C);



v = 1;
for ii= 1:25
      if (S3(connect_node3(ii)).E > 0)
               if (S3(connect_node3(ii)).mode == 'A')
                ActiveNodeListSet_C(v)= (connect_node3(ii));
               v = v+1;
               end
      end
    
end
%disp(ActiveNodeListSet_C);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Establish Cluster head for region 3 or C
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 Q_max_C = 0;
 L_node3 = send_to_sink3;
   for ii=1:ActiveNodeList_C %%chain leader selection
     
       if (S3(ActiveNodeListSet_C(ii)).status == 'P')
       
         distance_to_bs(ActiveNodeListSet_C(ii))=sqrt((S3(ActiveNodeListSet_C(ii)).xd-Bx)^2+(S3(ActiveNodeListSet_C(ii)).yd-By)^2);%%
         S3(ActiveNodeListSet_C(ii)).Q = S3(ActiveNodeListSet_C(ii)).E/distance_to_bs(ActiveNodeListSet_C(ii));%%ratio between the energy and distance of each node to BS
         if  Q_max_C < S3(ActiveNodeListSet_C(ii)).Q
             Q_max_C = S3(ActiveNodeListSet_C(ii)).Q;
             L_node3= ActiveNodeListSet_C(ii);
         end
        end
       
  end
  send_to_sink3=L_node3;
  %disp(send_to_sink3);
  
for ii= 1:ActiveNodeList_C      %Establish adjacency matrix,A1, the associated cost of the unweighted graph problem

  
         for j=1:ActiveNodeList_C
        
              region_C1_distance = sqrt((S3(ActiveNodeListSet_C(ii)).xd - S3(ActiveNodeListSet_C(j)).xd)^2 + (S3(ActiveNodeListSet_C(ii)).yd - S3(ActiveNodeListSet_C(j)).yd)^2);
           
             
              C1(ii,j) = region_C1_distance;
             
              %keep track of the index of the nodes
              S3(ActiveNodeListSet_C(ii)).index_C = ii;
              S3(ActiveNodeListSet_C(j)).index_C = j; 
          
         end

end
%disp(C1);


k3 = 1;
N3 = ActiveNodeList_C - 1;
for ii = 1: ActiveNodeList_C
    if ActiveNodeListSet_C(ii) ==  send_to_sink3
        continue;
    else
      
       not_in_tree3(k3) = ActiveNodeListSet_C(ii);
       k3 = k3 + 1;
        
    end
end
not_in_tree3 = not_in_tree3(:);  %not_in_tree holds the set of nodes not yet included in the tree


%  for ii = 1: N1
%       
%      disp(S3(not_in_tree(ii)).index_A);
%      fprintf('\n');
%  
%  end
[number3,number3] = size(C1);
intree3 = [send_to_sink3];  
number_in_tree3 = 1; 
number_of_edges3 = 1;


while number_in_tree3 < number3,
mincost3 = Inf;                            
 for i=1:number_in_tree3,               
    
    for j=1:N3,
	
        %ii = intree(i); 
        
        ii = S3(intree3(i)).index_C;

	    jj = S3(not_in_tree3(j)).index_C;
        
        
      
	    if C1(ii,jj) < mincost3, 
	  
        mincost3 = C1(ii,jj); 
		
		b =  C1(ii,jj); 
		jsave3 = j; 
		
		iisave3 = intree3(i);
		jjsave3 = not_in_tree3(j);  
        end;
   end;
end;
  distance3(number_of_edges3)= b;
  parent3(number_of_edges3) = iisave3;
  child3(number_of_edges3)  = jjsave3;

  number_of_edges3 = number_of_edges3 + 1;   
  number_in_tree3 = number_in_tree3 + 1; 
  
  intree3 = [intree3; jjsave3];   
  
 for j = jsave3 + 1  :   N3,   
     
       not_in_tree3(j-1) =  not_in_tree3(j);

end;
N3 = N3 - 1;  

end;
%  for g=1:number_of_edges3 - 1
% % % % % % % 
% % % % % % % 
%       plot([S3(parent3(g)).xd S3(child3(g)).xd],[S3(parent3(g)).yd S3(child3(g)).yd],'-ko');
%       hold on;    
%  end 
distance_to_bs3 = sqrt((S3(send_to_sink3).xd-Bx)^2+(S3(send_to_sink3).yd-By)^2);
if S3(send_to_sink3).E > 0
           if ((distance_to_bs3)> do)
            S3(send_to_sink3).E=S3(send_to_sink3).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*((distance_to_bs3)*(distance_to_bs3)*(distance_to_bs3)*(distance_to_bs3) )); 
            S3(send_to_sink3).E = S3(send_to_sink3).E - (ERX*data_length); 
           else 
            S3(send_to_sink3).E= S3(send_to_sink3).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*((distance_to_bs3)*(distance_to_bs3) )); 
            S3(send_to_sink3).E = S3(send_to_sink3).E - (ERX*data_length);
           end
          %packets_to_bs3 =  packets_to_bs3 + 1;
end
for g=1:number_of_edges3-1
    
    if S3(child3(g)).E > 0
    if (distance3(g)> do)
            S3(child3(g)).E = S3(child3(g)).E-  ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*( distance3(g)*distance3(g)*distance3(g)*distance3(g) )); 
            S3(child3(g)).E  = S3(child3(g)).E - (ERX*data_length) ;
           else 
            S3(child3(g)).E = S3(child3(g)).E-  ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*( distance3(g)*distance3(g) )); 
            S3(child3(g)).E  = S3(child3(g)).E - (ERX*data_length) ;
    end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%End region 3 .Introduce region 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 for ii = 2 : 25
       
     if S3(connect_node4(ii)).status == 'P'
    
       
         if S3(connect_node4(ii-1)).id == S3(connect_node4(ii)).id
            
            
                                    
                                          if  S3(connect_node4(ii-1)).E >= 0.05 && S3(connect_node4(ii)).E >= 0.05
                                           
                                                S3(connect_node4(ii-1)).mode =  'A';  
                                                  S3(connect_node4(ii)).mode =  'S'; 
                                              
                                              
                                             elseif S3(connect_node4(ii-1)).E < 0.05 && S3(connect_node4(ii)).E >= 0.05
                                                
                                                S3(connect_node4(ii-1)).mode =  'S';  
                                                S3(connect_node4(ii)).mode =  'A'; 
                                            
                                                
                                             else  
                                                 if S3(connect_node4(ii-1)).E< 0.05&& S3(connect_node4(ii)).E  < 0.05
                                              
                                                        if S3(connect_node4(ii-1)).E > S3(connect_node2(ii)).E
                                                             if S3(connect_node4(ii-1)).E > 0
                                                             S3(connect_node4(ii-1)).mode =  'A';  
                                                              S3(connect_node4(ii)).mode =  'S'; 
                                                              end
                                                        else
                                                              if S3(connect_node4(ii)).E > 0
                                                              S3(connect_node4(ii-1)).mode =  'S';  
                                                             S3(connect_node4(ii)).mode =  'A';
                                                              end
                                                        end
                                                 end  
             
                                          end
          end  
     
     
     
      end

 end




count4 = 0;
%if STATISTICS3(r+1).ALLIVE1~= 0
for ii= 1: 25
      if (S3(connect_node4(ii)).E > 0)
               if (S3(connect_node4(ii)).mode == 'A')
                count4 =  count4 + 1;
               end
      end
    
end
ActiveNodeList_D =  count4 ;
ActiveNodeListSet_D = zeros(1,ActiveNodeList_D );



g = 1;
for ii= 1: 25
      if (S3(connect_node4(ii)).E > 0)
               if (S3(connect_node4(ii)).mode == 'A')
                ActiveNodeListSet_D(g)= (connect_node4(ii));
                g = g+1;
               end
      end
    
end

%disp(ActiveNodeListSet_D);                
   Q_max_D=0;
   L_node4=send_to_sink4;%temorary leader node
   for ii=1:ActiveNodeList_D %%chain leader selection
     
       if (S3(ActiveNodeListSet_D(ii)).status == 'P')
         distance_to_bs(ActiveNodeListSet_D(ii))=sqrt((S3(ActiveNodeListSet_D(ii)).xd-Bx)^2+(S3(ActiveNodeListSet_D(ii)).yd-By)^2);%%
         S3(ActiveNodeListSet_D(ii)).Q = S3(ActiveNodeListSet_D(ii)).E/distance_to_bs(ActiveNodeListSet_D(ii));%%ratio between the energy and distance of each node to BS
         if  Q_max_D < S3(ActiveNodeListSet_D(ii)).Q
             Q_max_D = S3(ActiveNodeListSet_D(ii)).Q;
             L_node4= ActiveNodeListSet_D(ii);%finding most optimal leader with highest weight
         end
       end
     
  end
  send_to_sink4=L_node4;
 %disp(send_to_sink4);
for ii= 1:ActiveNodeList_D      %Establish adjacency matrix,A1, the associated cost of the unweighted graph problem
   
  
         for j=1:ActiveNodeList_D
             
              region_D1_distance = sqrt((S3(ActiveNodeListSet_D(ii)).xd - S3(ActiveNodeListSet_D(j)).xd)^2 + (S3(ActiveNodeListSet_D(ii)).yd - S3(ActiveNodeListSet_D(j)).yd)^2);
           
             
              D1(ii,j) = region_D1_distance;
             
              %keep track of the index of the nodes
              S3(ActiveNodeListSet_D(ii)).index_D = ii;
              S3(ActiveNodeListSet_D(j)).index_D = j; 
           
         end

end
%disp(D1);


k4 = 1;
N4 = ActiveNodeList_D - 1;
for ii = 1: ActiveNodeList_D
    if ActiveNodeListSet_D(ii) ==  send_to_sink4
        continue;
    else
        
       
       not_in_tree4(k4) = ActiveNodeListSet_D(ii);
       k4 = k4 + 1;
    
    end
end
not_in_tree4 = not_in_tree4(:);  %not_in_tree holds the set of nodes not yet included in the tree


%  for ii = 1: N1
%       
%      disp(S3(not_in_tree(ii)).index_A);
%      fprintf('\n');
%  
%  end
[number4,number4] = size(D1);
intree4 = [send_to_sink4];  
number_in_tree4 = 1; 
number_of_edges4 = 1;


while number_in_tree4 < number4,
mincost4 = Inf;                            
 for i=1:number_in_tree4,               
    
   for j=1:N4,
	
        %ii = intree(i); 
        
        ii = S3(intree4(i)).index_D;

	    jj = S3(not_in_tree4(j)).index_D;
        
        
      
	    if  D1(ii,jj) < mincost4, 
	  
             mincost4 = D1(ii,jj); 
		
		     b =  D1(ii,jj); 
		     jsave4 = j; 
		
		     iisave4 = intree4(i);
		     jjsave4 = not_in_tree4(j);  
        end;
   end;
end;
  distance4(number_of_edges4)= b;
  parent4(number_of_edges4) = iisave4;
  child4(number_of_edges4)  = jjsave4;

  number_of_edges4 = number_of_edges4 + 1;   
  number_in_tree4 = number_in_tree4 + 1; 
  
  intree4 = [intree4; jjsave4];   
  
 for j = jsave4 + 1  :   N4,   
     
       not_in_tree4(j-1) =  not_in_tree4(j);

end;
N4 = N4 - 1;  

end;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ENERGY DISSIPATION CALCULATION in  region 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  for g=1:number_of_edges4 - 1
% % % % % % % 
% % % % % % % 
%       plot([S3(parent4(g)).xd S3(child4(g)).xd],[S3(parent4(g)).yd S3(child4(g)).yd],'-ko');
%       hold on;   
% % % %  %  disp(distance4(g) );
% % % %  %  disp(parent4(g) );
% % % % %   disp(child4(g) );
% % % % %  
% % % % %   
% % % % %   
% % % % %   
%   end 
distance_to_bs4 = sqrt((S3(send_to_sink4).xd-Bx)^2+(S3(send_to_sink4).yd-By)^2);
if  S3(send_to_sink4).E > 0
       if ((distance_to_bs4)> do)
    
            S3(send_to_sink4).E = S3(send_to_sink4).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*( distance_to_bs4*distance_to_bs4*distance_to_bs4*distance_to_bs4 )); 
            S3(send_to_sink4).E = S3(send_to_sink4).E - (ERX*data_length); 
           else 
            S3(send_to_sink4).E = S3(send_to_sink4).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*( distance_to_bs4*distance_to_bs4)); 
            S3(send_to_sink4).E = S3(send_to_sink4).E - (ERX*data_length);
       end
      %  packets_to_bs4 =  packets_to_bs4+ 1;
       
end
for g=1:number_of_edges4-1
if   S3(child4(g)).E > 0
    if (distance4(g)> do)
            S3(child4(g)).E = S3(child4(g)).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Eamp*( distance4(g)*distance4(g)*distance4(g)*distance4(g) )); 
            S3(child4(g)).E  = S3(child4(g)).E - (ERX*data_length) ;
           else 
            S3(child4(g)).E= S3(child4(g)).E- ((ETX+EDA)*(ctl_length)) + (ETX*data_length+ data_length*Efs*( distance4(g)*distance4(g))); 
            S3(child4(g)).E  = S3(child4(g)).E - (ERX*data_length) ;
    end
end
end

%plot([S3(source4(g)).xd S3(destination4(g)).xd],[S3(source4(g)).yd S3(destination4(g)).yd],'-go');
%hold on;   
  
%STATISTICS3(r+1).PACKETS_TO_BS = packets_to_bs1 + packets_to_bs2 + packets_to_bs3 + packets_to_bs4;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %simulation of pegasis starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for ii=1:1:node_number %nodes area wise distribution

        S(ii).xd=rand*100;    
        S(ii).yd=rand*100;
       % plot(S3(ii).xd,S3(ii).yd,'go') 
       % xlabel('x-axes(m)','FontSize',8);
       % ylabel('y-axes(m)','FontSize',8);
       % hold on
        S(ii).E=En;
       
end


allive_p = 100;
dead_p = 0;

flag_first_dead_p=0;
flag_twenty_dead_p=0;
flag_half_dead_p=0;
flag_all_dead_p=0;

first_dead_p=0;
twenty_dead_p=0;
half_dead_p=0;
all_dead_p=0;

dead_p1 = 0;



% RENERGY2 = zeros(1,rmax+1);
for r3=0:rmax     %  simulation round starts here
    r3
    
    
  packets_to_bs = 0;  
  dead_p = 0; 
  dead_p1 = 0; 
  energy2(r3+1)=0; 
%   
%     for ii=1:node_number
%         RENERGY2(r3+1) =RENERGY2(r3+1)+S(ii).E;
%     end

 
 for ii = 1 : node_number
    
    if (S(ii).E<=0)
            
            dead_p1=dead_p1+1;
             %Establish when 1% of the nodes die
            if (dead_p1==1)
                if(flag_first_dead_p==0)
                    first_dead_p = r3+1;
                    flag_first_dead_p=1;
                end
            end
               %Establish when 20% of the nodes die
            if(dead_p1==0.2*node_number)
                if(flag_twenty_dead_p==0)
                    twenty_dead_p = r3+1;
                    flag_twenty_dead_p=1;
                end
            end
            %Establish when 50% of the nodes die
            if(dead_p1==0.5*node_number)
                if(flag_half_dead_p==0)
                    half_dead_p = r3+1;
                    flag_half_dead_p=1;
                end
            end
            if(dead_p1==node_number)
                if(flag_all_dead_p==0)
                    all_dead_p = r3+1;
                    flag_all_dead_p=1;
                end
            end
    else
        energy2(r3+1)=energy2(r3+1)+S(ii).E; 
    end
end
    
    
    for ii=1:1:node_number                
        if (S(ii).E<=0)
          
            dead_p=dead_p+1;
        end
    end
    STATISTICS1(r3+1).ALLIVE = allive_p - dead_p;  
  
    STATISTICS1(r3+1).DEAD = dead_p;
    STATISTICS1(r3+1).ALLIVE5 = STATISTICS1(r3+1).ALLIVE;
     
   
    
  if STATISTICS1(r3+1).ALLIVE ~=0
    P = zeros(1,STATISTICS1(r3+1).ALLIVE); %inserting the remaining alive nodes into array P
  end
    for ii=1:1:node_number
        if S(ii).E > 0
            P(1)=ii;    
          
            break;
        end
    end
    
    for ii=2:STATISTICS1(r3+1).ALLIVE
        for j=(P(ii-1)+1):node_number,
            if S(j).E>0
                P(ii)=j;  
                break;
            end
        end
    end
    
   
  
    region_P_distance = zeros(1,STATISTICS1(r3+1).ALLIVE);
    region_P_max_distance=0;
    region_P_max_node = 0;
 
    
    
    for ii = 1:STATISTICS1(r3+1).ALLIVE              % finding farthest node
        S(P(ii)).region_P_distance  =  sqrt((S(P(ii)).xd)^2+(S(P(ii)).yd)^2);
        if region_P_max_distance <  S(P(ii)).region_P_distance
           region_P_max_distance = S(P(ii)).region_P_distance;       
           region_P_max_node =(P(ii));
        end
    end
 
   
    connect_distance_P = zeros(1,STATISTICS1(r3+1).ALLIVE);   
    connect_node_P =  zeros(1,STATISTICS1(r3+1).ALLIVE);      
    connect_node_P(1) =  region_P_max_node;               
    connect_distance_P(1) = 0;                    
    %count = 1
for ii=2:STATISTICS1(r3+1).ALLIVE      
        temp_node_P=0;
        temp_min_distance_P=inf;
        for j=1:STATISTICS1(r3+1).ALLIVE 
            b1=0;
            for k=1:(ii-1)
                if P(j)==connect_node_P(k)
                    b1=1;
                    break;
                end
            end
            if b1==0                                                 %%finding the nearest node for any node not connected in chain
               
               region_P_distance = sqrt((S(connect_node_P(ii-1)).xd - S(P(j)).xd)^2 + (S(connect_node_P(ii-1)).yd - S(P(j)).yd)^2);
                if temp_min_distance_P > region_P_distance
                    temp_min_distance_P = region_P_distance;
                    temp_node_P = P(j);
                end
            end
        end
        
        connect_distance_P(ii)=temp_min_distance_P;
        connect_node_P(ii)=temp_node_P;
        %plot([S(connect_node_P(ii-1)).xd S(connect_node_P(ii)).xd],[S(connect_node_P(ii-1)).yd S(connect_node_P(ii)).yd],'-o');
        %hold on;
end

   
 done = true;
%Leader node selection starts here (i mod N)
if STATISTICS1(r3+1).ALLIVE ~= 0
while done
  send_P = mod( begin_to_send, 100)+1 ;
    
    for j = 1:STATISTICS1(r3+1).ALLIVE
    
                    if P(j) ==  send_P
                    send_to_sink_P = send_P;
                          done = false;
                    break;
                    end
    end
       begin_to_send = begin_to_send+ 1;
     
end
end
begin_to_send = begin_to_send+ 1;
 dis_to_bs = sqrt((S( send_to_sink_P ).xd-Bx)^2+(S( send_to_sink_P).yd-By)^2);
 
    
		 for ii = 1:STATISTICS1(r3+1).ALLIVE 
		
          if connect_node_P(ii) ==  send_to_sink_P
                
                  if S(connect_node_P(ii)).E > 0
                        if ((dis_to_bs)> do)
                            S(connect_node_P(ii) ).E = S(connect_node_P(ii)).E- ((ETX+EDA+ERX)*(data_length) + Eamp*data_length*( (dis_to_bs)*(dis_to_bs)*(dis_to_bs)*(dis_to_bs) )); 
             
                        else 
                           S(connect_node_P(ii)).E = S(connect_node_P(ii)).E- ((ETX+EDA+ERX)*(data_length)+ Efs*data_length*((dis_to_bs)*(dis_to_bs))); 
                        end
                       packets_to_bs  =  packets_to_bs + 1;
                  end   
                 
          else
                  if  S(connect_node_P(ii)).E > 0
                        if ((connect_distance_P(ii))> do)
                            S(connect_node_P(ii) ).E=S(connect_node_P(ii)).E- ((ETX+EDA+ERX)*(data_length) + Eamp*data_length*(connect_distance_P(ii)*connect_distance_P(ii)*connect_distance_P(ii)*connect_distance_P(ii)) ); 
             
                        else 
                           S(connect_node_P(ii)).E= S(connect_node_P(ii)).E- ((ETX+EDA+ERX)*(data_length)+ Efs*data_length*(connect_distance_P(ii)*connect_distance_P(ii))); 
                        end 
                  end
          end 
       
            
            
            
   end 	
 	
    STATISTICS1(r3+1).PACKETS = packets_to_bs ;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation results graphs below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

 l = 0:rmax;
% % 
  figure(3);
  for i = 0:rmax
      alive_tsp(i+1) = STATISTICS3(i+1).ALLIVE5;
  end
% % 
for i = 0:rmax
      alive_peg(i+1) = STATISTICS1(i+1).ALLIVE;
 end
 plot(l,alive_tsp,'--g',l, alive_peg,'-r');
legend('ESSTBRP' ,'PEGASIS','Location','northwest');
 xlabel('Number of Round');
  ylabel('Number of Alive Nodes per Rounds');
 % title('Graph of Alive Nodes');
  

  figure(4);
  for i = 0:rmax
      dead_tsp(i+1) = STATISTICS3(i+1).DEAD5;
   end
 for i = 0:rmax
      dead_peg(i+1) = STATISTICS1(i+1).DEAD;
 end
%  
  plot(l,dead_tsp,'--g',l,dead_peg,'-r');
 legend('ESSTBRP' ,'PEGASIS','Location','southeast');
  xlabel('Number of Rounds');
  ylabel('Number of Dead Nodes per Rounds');
  %title('Graph of Dead Nodes');
% %  
  figure(5); 
  plot(l,energy1,'--g',l,energy2,'-r');
  legend('ESSTBRP' ,'PEGASIS','Location','southeast');
  xlabel('Number of Rounds');
  ylabel('Residual Energy(J)');
% title('Graph of Residual energy');
 
%   figure(5); 
% % %  
%  for p = 0:rmax
%       tsp_packets(p+1) = STATISTICS3(p+1).PACKETS_TO_BS;
%  end
% for p = 0:rmax
%       peg_packets(p+1) = STATISTICS1(p+1).PACKETS;
%  end 
%   plot(l,tsp_packets,'--g',l, peg_packets,'-r');
%   legend('ESSTBRP' ,'PEGASIS','Location','northwest');
%   xlabel('Number of Rounds');
%   ylabel('No.of Packets received by Basestation');
%   title('Graph of Throughput');
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Statistics for 1% 10% 50% 100% dead nodes ESSTBRP Protocol  
%   
%   
 fprintf ('Round after which 1 percent nodes are dead'); 
 fprintf('\n');
disp(first_dead_t);
fprintf('\n');
 fprintf ('Round after which 10 percent nodes are dead');  
 disp(twenty_dead_t);
 fprintf('\n');
 fprintf ('Round after which 50 dead');  
 fprintf('\n');
 disp(half_dead_t);
 fprintf('\n');
 fprintf ('Round after which 100 percent nodes are dead');  
 disp(all_dead_t); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% % Statistics for 1% 10% 50% 100% dead nodes PEGASIS Protocol  
 fprintf('\n');
 fprintf ('<<<<<<<<<<<<<<<<   PEGASIS STATISTICS START HERE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
 fprintf ('Round after which 1 percent nodes are dead');  
 fprintf('\n');
 disp(first_dead_p);
 fprintf('\n');
 fprintf ('Round after which 20 percent nodes are dead');  
 fprintf('\n');
 disp(twenty_dead_p);
 fprintf('\n');
 fprintf ('Round after which 50 dead');  
 fprintf('\n');
 disp(half_dead_p);
 fprintf('\n');
 fprintf ('Round after which 100 percent nodes are dead');  
 disp(all_dead_p);  
%   
  
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  