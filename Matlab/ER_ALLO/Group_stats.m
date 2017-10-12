clc; clear all; clear workspace;

load('Hypo.mat')
load('Normal.mat')
load('Hyper.mat')
Table=zeros(79,3);
diary on

% FILL THE TABLE = Data

Info=[0 0]; %

Z=[1 2 3]; % 1=HYPO, 2=NORMAL, 3=HYPER

for m=1:3
    
GROUP= Z(m);
I=Z(m);

if GROUP==1 
% disp('----------------------Hypo-REACTIVE PATIENTS----------------------')
Data=Hypo;
elseif GROUP==2    
% disp('----------------------Normally-REACTIVE PATIENTS----------------------')
Data=Normal;
elseif GROUP==3
% ('----------------------Hyper-REACTIVE PATIENTS----------------------')
Data=Hyper;
end

K=1;
Size=size(Data);
Table(K,I)= Size(1); K=K+1;

% Gender

Info=[0 0];
Counter=0; %
for i=1:Size(1)
    % Gender
    if Data(i,12)==2
        Info(1)=Info(1) +1;
        Counter=Counter +1;
    elseif Data(i,12)==1
        Info(2)=Info(2) +1;
    end
end
Fem_ra=Info(1)/sum(Info)*100;
Mal_ra=Info(2)/sum(Info)*100;
% disp('----- Proportion of Women in the Data population (in %): -----'); disp(Fem_ra);
Table(K,I)=Counter; K=K+1;
Table(K,I)=Fem_ra; K=K+1;
%  disp('Proportion of Men in the Data population: (in %)'); disp(Mal_ra);

% Mean Age
Info=[0 0];
Info(1)=mean(Data(:,13));
% disp('----- Mean age of the population -----'); disp(Info(1));
Table(K,I)=Info(1); K=K+1;
Info(2)=std(Data(:,13));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(2); K=K+1;

% Mean Education level
Info=[0 0];
Tri=[];
for i=1:Size(1)
    if Data(i,35)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,35));
% disp('----- Mean Education level of the population -----'); disp(Info(1));
Table(K,I)=Info(1);K=K+1;
Info(2)=std(Tri(:,35));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(2);K=K+1;

% Occupation
Info=[0 0 0 0 0 0 0 0];

for i=1:Size(1)
    if Data(i,37)==999999
        Info(1)=Info(1) +1;
    elseif Data(i,37)==1
        Info(2)=Info(2) +1;
    elseif Data(i,37)==2
        Info(3)=Info(3) +1;
    elseif Data(i,37)==3
        Info(4)=Info(4) +1;
    elseif Data(i,37)==4
        Info(5)=Info(5) +1;
    elseif Data(i,37)==5
        Info(6)=Info(6) +1;
    elseif Data(i,37)==6
        Info(7)=Info(7) +1;
    elseif Data(i,37)==7
        Info(8)=Info(8) +1;
    end
end

% disp('----- Distribution of population occupations (in %+ number of patients): -----');
% disp('1'); disp(Info(2)/Size(1) * 100); disp(Info(2)); 
Table(K,I)=Info(2)/Size(1) * 100; K=K+1;
% disp('2'); disp(Info(3)/Size(1) * 100); disp(Info(3)); 
Table(K,I)=Info(3)/Size(1) * 100; K=K+1;
% disp('3'); disp(Info(4)/Size(1) * 100); disp(Info(4)); 
Table(K,I)=Info(4)/Size(1) * 100; K=K+1;
% disp('4'); disp(Info(5)/Size(1) * 100); disp(Info(5)); 
Table(K,I)=Info(5)/Size(1) * 100; K=K+1;
% disp('5'); disp(Info(6)/Size(1) * 100); disp(Info(6)); 
Table(K,I)=Info(6)/Size(1) * 100; K=K+1;
% disp('6'); disp(Info(7)/Size(1) * 100); disp(Info(7)); 
Table(K,I)=Info(7)/Size(1) * 100; K=K+1;
% disp('7'); disp(Info(8)/Size(1) * 100); disp(Info(8)); 
Table(K,I)=Info(8)/Size(1) * 100; K=K+1;
% disp('999999'); disp(Info(1)/Size(1) * 100); disp(Info(1)); 
Table(K,I)=Info(1)/Size(1) * 100; K=K+1;

% Diagnosis

Info=[0 0 0 0 0 0 0];
Count=[0 0 0 0];
for i=1:Size(1)
    if Data(i,26)==9
        Info(1)=Info(1) +1;
        Count(4)=Count(4)+1;
    elseif Data(i,26)==1
        Info(2)=Info(2) +1;
        Count(1)=Count(1)+1;
    elseif Data(i,26)==2
        Info(3)=Info(3) +1;
        Count(2)=Count(2)+1;
    elseif Data(i,26)==3
        Info(4)=Info(4) +1;
        Count(3)=Count(3)+1;
    elseif Data(i,26)==4
        Info(5)=Info(5) +1;
        Count(4)=Count(4)+1;
    elseif Data(i,26)==7
        Info(6)=Info(6) +1;
        Count(4)=Count(4)+1;
    elseif Data(i,26)==8
        Info(7)=Info(7) +1;
        Count(4)=Count(4)+1;
    end
end

% disp('----- Diagnosis (in % + number of patients) -----');
% disp('1'); disp(Info(2)/Size(1) *100); disp(Info(2)); 
% disp('2'); disp(Info(3)/Size(1) *100); disp(Info(3));
% disp('3'); disp(Info(4)/Size(1) *100); disp(Info(4));
% disp('4'); disp(Info(5)/Size(1) *100); disp(Info(5));
% disp('7'); disp(Info(6)/Size(1) *100); disp(Info(6));
% disp('8'); disp(Info(7)/Size(1) *100); disp(Info(7));
% disp('9'); disp(Info(1)/Size(1) *100); disp(Info(1));

Table(K,I)=Count(1); K=K+1;
Table(K,I)=Info(2)/Size(1) *100; K=K+1;
Table(K,I)=Count(2); K=K+1;
Table(K,I)=Info(3)/Size(1) *100; K=K+1;
Table(K,I)=Count(3); K=K+1;
Table(K,I)=Info(4)/Size(1) *100; K=K+1;
Table(K,I)=Info(5)/Size(1) *100; K=K+1;
Table(K,I)=Info(6)/Size(1) *100; K=K+1;
Table(K,I)=Info(7)/Size(1) *100; K=K+1;
Table(K,I)=Info(1)/Size(1) *100; K=K+1;
Table(K,I)=Count(4); K=K+1;

% Age at onset

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,14)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,14));
Info(2)=std(Tri(:,14));

% disp('----- Mean age-at-onset -----'); disp(Info(1));
Table(K,I)=Info(1); K=K+1;
% disp('Std'); disp(Info(2));
Table(K,I)=Info(2);K=K+1;

% Illness duration, years

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,15)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,15));
Info(2)=std(Tri(:,15));

% disp('----- Mean illness duration -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% Number of hospitalisation

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,108)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,108));
Info(2)=std(Tri(:,108));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% disp('----- Mean number of hospitalisations -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% Total number of episodes (Depressive & Total)

% Total
Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,16)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,16));
Info(2)=std(Tri(:,16));

% disp('----- Mean number of episodes tot -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% Depressive
Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,17)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,17));
Info(2)=std(Tri(:,17));

% disp('----- Mean number of depressive episodes -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% Rapid cycling

Info=[0 0 0 0];
Count=[0 0 0];

for i=1:Size(1)
    if Data(i,31)==999999
        Info(1)=Info(1) +1;
        Count(3)=Count(3)+1;
    elseif Data(i,31)==1
        Info(2)=Info(2) +1;
        Count(1)=Count(1)+1;
    elseif Data(i,31)==2
        Info(3)=Info(3) +1;
        Count(2)=Count(2)+1;
    elseif Data(i,31)==9
        Info(4)=Info(4) +1;
        Count(3)=Count(3)+1;
    end
end

% disp('Rapid cycling (in %)');
% disp('1'); disp(Info(2)/Size(1) * 100); 
Table(K,I)=Count(1);K=K+1;
Table(K,I)=Info(2)/Size(1) * 100; K=K+1;
% disp('2'); disp(Info(3)/Size(1) * 100); 
Table(K,I)=Count(2);K=K+1;
Table(K,I)=Info(3)/Size(1) * 100; K=K+1;
% disp('9'); disp(Info(4)/Size(1) * 100); 
Table(K,I)=Count(3);K=K+1;
Table(K,I)=(Info(4)+Info(1))/Size(1) * 100; K=K+1;
% disp('999999'); disp(Info(1)/Size(1) * 100);

% Number of suicid attempts -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,433)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,433));
Info(2)=std(Tri(:,433));
Table(K,I)=Info(1); K=K+1;
Table(K,I)=Info(2); K=K+1;

% disp('----- Mean number suicid attempts -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% MADRS score -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,196)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,196));
Info(2)=std(Tri(:,196));
Table(K,I)=Info(1); K=K+1;
Table(K,I)=Info(2); K=K+1;

% disp('----- Mean MADRS score -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% YMRS score -
Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,515)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,515));
Info(2)=std(Tri(:,515));

% disp('----- Mean YMRS score -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% STAI score -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,661)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,661));
Info(2)=std(Tri(:,661));
Table(K,I)=Info(1); K=K+1;
Table(K,I)=Info(2); K=K+1;

% disp('----- Mean STAY score -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% MAThyS total score -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,252)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,252));
Info(2)=std(Tri(:,252));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% disp('----- Mean MAThyS total score -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% Comorbidities

Info=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
Count=[0 0 0; 0 0 0; 0 0 0; 0 0 0];
for i=1:Size(1)
    % Anxiety disorder
    if Data(i,141)==1
        Info(2)=Info(2) +1;
        Count(1,1)=Count(1,1)+1;
    elseif Data(i,141)==2
        Info(3)=Info(3) +1;
        Count(1,2)=Count(1,2)+1;
    elseif Data(i,141)==999999
        Info(1)=Info(1) +1;
        Count(1,3)=Count(1,3)+1;
    elseif Data(i,141)==9
        Info(4)=Info(4) +1;
        Count(1,3)=Count(1,3)+1;
        
    end
    
        % Diabetes
    if Data(i,350)==999999
        Info(5)=Info(5) +1;
        Count(2,3)=Count(2,3)+1;
    elseif Data(i,350)==1
        Info(6)=Info(6) +1;
        Count(2,1)=Count(2,1)+1;
    elseif Data(i,350)==2
        Info(7)=Info(7) +1;
        Count(2,2)=Count(2,2)+1;
    elseif Data(i,350)==9
        Info(8)=Info(8) +1;
        Count(2,3)=Count(2,3)+1;
    end
    
        % Cardiovascular
    if Data(i,363)==999999
        Info(9)=Info(9) +1;
        Count(3,3)=Count(3,3)+1;
    elseif Data(i,363)==1
        Info(10)=Info(10) +1;
        Count(3,1)=Count(3,1)+1;
    elseif Data(i,363)==2
        Info(11)=Info(11) +1;
        Count(3,2)=Count(3,2)+1;
    elseif Data(i,363)==9
        Info(12)=Info(12) +1;
        Count(3,3)=Count(3,3)+1;
    end
    
        % Substance use disorders
    if Data(i,142)==999999
        Info(13)=Info(13) +1;
        Count(4,3)=Count(4,3)+1;
    elseif Data(i,142)==1
        Info(14)=Info(14) +1;
        Count(4,1)=Count(4,1)+1;
    elseif Data(i,142)==2
        Info(15)=Info(15) +1;
        Count(4,2)=Count(4,2)+1;
    elseif Data(i,142)==9
        Info(16)=Info(16) +1;
        Count(4,3)=Count(4,3)+1;
    end
    
end

disp('----- Comorbidities -----');

% disp('Anxiety Disorders')
% disp('1'); disp(Info(2) / Size(1) * 100); 
Table(K,I)= Count(1,1);K=K+1;
Table(K,I)= Info(2) / Size(1) * 100; K=K+1;
% disp('2'); disp(Info(3) / Size(1) * 100); 
Table(K,I)= Count(1,2);K=K+1;
Table(K,I)= Info(3) / Size(1) * 100; K=K+1;
% disp('9'); disp(Info(4) / Size(1) * 100); 
Table(K,I)= Count(1,3);K=K+1;
Table(K,I)= (Info(4)+Info(1)) / Size(1) * 100; K=K+1;
% disp('999999'); disp(Info(1) / Size(1) * 100);

% disp('Diabetes')
% disp('1'); disp(Info(6) / Size(1) * 100); 
Table(K,I)= Count(2,1);K=K+1;
Table(K,I)= Info(6) / Size(1) * 100; K=K+1;
% disp('2'); disp(Info(7) / Size(1) * 100); 
Table(K,I)= Count(2,2);K=K+1;
Table(K,I)= Info(7) / Size(1) * 100; K=K+1;
% disp('9'); disp(Info(8) / Size(1) * 100); 
Table(K,I)= Count(2,3);K=K+1;
Table(K,I)= (Info(8)+Info(5)) / Size(1) * 100; K=K+1;
% disp('999999'); disp(Info(5) / Size(1) * 100);

% disp('Cardiovascular')
% disp('1'); disp(Info(10) / Size(1) * 100); 
Table(K,I)= Count(3,1);K=K+1;
Table(K,I)= Info(10) / Size(1) * 100; K=K+1;
% disp('2'); disp(Info(11) / Size(1) * 100); 
Table(K,I)= Count(3,2);K=K+1;
Table(K,I)= Info(11) / Size(1) * 100; K=K+1;
% disp('9'); disp(Info(12) / Size(1) * 100); 
Table(K,I)= Count(3,3);K=K+1;
Table(K,I)= (Info(12)+Info(9)) / Size(1) * 100; K=K+1;
% disp('999999'); disp(Info(9) / Size(1) * 100);

% disp('Substance use disorders')
% disp('1'); disp(Info(14) / Size(1) * 100); 
Table(K,I)= Count(4,1);K=K+1;
Table(K,I)= Info(14) / Size(1) * 100; K=K+1;
% disp('2'); disp(Info(15) / Size(1) * 100); 
Table(K,I)= Count(4,2);K=K+1;
Table(K,I)= Info(15) / Size(1) * 100; K=K+1;
% disp('9'); disp(Info(16) / Size(1) * 100); 
Table(K,I)= Count(4,3);K=K+1;
Table(K,I)= (Info(16)+Info(13)) / Size(1) * 100; K=K+1;
% disp('999999'); disp(Info(13) / Size(1) * 100);


% Current smoking

Info=[0 0 0 0];

for i=1:Size(1)
    if Data(i,156)==999999
        Info(1)=Info(1) +1;
    elseif Data(i,156)==1
        Info(2)=Info(2) +1;
    elseif Data(i,156)==2
        Info(3)=Info(3) +1;
    elseif Data(i,156)==3
        Info(4)=Info(4) +1;
    end
end

% disp('Current smoking (in %)')
% disp('1'); disp(Info(2) / Size(1) * 100);
% disp('2'); disp(Info(3) / Size(1) * 100);
% disp('3'); disp(Info(4) / Size(1) * 100);
% disp('999999'); disp(Info(1) / Size(1) * 100);

Table(K,I)=Info(2) / Size(1) * 100; K=K+1;
Table(K,I)=Info(3) / Size(1) * 100; K=K+1;
Table(K,I)=Info(4) / Size(1) * 100; K=K+1;
Table(K,I)=Info(1) / Size(1) * 100; K=K+1;

% C-reactive protein -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,187)~=999999
        Tri(end+1,:)=Data(i,:); 
    end
end
Info(1)=mean(Tri(:,187));
Info(2)=std(Tri(:,187));

% disp('----- Mean C-reactive protein concentration (mg/L) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% Albumine -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,194)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,194));
Info(2)=std(Tri(:,194));

% disp('----- Mean Albumine concentration (g/L) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% Glycosylated_hemoglobin (RANGE(median))

Info=[0 0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,195)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=max(Tri(:,195));
Info(2)=min(Tri(:,195));
Info(3)=median(Tri(:,195));

% disp('----- Glycosylated_hemoglobin (g/L) -----'); 
% disp('Max & Min values'); disp(Info(1)); disp(Info(2));
% disp('Median'); disp(Info(3));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;
Table(K,I)=Info(3);K=K+1;



% Tot_cholesterol -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,192)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,192));
Info(2)=std(Tri(:,192));

% disp('----- Mean total cholesterol (mmol/L) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% HDL Cholesterol -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,190)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,190));
Info(2)=std(Tri(:,190));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% disp('----- Mean HDL Cholesterol concentration (mmol/L) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% LDL Cholesterol -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,191)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,191));
Info(2)=std(Tri(:,191));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% disp('----- Mean LDL Cholesterol concentration (mmol/L) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% Tryglicerides -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,193)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,193));
Info(2)=std(Tri(:,193));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% disp('----- Mean Tryglicerides concentration (mmol/L) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));

% SBP -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,182)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,182));
Info(2)=std(Tri(:,182));

% disp('----- Mean SBP (mmHg) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% DBP -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,183)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,183));
Info(2)=std(Tri(:,183));

% disp('----- Mean DBP (mmHg) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% BMI -

Info=[0 0];
Tri=[];

for i=1:Size(1)
    if Data(i,186)~=999999
        Tri(end+1,:)=Data(i,:);
    end
end
Info(1)=mean(Tri(:,186));
Info(2)=std(Tri(:,186));

% disp('----- Mean Body Mass index (kg/m²) -----'); disp(Info(1));
% disp('Std'); disp(Info(2));
Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;

% MEDICINES

Info = [0 0 0 0 0];
Tri=Data(:,832:845);

% for i=1:Size(1)
%     if Data(i,132)~=999999 && Data(i,133)~=999999 && Data(i,134)~=999999 && Data(i,135)~=999999 && Data(i,136)~=999999 && Data(i,137)~=999999 && Data(i,138)~=999999 && Data(i,139)~=999999 && Data(i,140)~=999999 && Data(i,141)~=999999 && Data(i,142)~=999999 && Data(i,143)~=999999  && Data(i,144)~=999999 && Data(i,145)~=999999
%         Tri(end+1,:)=Data(i,:);
%     end
% end

Size=size(Tri);
A=[1 43 49 75 81 82 90 99 101 102 116 132 137 139 141 143 162 180];
B=[9 10 65 98 100 135];
C=[25 26 27 30 35 36 46 47 96 97 105 122 130 131 155];
D=[2 5 13 14 17 18 23 32 33 37 39 40 42 45 48 54 57 58 59 67 72 73 76 78 79 86 87 88 89 91 103 104 110 111 112 121 158 159 182];
E=[3 11 31 44 50 51 52 53 63 68 70 74 84 85 92 93 106 107 113 114 129];

for i=1:Size(1)

    Mat= Tri(i,:);
   [~,idx]=unique(strcat(Mat));
   Mat=Mat(:,idx);
    
    for j=1:length(Mat)
        
        
        
        for l=1:length(A)
        if Mat(j)==A(l)
            Info(1)=Info(1)+1;
            continue
        end
        end
        
        for l=1:length(B)
        if Mat(j)==B(l)
            Info(2)=Info(2)+1;
            continue
        end
        end
        
        for l=1:length(C)
        if Mat(j)==C(l)
            Info(3)=Info(3)+1;
            continue
        end
        end
        
        for l=1:length(D)
        if Mat(j)==D(l)
            Info(4)=Info(4)+1;
            continue
        end
        end
        
        for l=1:length(E)
        if Mat(j)==E(l)
            Info(5)=Info(5)+1;
            continue
        end
        end
        
    end
end

Table(K,I)=Info(1);K=K+1;
Table(K,I)=Info(2);K=K+1;
Table(K,I)=Info(3);K=K+1;
Table(K,I)=Info(4);K=K+1;
Table(K,I)=Info(5);K=K+1;

end

clear A; clear B; clear C; clear D; clear E; clear Fem_ra; clear Mal_ra; clear Info; clear idx; clear K; clear I; clear m; clear Mat; clear Size; clear Tri; clear Z; clear Count; clear j; clear i; clear GROUP; clear J; clear N; clear SizeEmo; clear l; clear Ymrs; clear SUM; clear Labels; clear Emo; clear Data_face; clear Counter; clear Classif; clear Madrs; clear Mathys; clear SizeJ; clear Face_checked; clear Checked; clear Face_init; clear Data; 


