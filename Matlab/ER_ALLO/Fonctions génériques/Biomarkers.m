function [ File ] = Biomarkers( Dataset )

% extracts biomarkers from the Dataset
% [CRP, Albumin, Glycemia, Choles_tot, Choles_hdl, Choles_ldl, Trygli, Sbp, Dbp, Bmi]

File =[Dataset(:,187) Dataset(:,194) Dataset(:,189) Dataset(:,192) Dataset(:,190) Dataset(:,191) Dataset(:,193) Dataset(:,182) Dataset(:,183) Dataset(:,186)];


end

