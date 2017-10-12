%% NEED TO SAVE THE INDEXES MATRICES IN MAIN

clc; clear all;

load('Hypo_index.mat')
load('Norm_index.mat')
load('Hyper_index.mat')


%% THE IMPACT OF EACH BIOMARKER ON THE FINAL INDEX


figure(4)
subplot(3,1,1)
histogram(Hypo_index(:,1))
title('Distribution of CRP over the population')
Labels = {'Inferior or equal to 3', 'Superior to 3'};
set(gca, 'XTick', 0:1, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,1))
Labels = {'Inferior or equal to 3', 'Superior to 3'};
set(gca, 'XTick', 0:1, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,1))
Labels = {'Inferior or equal to 3', 'Superior to 3'};
set(gca, 'XTick', 0:4, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(5)
subplot(3,1,1)
histogram(Hypo_index(:,2))
title('Distribution of Albumine over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,2))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,2))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(6)
subplot(3,1,1)
histogram(Hypo_index(:,3))
title('Distribution of Glycosylated Hemoglobin over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,3))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,3))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(7)
subplot(3,1,1)
histogram(Hypo_index(:,4))
title('Distribution of Glycemia over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,4))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,4))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(8)
subplot(3,1,1)
histogram(Hypo_index(:,5))
title('Distribution of Total Cholesterol over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,5))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,5))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(9)
subplot(3,1,1)
histogram(Hypo_index(:,6))
title('Distribution of HDL Cholesterol over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,6))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,6))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(10)
subplot(3,1,1)
histogram(Hypo_index(:,7))
title('Distribution of LDL Cholesterol over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,7))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,7))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(11)
subplot(3,1,1)
histogram(Hypo_index(:,8))
title('Distribution of Tryglicerides over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,8))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,8))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(12)
subplot(3,1,1)
histogram(Hypo_index(:,9))
title('Distribution of SBP over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,9))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,9))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(13)
subplot(3,1,1)
histogram(Hypo_index(:,10))
title('Distribution of DBP over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,10))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,10))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%%
figure(14)
subplot(3,1,1)
histogram(Hypo_index(:,11))
title('Distribution of Body Mass Index over the population')
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,2)
histogram(Norm_index(:,11))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');
subplot(3,1,3)
histogram(Hyper_index(:,11))
Labels = {'Low (25th percentile)', 'High (75th percentile)','', 'Normal range'};
set(gca, 'XTick', 0:3, 'XTickLabel', Labels);
ylabel('Number of Patients'); xlabel('Biomarker');

%% Which proportion of each biomarker in the index

%Hypo
Size=size(Hypo_index);
Tot_marks=[0 0 0 0 0 0 0 0 0 0 0 ];

for j=1:Size(2)-1
 for i=1:Size(1)
     if Hypo_index(i,j)==1
         Tot_marks(1,j)=Tot_marks(1,j) +1;
     end
 end
end

Prop_index1=Tot_marks/sum(Tot_marks);

% Normal
Size=size(Norm_index);
Tot_marks=[0 0 0 0 0 0 0 0 0 0 0 ];

for j=1:Size(2)-1
 for i=1:Size(1)
     if Norm_index(i,j)==1
         Tot_marks(1,j)=Tot_marks(1,j) +1;
     end
 end
end

Prop_index2=Tot_marks/sum(Tot_marks);

% Hyper
Size=size(Hyper_index);
Tot_marks=[0 0 0 0 0 0 0 0 0 0 0 ];

for j=1:Size(2)-1
 for i=1:Size(1)
     if Hyper_index(i,j)==1
         Tot_marks(1,j)=Tot_marks(1,j) +1;
     end
 end
end

Prop_index3=Tot_marks/sum(Tot_marks);

figure(16)
% labels={'CRP','Albumine','Glyco_hemo','Glycemia','Chole_tot','HDL_Chole','LDL_Chole','Trygli','SBP','DBP','BMI'};
subplot(1,4,1)
pie(Prop_index1)
title('Hypo-reactive')
subplot(1,4,2)
pie(Prop_index2)
title({'Impact of each biomarker on the Index of each category (Hypo-, Hyper- reactive and Normal)','Normal'})
subplot(1,4,3)
pie(Prop_index3)
title('Hyper-reactive')
legend('CRP','Albumine','Glyco hemo','Glycemia','Chole tot','HDL Chole','LDL Chole','Trygli','SBP','DBP','BMI')

