clc; clear all;

load('Checked.mat')
Face_init= Checked; %FACEBD17dez20163T;
%Nb. In the used FACEBDfile (FACEBD17dez20163T), all the '>20' data of column T have been set
%to 20.

%% STEP 1 _ modifying the database for some missing information

Size=size(Face_init);

% Column [Q](17): replace all “999999” values by the value “1”

for i=1:Size(1)
    if Face_init(i,17)==999999
        Face_init(i,17)=1;
    end
end

% Column [X](24): replace all “999999” values by the value “1”

for i=1:Size(1)
    if Face_init(i,24)==999999
        Face_init(i,24)=1;
    end
end

% Column [T](20): replace all “999999” values by the value “1”

for i=1:Size(1)
    if Face_init(i,20)==999999
        Face_init(i,20)=1;
    end
end

% Column [U](21): replace all “999999” values by the value “1” ONLY and IF ONLY the patient has the value “1” in the column [Z](26).

for i=1:Size(1)
    if Face_init(i,21)==999999 && Face_init(i,26)==1
        Face_init(i,21)=1;
    end
end

% If the value in the column [Z](26) is “2” or “3” replace the “999999” value in the column [U](21) by the value “0”

for i=1:Size(1)
    if Face_init(i,21)==999999 && (Face_init(i,26)==2 || Face_init(i,26)==3)
        Face_init(i,21)=0;
    end
end

% Column [PQ](433): replace all “999999” values by the value “1” for patients with score > 108 in the column [IR](252) (mathys_tot).
% For the other values “999999” in the column [PQ](433) replace them by the value “0”.

for i=1:Size(1)
    if Face_init(i,433)==999999 && Face_init(i,252)> 108
        Face_init(i,433)=1;
    elseif Face_init(i,433)==999999 && Face_init(i,252) >= 108
        Face_init(i,433)=0;
    end
end

Face_checked=Face_init;


%To check
% A=FACEBD17dez20163T(:,24);
% A(:,2)=Face_checked(:,24);


%% CHECKING MATHYS
Data_face=Face_checked;

Size=size(Data_face);

for i=1:Size(1)
    
    if Data_face(i,220)~=999999
        
        Data_face(i,247)=Data_face(i,222)+Data_face(i,226)+Data_face(i,229)+Data_face(i,237);                    %EMO
        Data_face(i,248)=Data_face(i,221)+Data_face(i,230)+Data_face(i,238);                                     %MOT
        Data_face(i,249)=Data_face(i,220)+Data_face(i,225)+Data_face(i,227)+Data_face(i,232)+Data_face(i,239);   %SEN
        Data_face(i,250)=Data_face(i,223)+Data_face(i,234)+Data_face(i,235)+Data_face(i,236);                    %MOV
        Data_face(i,251)=Data_face(i,224)+Data_face(i,228)+Data_face(i,231)+Data_face(i,233);                    %COG
        
        Data_face(i,252)=Data_face(i,247)+Data_face(i,248)+Data_face(i,249)+Data_face(i,250)+Data_face(i,251);   %TOT
        % DOUBLE CHECKED.
    end
end

save('Data_face')
%%

Size=size(Data_face);
J=[12 13 252 196 515 187 193 194 189 192 190 191 182 183 186 240 195];% 195 573:580 ?? % vector with the column numbers where we don't want any 999999.
% INDEXES = [187 193 194 189 192 190 191 182 183 186];
SizeJ=size(J);

for i=Size(1):-1:1
    
    SUM=0;
    
    for j=1:SizeJ(2)
        SUM= SUM + Data_face(i,J(j));   % sum of all the data we want to observe (see J) for the observed patient (#i)
    end
    
    if SUM> 999999 || Data_face(i,187)>9.5 || Data_face(i,196)>20|| Data_face(i,252)>200 % remove all values with 9999 in relevant columns AND remove patients with CRP strictly above 9.5 AND remove patients with MADRS > 15 AND removing patient 70320 who has mathys_tot >200
        Data_face(i,:)=[];
    end
    
end

Data649=Data_face;

save('Data649')

%% Statistics
Data=Data649;

N=size(Data,1);
disp('Number of patients remaining after removing the lines with missing data :'); disp(N);

figure(1)
subplot(3,1,1)
Madrs=Data(:,196);
hist(Madrs);
title('Madrs_t score distribution over the observed population');
xlabel('Score'); ylabel('# of Patients');

subplot(3,1,2)
Ymrs=Data(:,515);
hist(Ymrs,28);
title('Ymrs_t score distribution over the observed population');
xlabel('Score'); ylabel('# of Patients');

subplot(3,1,3)
Mathys=Data(:,252);
hist(Mathys,28);
title('Mathys_t score distribution over the observed population');
xlabel('Score'); ylabel('# of Patients');


%% See the distribution of the mathys_emo score in the sample, to see if it fits the cutoffs for mathys_emo

Emo=Data(:,247);

figure(2)
hist(Emo,42);
title('Mathys-emo score distribution over the observed population'),
xlabel('Score'); ylabel('# of Patients');

%% See the distribution of the mathys_emo score, taking into account the HYPO, HYPER and NORMAL classification.

SizeEmo=size(Emo);
% Classif(1)= Hypo, Classif(2) = Normal, Classif(3)= Hyper
Classif=[0 ; 0 ; 0];
Hypo=[];
Normal=[];
Hyper=[];

for i=1:SizeEmo(1)
    
    if Emo(i,1)<16 % Hypo
        Classif(1)=Classif(1)+1;        % Hypo
        Hypo(end+1,:)= Data(i,:);
    elseif Emo(i,1)>=16 && Emo(i,1)<=24 % Normal
        Classif(2)=Classif(2)+1;
        Normal(end+1,:)= Data(i,:);
    elseif Emo(i,1)>24 && Emo(i,1)<=40 % Hyper
        Classif(3)=Classif(3)+1;
        Hyper(end+1,:)= Data(i,:);
    end
    
end

figure(3)
bar(Classif)
Labels = {'Hypo-reactivity', 'Normal', 'Hyper-reactivity'};
set(gca, 'XTick', 1:3, 'XTickLabel', Labels);
text(0.9,Classif(1)+15,num2str(Classif(1))); text(1.9,Classif(2)+15,num2str(Classif(2))); text(2.9,Classif(3)+15,num2str(Classif(3)));
title({'Distribution of Hypo-,Hyper-reactive and Normal patients over the observed population','(Mathys-emo score)'})
Classif=Classif';

% Saving the 3 categories
save('Hypo')
save('Normal')
save('Hyper')

%% Seven emotions
% angles of 60° / 51.4°

% Hypo

Hypo_emo=Hypo(:,240:246);
Hypo_emo_means=mean(Hypo_emo);


% Normal

Norm_emo=Normal(:,240:246);
Norm_emo_means=mean(Norm_emo);


% Hyper

Hyper_emo=Hyper(:,240:246);
Hyper_emo_means=mean(Hyper_emo);

% HERE, PUT THE DATA 'HYPO_EMO_MEANS', 'NORMAL_EMO_MEANS' AND
% 'HYPER_EMO_MEANS' INTO THE 'SPIDER' SHEET OF FACEBD17dez20163T EXCEL
% FILE, IN ORDER TO GET THE SPIDER DIAGRAM

%% CREATION OF MATRICES GATHERING THE BIOMARKERS + Max/Min values per category

Hypo_markers = Hypo(:,182:195);
Hypo_biomarkers=[Hypo(:,187) Hypo(:,194) Hypo(:,189) Hypo(:,192) Hypo(:,190) Hypo(:,191) Hypo(:,193) Hypo(:,182) Hypo(:,183) Hypo(:,186)];
Norm_markers = Normal(:,182:195);
Norm_biomarkers=[Normal(:,187) Normal(:,194) Normal(:,189) Normal(:,192) Normal(:,190) Normal(:,191) Normal(:,193) Normal(:,182) Normal(:,183) Normal(:,186)];
Hyper_markers = Hyper(:,182:195);
Hyper_biomarkers=[Hyper(:,187) Hyper(:,194) Hyper(:,189) Hyper(:,192) Hyper(:,190) Hyper(:,191) Hyper(:,193) Hyper(:,182) Hyper(:,183) Hyper(:,186)];

% Min/Max values
Hypo_min=[min(Hypo_markers(:,6)) min(Hypo_markers(:,13)) min(Hypo_markers(:,14)) min(Hypo_markers(:,8)) min(Hypo_markers(:,11)) min(Hypo_markers(:,9)) min(Hypo_markers(:,10)) min(Hypo_markers(:,12)) min(Hypo_markers(:,1)) min(Hypo_markers(:,2)) min(Hypo_markers(:,5))];
Hypo_max=[max(Hypo_markers(:,6)) max(Hypo_markers(:,13)) max(Hypo_markers(:,14)) max(Hypo_markers(:,8)) max(Hypo_markers(:,11)) max(Hypo_markers(:,9)) max(Hypo_markers(:,10)) max(Hypo_markers(:,12)) max(Hypo_markers(:,1)) max(Hypo_markers(:,2)) max(Hypo_markers(:,5))];
Norm_min=[min(Norm_markers(:,6)) min(Norm_markers(:,13)) min(Norm_markers(:,14)) min(Norm_markers(:,8)) min(Norm_markers(:,11)) min(Norm_markers(:,9)) min(Norm_markers(:,10)) min(Norm_markers(:,12)) min(Norm_markers(:,1)) min(Norm_markers(:,2)) min(Norm_markers(:,5))];
Norm_max=[max(Norm_markers(:,6)) max(Norm_markers(:,13)) max(Norm_markers(:,14)) max(Norm_markers(:,8)) max(Norm_markers(:,11)) max(Norm_markers(:,9)) max(Norm_markers(:,10)) max(Norm_markers(:,12)) max(Norm_markers(:,1)) max(Norm_markers(:,2)) max(Norm_markers(:,5))];
Hyper_min=[min(Hyper_markers(:,6)) min(Hyper_markers(:,13)) min(Hyper_markers(:,14)) min(Hyper_markers(:,8)) min(Hyper_markers(:,11)) min(Hyper_markers(:,9)) min(Hyper_markers(:,10)) min(Hyper_markers(:,12)) min(Hyper_markers(:,1)) min(Hyper_markers(:,2)) min(Hyper_markers(:,5))];
Hyper_max=[max(Hyper_markers(:,6)) max(Hyper_markers(:,13)) max(Hyper_markers(:,14)) max(Hyper_markers(:,8)) max(Hyper_markers(:,11)) max(Hyper_markers(:,9)) max(Hyper_markers(:,10)) max(Hyper_markers(:,12)) max(Hyper_markers(:,1)) max(Hyper_markers(:,2)) max(Hyper_markers(:,5))];

% disp('Max and Min values for each Biomarker:')
% disp('Hypo-reactive');
% disp(Hypo_min);
% disp(Hypo_max);
% disp('Normally reactive');
% disp(Norm_min);
% disp(Norm_max);
% disp('Hyper-reactive');
% disp(Hyper_min);
% disp(Hyper_max);

%% CREATION OF THE INDEX for BIOMARKERS

Hypo_index=[];
Norm_index=[];
Hyper_index=[];

% Label = { CRP, Albumin, Glyco_hemo, Glycemia, Choles_tot, Choles_hdl,
% Choles_ldl, Trygli, Sbp, Dbp, Bmi }

n = 3; % Threshold of CRP INDEX (init : 3)
m1= 5; % Thresholds for glycosylated hemoglobin (init = 5.0 & 5.8)
m2= 5.8;
o1= 102.5; % Thresholds for SBP (init: 102.5 & 127.5)
o2= 127.5;
p1= 67.5; % Threshold for DBP (init: 67.5 & 82.5)
p2= 82.5;

% Hypo
Size=size(Hypo);

for i=1:Size(1) % CREATING THE SCORE MATRIX
    %Nb. 9 corresponds to normal values
    
        % CRP -> Hyper_index(1)
    if Hypo_markers(i,6)<=n
        Hypo_index(i,1)= 0;
%     elseif Hyper_markers(i,6)> 2.25 && Hyper_markers(i,6)< 4.5
%         Hyper_index(i,1)= 0.3;
%     elseif Hyper_markers(i,6) >= 4.5 && Hyper_markers(i,6)< 6.75
%         Hyper_index(i,1)= 0.6;
    elseif Hypo_markers(i,6)>n
        Hypo_index(i,1)= 1;
    end
    
    % Albumine -> Hypo_index(2)
    if Hypo_markers(i,13)<=38.5
        Hypo_index(i,2)= 1;
    elseif Hypo_markers(i,13)>=44.75
        Hypo_index(i,2)= 0;
    else
        Hypo_index(i,2)= 3;
    end
    
    % Glyco_hemo -> Hypo_index(3)
    if Hypo_markers(i,14)<=m1
        Hypo_index(i,3)= 0;
    elseif Hypo_markers(i,14)>=m2
        Hypo_index(i,3)= 1;
    else
        Hypo_index(i,3)= 3;
    end
    
    % Glycemia -> Hypo_index(4)
    if Hypo_markers(i,8)<=4.47
        Hypo_index(i,4)= 0;
    elseif Hypo_markers(i,8)>=5.43
        Hypo_index(i,4)= 1;
    else
        Hypo_index(i,4)= 3;
    end
    
    % Cholest_tot -> Hypo_index(5)
    if Hypo_markers(i,11)<=3.40
        Hypo_index(i,5)= 0;
    elseif Hypo_markers(i,11)>=4.60
        Hypo_index(i,5)= 1;
    else
        Hypo_index(i,5)= 3;
    end
    
    % Cholest_hdl -> Hypo_index(6)
    if Hypo_markers(i,9)<=1.18
        Hypo_index(i,6)= 1;
    elseif Hypo_markers(i,9)>=1.73
        Hypo_index(i,6)= 0;
    else
        Hypo_index(i,6)= 3;
    end
    
    % Cholest_ldl -> Hypo_index(7)
    if Hypo_markers(i,10)<=0.83
        Hypo_index(i,7)= 0;
    elseif Hypo_markers(i,10)>=2.51
        Hypo_index(i,7)= 1;
    else
        Hypo_index(i,7)=3 ;
    end
    
    % Trygli -> Hypo_index(8)
    if Hypo_markers(i,12)<=0.75
        Hypo_index(i,8)= 0;
    elseif Hypo_markers(i,12)>=1.45
        Hypo_index(i,8)= 1;
    else
        Hypo_index(i,8)= 3;
    end
    
    % SBP -> Hypo_index(9)
    if Hypo_markers(i,1)<=o1
        Hypo_index(i,9)= 0;
    elseif Hypo_markers(i,1)>=o2
        Hypo_index(i,9)= 1;
    else
        Hypo_index(i,9)= 3;
    end
    
    %DBP -> Hypo_index(10)
    if Hypo_markers(i,2)<=p1
        Hypo_index(i,10)= 0;
    elseif Hypo_markers(i,2)>=p2
        Hypo_index(i,10)= 1;
    else
        Hypo_index(i,10)= 3;
    end
    
    % BMI -> Hypo_index(11)
    if Hypo_markers(i,5)<=20.125
        Hypo_index(i,11)= 0;
    elseif Hypo_markers(i,5)>=23.375
        Hypo_index(i,11)= 1;
    else
        Hypo_index(i,11)= 3;
    end
end

Size=size(Hypo_index);
Hypo_index(:,Size(2)+1)=0;

for i=1:Size(1) % -> Lines
    for j=1:Size(2) % -> Columns
        if Hypo_index(i,j)> 0 && Hypo_index(i,j)<=1
            Hypo_index(i,Size(2)+1)=Hypo_index(i,Size(2)+1) + Hypo_index(i,j); % Adding +1 to the index if the score == 1
        end
    end
end

% Normal
Size=size(Normal);

for i=1:Size(1) % CREATING THE SCORE MATRIX
    %Nb. 9 corresponds to normal values
    
       % CRP -> Hyper_index(1)
    if Norm_markers(i,6)<=n
        Norm_index(i,1)= 0;
%     elseif Hyper_markers(i,6)> 2.25 && Hyper_markers(i,6)< 4.5
%         Hyper_index(i,1)= 0.3;
%     elseif Hyper_markers(i,6) >= 4.5 && Hyper_markers(i,6)< 6.75
%         Hyper_index(i,1)= 0.6;
    elseif Norm_markers(i,6)>n
        Norm_index(i,1)= 1;
    end
    
    % Albumine -> Norm_index(2)
    if Norm_markers(i,13)<=38.5
        Norm_index(i,2)= 1;
    elseif Norm_markers(i,13)>=44.75
        Norm_index(i,2)= 0;
    else
        Norm_index(i,2)= 3;
    end
    
    % Glyco_hemo -> Norm_index(3)
    if Norm_markers(i,14)<=m1
        Norm_index(i,3)= 0;
    elseif Norm_markers(i,14)>=m2
        Norm_index(i,3)= 1;
    else
        Norm_index(i,3)= 3;
    end
    
    % Glycemia -> Norm_index(4)
    if Norm_markers(i,8)<=4.47
        Norm_index(i,4)= 0;
    elseif Norm_markers(i,8)>=5.43
        Norm_index(i,4)= 1;
    else
        Norm_index(i,4)= 3;
    end
    
    % Cholest_tot -> Norm_index(5)
    if Norm_markers(i,11)<=3.40
        Norm_index(i,5)= 0;
    elseif Norm_markers(i,11)>=4.60
        Norm_index(i,5)= 1;
    else
        Norm_index(i,5)= 3;
    end
    
    % Cholest_hdl -> Norm_index(6)
    if Norm_markers(i,9)<=1.18
        Norm_index(i,6)= 1;
    elseif Norm_markers(i,9)>=1.73
        Norm_index(i,6)= 0;
    else
        Norm_index(i,6)= 3;
    end
    
    % Cholest_ldl -> Norm_index(7)
    if Norm_markers(i,10)<=0.83
        Norm_index(i,7)= 0;
    elseif Norm_markers(i,10)>=2.51
        Norm_index(i,7)= 1;
    else
        Norm_index(i,7)= 3;
    end
    
    % Trygli -> Norm_index(8)
    if Norm_markers(i,12)<=0.75
        Norm_index(i,8)= 0;
    elseif Norm_markers(i,12)>=1.45
        Norm_index(i,8)= 1;
    else
        Norm_index(i,8)= 3;
    end
    
    % SBP -> Norm_index(9)
    if Norm_markers(i,1)<=o1
        Norm_index(i,9)= 0;
    elseif Norm_markers(i,1)>=o2
        Norm_index(i,9)= 1;
    else
        Norm_index(i,9)= 3;
    end
    
    %DBP -> Norm_index(10)
    if Norm_markers(i,2)<=p1
        Norm_index(i,10)= 0;
    elseif Norm_markers(i,2)>=p2
        Norm_index(i,10)= 1;
    else
        Norm_index(i,10)= 3;
    end
    
    % BMI -> Norm_index(11)
    if Norm_markers(i,5)<=20.125
        Norm_index(i,11)= 0;
    elseif Norm_markers(i,5)>=23.375
        Norm_index(i,11)= 1;
    else
        Norm_index(i,11)= 3;
    end
end

Size=size(Norm_index);
Norm_index(:,Size(2)+1)=0;

for i=1:Size(1) % -> Lines
    for j=1:Size(2) % -> Columns
        if Norm_index(i,j)> 0 && Norm_index(i,j)<=1
            Norm_index(i,Size(2)+1)=Norm_index(i,Size(2)+1) + Norm_index(i,j); % Adding +1 to the index if the score == 1
        end
    end
end

% Hyper

Size=size(Hyper);

for i=1:Size(1) % CREATING THE SCORE MATRIX
    %Nb. 9 corresponds to Hyper values
    
    % CRP -> Hyper_index(1)
    if Hyper_markers(i,6)<=n
        Hyper_index(i,1)= 0;
%     elseif Hyper_markers(i,6)> 2.25 && Hyper_markers(i,6)< 4.5
%         Hyper_index(i,1)= 0.3;
%     elseif Hyper_markers(i,6) >= 4.5 && Hyper_markers(i,6)< 6.75
%         Hyper_index(i,1)= 0.6;
    elseif Hyper_markers(i,6)>n
        Hyper_index(i,1)= 1;
    end
    
    % Albumine -> Hyper_index(2)
    if Hyper_markers(i,13)<=38.5
        Hyper_index(i,2)= 1;
    elseif Hyper_markers(i,13)>=44.75
        Hyper_index(i,2)= 0;
    else
        Hyper_index(i,2)= 3;
    end
    
    % Glyco_hemo -> Hyper_index(3)
    if Hyper_markers(i,14)<=m1
        Hyper_index(i,3)= 0;
    elseif Hyper_markers(i,14)>=m2
        Hyper_index(i,3)= 1;
    else
        Hyper_index(i,3)= 3;
    end
    
    % Glycemia -> Hyper_index(4)
    if Hyper_markers(i,8)<=4.47
        Hyper_index(i,4)= 0;
    elseif Hyper_markers(i,8)>=5.43
        Hyper_index(i,4)= 1;
    else
        Hyper_index(i,4)= 3;
    end
    
    % Cholest_tot -> Hyper_index(5)
    if Hyper_markers(i,11)<=3.40
        Hyper_index(i,5)= 0;
    elseif Hyper_markers(i,11)>=4.60
        Hyper_index(i,5)= 1;
    else
        Hyper_index(i,5)= 3;
    end
    
    % Cholest_hdl -> Hyper_index(6)
    if Hyper_markers(i,9)<=1.18
        Hyper_index(i,6)= 1;
    elseif Hyper_markers(i,9)>=1.73
        Hyper_index(i,6)= 0;
    else
        Hyper_index(i,6)= 3;
    end
    
    % Cholest_ldl -> Hyper_index(7)
    if Hyper_markers(i,10)<=0.83
        Hyper_index(i,7)= 0;
    elseif Hyper_markers(i,10)>=2.51
        Hyper_index(i,7)= 1;
    else
        Hyper_index(i,7)= 3;
    end
    
    % Trygli -> Hyper_index(8)
    if Hyper_markers(i,12)<=0.75
        Hyper_index(i,8)= 0;
    elseif Hyper_markers(i,12)>=1.45
        Hyper_index(i,8)= 1;
    else
        Hyper_index(i,8)= 3;
    end
    
    % SBP -> Hyper_index(9)
    if Hyper_markers(i,1)<=o1
        Hyper_index(i,9)= 0;
    elseif Hyper_markers(i,1)>=o2
        Hyper_index(i,9)= 1;
    else
        Hyper_index(i,9)= 3;
    end
    
    %DBP -> Hyper_index(10)
    if Hyper_markers(i,2)<=p1
        Hyper_index(i,10)= 0;
    elseif Hyper_markers(i,2)>=p2
        Hyper_index(i,10)= 1;
    else
        Hyper_index(i,10)= 3;
    end
    
    % BMI -> Hyper_index(11)
    if Hyper_markers(i,5)<=20.125
        Hyper_index(i,11)= 0;
    elseif Hyper_markers(i,5)>=23.375
        Hyper_index(i,11)= 1;
    else
        Hyper_index(i,11)= 3;
    end
end

Size=size(Hyper_index);
Hyper_index(:,Size(2)+1)=0;

for i=1:Size(1) % -> Lines
    for j=1:Size(2) % -> Columns
        if Hyper_index(i,j)> 0 && Hyper_index(i,j)<=1
            Hyper_index(i,Size(2)+1)=Hyper_index(i,Size(2)+1) + Hyper_index(i,j); % Adding +1 to the index if the score == 1
        end
    end
end

% save('Hypo_index')
% save('Norm_index')
% save('Hyper_index')

%% PLOTTING INDEX DISTRIBUTIONS

Size=size(Hypo_index);

figure(3)
subplot(3,1,1)
histogram(Hypo_index(:,Size(2)),8);
xlabel('Index'); ylabel('Number of Patients');
mu=mean(Hypo_index(:,Size(2)));
title('Distribution of the Index (over 11) for Hypo-, Hyper- reactive and Normal patients')
hold on
plot([mu,mu],ylim,'k--','LineWidth',2)
hold off
legend({'Hypo reactive',['Mean Value =' num2str(mu)]})

subplot(3,1,2)
histogram(Norm_index(:,Size(2)),9,'FaceColor','r');
xlabel('Index'); ylabel('Number of Patients');
legend('Normal');
mu=mean(Norm_index(:,Size(2)));
hold on
plot([mu,mu],ylim,'k--','LineWidth',2)
hold off
legend({'Normally reactive',['Mean Value =' num2str(mu)]})

subplot(3,1,3)
histogram(Hyper_index(:,Size(2)),10,'FaceColor','g');
xlabel('Index'); ylabel('Number of Patients');
legend('Hyper-reactive');
mu=mean(Hyper_index(:,Size(2)));
hold on
plot([mu,mu],ylim,'k--','LineWidth',2)
hold off
legend({'Hyper reactive',['Mean Value =' num2str(mu)]})

disp('Mean of Hypo Index :'); disp(mean(Hypo_index(:,Size(2))));
disp('Mean of Normal Index :'); disp(mean(Norm_index(:,Size(2))));
disp('Mean of Hyper Index :'); disp(mean(Hyper_index(:,Size(2))));



%% Number of patients with CRP > 9.5

Size=size(Data);
Count1=0 ;
Count2=0;

for i=1:Size(1)
    if Data(i,187)> 9.5 % CRP
        Count1=Count1 +1;
    elseif Data(i,196) <= 15 % MADRS
        Count2=Count2 +1;
    end
    
end

disp('Number of patients with CRP above 9.5:'); disp(Count1);
disp('Number of patients with MADRS score below or equal to 15 (Euthymia):'); disp(Count2);

% TOTAL POPULATION
figure(15)
subplot(4,1,1)
histogram(Data(:,187));
title('Distribution of C-reactive protein (mg/L) over the population')
ylabel('Number of Patients'); xlabel('CRP');

% HYPO
subplot(4,1,2)
histogram(Hypo(:,187),'FaceColor','c'); hold on;
mu=mean(Hypo(:,187));
plot([mu,mu],ylim,'k--','LineWidth',2)
hold off
legend({'Hypo reactive',['Mean Value =' num2str(mu)]})
ylabel('Number of Patients'); xlabel('CRP');
title('Distribution of C-reactive protein (mg/L) over the Hypo-, Hyper- reactive and Normal patients');

% NORMAL
subplot(4,1,3)
histogram(Normal(:,187),'FaceColor','r');
ylabel('Number of Patients'); xlabel('CRP');
hold on
mu=mean(Normal(:,187));
plot([mu,mu],ylim,'k--','LineWidth',2)
hold off
legend({'Normally reactive',['Mean Value =' num2str(mu)]})

% HYPER
subplot(4,1,4)
histogram(Hyper(:,187),'FaceColor','g');
ylabel('Number of Patients'); xlabel('CRP');
hold on
mu=mean(Hyper(:,187));
plot([mu,mu],ylim,'k--','LineWidth',2)
hold off
legend({'Hyper reactive',['Mean Value =' num2str(mu)]})

Sum_CRP_Index= [Hypo_index(:,1);Norm_index(:,1);Hyper_index(:,1)];
figure(16)
histogram(Sum_CRP_Index,7);
title('Distribution of CRP Indexes over the population')
% Labels = {'1st quartile)', 'Second quartile','Third quartile','Fourth quartile'};
% set(gca, 'XTick', 0:1, 'XTickLabel', Labels);

% Percentile_25=prctile(Data(:,187),25);
% Percentile_50=prctile(Data(:,187),50);
% Percentile_75=prctile(Data(:,187),75);

figure(16)
histogram(Data(:,187));
title('Distribution of C-reactive protein (mg/L) over the population')
ylabel('Number of Patients'); xlabel('CRP');
hold on
mu1=0.9; %first quartile
mu2=3; %second quartile
mu3=4.5; %third quartile
plot([mu1,mu1],ylim,'k--','LineWidth',2)
plot([mu2,mu2],ylim,'k--','LineWidth',2)
plot([mu3,mu3],ylim,'k--','LineWidth',2)
legend({'Total population',['First quartile =' num2str(mu1)],['Second quartile =' num2str(mu2)],['Third quartile =' num2str(mu3)]})
hold off

clear Classif; clear Count1; clear Count2; clear Data_face; clear Emo; clear Face_checked; clear Face_init; clear i; clear j; clear J; clear Labels; clear m1; clear m2; clear Madrs; clear Mathys; clear mu; clear mu1; clear mu2; clear mu3; clear n; clear N; clear o1; clear o2; clear p1; clear p2; clear Size; clear SizeEmo; clear SizeJ; clear SUM; clear Sum_CRP_Index; clear Ymrs; clear Hyper_max; clear Hyper_min; clear Hypo_min; clear Hypo_max; clear Norm_max; clear Norm_min; 
