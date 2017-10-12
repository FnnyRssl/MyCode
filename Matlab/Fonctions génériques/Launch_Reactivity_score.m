clc; clear all;

load('Data_649.mat')

Base=Reactivity_score(Data_649, 894);

Base=Biomarkers(Base);

Other=[];
Hyper=[];

for i = 1:length(Base)
    if Base(i,16)==1
        Other(end+1,:)=Base(i,:);
    elseif Base(i,16)==2
        Hyper(end+1,:)=Base(i,:);
    end
end

save('Hyper'); save('Other');
