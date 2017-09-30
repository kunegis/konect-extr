%
% Generate the AUC Latex table.
%
% INPUT FILES 
%	dat-petster/auc.hamster.mat
%	dat-petster/auc.cat.mat
%	dat-petster/auc.dog.mat
%	dat-petster/reg.hamster.mat
%	dat-petster/reg.cat.mat
%	dat-petster/reg.dog.mat
%	dat-petster/regauc.hamster.mat
%	dat-petster/regauc.cat.mat
%	dat-petster/regauc.dog.mat
%
% OUTPUT FILES 
%	tex-petster/auc.tex
%

labels_feature = struct();
labels_feature.degdiff = 'Degree difference';
labels_feature.friend = 'Friend\textsuperscript{a}';
labels_feature.jaccard = 'Jaccard index';
labels_feature.cn = 'Common friends';
labels_feature.raceeq = 'Same race';
labels_feature.sexeq = 'Same sex';
labels_feature.joinedeq = 'Same join date';
labels_feature.joineddiff = 'Join date difference';
labels_feature.latlongeq = 'Same location';
labels_feature.birthdaydiff = 'Birth date difference';
labels_feature.joinagediff = 'Join age difference';
labels_feature.coloringeq = 'Same coloration\textsuperscript{b}';
labels_feature.weightdiff = 'Weight difference\textsuperscript{c}';
labels_feature.weighteq = 'Same weight\textsuperscript{c}';

names = petster_names_feature(); 
species = { 'cat'; 'dog'; 'hamster' }; 

auc = struct(); 
reg = struct(); 
regauc = struct(); 
for i = 1 : length(species)
    i
    sp = species{i}
    auc.(sp) = load(sprintf('dat-petster/auc.%s.mat', sp));
    reg.(sp) = load(sprintf('dat-petster/reg.%s.mat', sp)); 
    regauc.(sp) = load(sprintf('dat-petster/regauc.%s.mat', sp)); 
end

OUT = fopen('tex-petster/auc.tex', 'w');
if OUT < 0,  error('tex-petster/auc.tex');  end;

fprintf(OUT, '\\begin{tabular}{ l | r r r | r r r }\n');
fprintf(OUT, '\\toprule\n');
fprintf(OUT, ' & \\multicolumn{3}{c|}{\\textbf{AUC}} & \\multicolumn{3}{c}{\\textbf{Regression weights}} \\\\ \n');
fprintf(OUT, '\\textbf{Feature} & \\textbf{Cat} & \\textbf{Dog} & \\textbf{Ham.} & \\textbf{Cat} & \\textbf{Dog} & \\textbf{Ham.} \\\\ \n'); 
fprintf(OUT, '\\midrule\n');

for i = 1 : length(names)
    i
    name = names{i}
    label = labels_feature.(name)
    fprintf(OUT, '%s ', label); 
    % footnote = 0;
    % if strcmp(name, 'friend'),      footnote = 'a';  end;
    % if strcmp(name, 'coloringeq'),  footnote = 'b';  end;

    for j = 1 : length(species)
        sp = species{j}
        auc_sp = auc.(sp).auc;
        if isfield(auc_sp, name) 
            fprintf(OUT, ' & $%.1f\\%%$ ', 100 * auc_sp.(name));
        else
            fprintf(OUT, ' & --- '); 
        end
    end

    for j = 1 : length(species)
        sp = species{j}
        reg_sp = reg.(sp).w;
        if isfield(reg_sp, name) 
            fprintf(OUT, ' & $%.2f$ ', reg_sp.(name));
        else
            fprintf(OUT, ' & --- '); 
        end
    end

    fprintf(OUT, '\\\\ \n'); 
end

% Inter
fprintf(OUT, '%s ', 'Intercept'); 
for j = 1 : length(species)
  fprintf(OUT, ' & --- ');
end
for j = 1 : length(species)
  fprintf(OUT, ' & $%.2f$ ', reg.(species{j}).one);
end
fprintf(OUT, '\\\\ \n'); 

fprintf(OUT, '\\midrule\n');

fprintf(OUT, 'Regression ');

for j = 1 : length(species)
    sp = species{j}
    value = regauc.(sp).auc
    fprintf(OUT, ' & $%.1f\\%%$ ', 100 * value); 
end

fprintf(OUT, '\\\\ \n'); 

fprintf(OUT, '\\bottomrule\n');

fprintf(OUT, '\\multicolumn{7}{l}{\\textsuperscript{a} Hamsterster does not allow friendship links within one household. } \\\\ \n');
fprintf(OUT, '\\multicolumn{7}{l}{\\textsuperscript{b} Dogster does not allow to specify a dog''s coloration.} \\\\ \n');
fprintf(OUT, '\\multicolumn{7}{l}{\\textsuperscript{c} Catster allows exact weights and Dogster has weight ranges.} \\\\ \n');

fprintf(OUT, '\\end{tabular}\n');

if fclose(OUT) < 0,  error('tex-petster/auc.tex');  end;
