%
% Generate the Latex table containing the homophily analysis.
%
% INPUT 
%	dat-petster/homophily.hamster.mat
%	dat-petster/homophily.cat.mat
%	dat-petster/homophily.dog.mat
%
% OUTPUT 
%	tex-petster/homophily.tex
%

h_hamster = load('dat-petster/homophily.hamster.mat');
h_cat = load('dat-petster/homophily.cat.mat');
h_dog = load('dat-petster/homophily.dog.mat');

features = { 'race'; 'sex'; 'coloring'; 'weightrange'; ...
             'degree'; 'birthday'; 'joined'; 'joinage'; 'weight'; 'latlong' };

labels_feature = struct();
labels_feature.race        = 'Race\textsuperscript{a}';
labels_feature.sex         = 'Sex\textsuperscript{a}';
labels_feature.coloring    = 'Coloration\textsuperscript{a}';
labels_feature.weightrange = 'Weight range\textsuperscript{a,c}';
labels_feature.degree      = '\#Friends\textsuperscript{b}'; 
labels_feature.birthday    = 'Birth date\textsuperscript{b}';
labels_feature.joined      = 'Join date\textsuperscript{b}';
labels_feature.joinage     = 'Join age\textsuperscript{b}';
labels_feature.weight      = 'Weight\textsuperscript{b,d}';
labels_feature.latlong     = 'Location\textsuperscript{e}'; 

%
% Output 
%

OUT = fopen('tex-petster/homophily.tex', 'w');
if OUT < 0,  error;  end;

fprintf(OUT, '\\begin{tabular}{ l | llr | llr | llr } \n');
fprintf(OUT, '\\toprule \n');
fprintf(OUT, '& \\multicolumn{3}{c|}{\\textbf{Catster}} \n');
fprintf(OUT, '& \\multicolumn{3}{c|}{\\textbf{Dogster}} \n');
fprintf(OUT, '& \\multicolumn{3}{c}{\\textbf{Hamsterster}} \\\\ \n');
fprintf(OUT, '& \\textbf{\\quad $r_{\\mathrm p}$} & \\textbf{\\quad $r_{\\mathrm a}$} & \\textbf{$r_{\\mathrm rel}$} & \\textbf{\\quad $r_{\\mathrm p}$} ');
fprintf(OUT, '& \\textbf{\\quad $r_{\\mathrm a}$} & \\textbf{$r_{\\mathrm rel}$} & \\textbf{\\quad $r_{\\mathrm p}$} & \\textbf{\\quad $r_{\\mathrm a}$} & \\textbf{$r_{\\mathrm rel}$} \\\\ \n');
fprintf(OUT, '\\midrule \n');

for i = 1 : length(features)
    feature = features{i}
    fprintf(OUT, '%s ', labels_feature.(feature));

    [text_f_hamster text_h_hamster text_rel_hamster] = petster_homophily_format(h_hamster, feature);
    [text_f_cat     text_h_cat     text_rel_cat]     = petster_homophily_format(h_cat,     feature);
    [text_f_dog     text_h_dog     text_rel_dog]     = petster_homophily_format(h_dog,     feature);

    fprintf(OUT, '& %s & %s & %s & %s & %s & %s & %s & %s & %s ', ...
            text_f_cat, text_h_cat, text_rel_cat, ...
            text_f_dog, text_h_dog, text_rel_dog, ...
            text_f_hamster, text_h_hamster, text_rel_hamster); 

    fprintf(OUT, '\\\\ \n'); 
end

fprintf(OUT, '\\bottomrule \n'); 
fprintf(OUT, '\\multicolumn{10}{l}{$^{++}$ and $^{+}$ denote an estimate on the error of less than 0.1\\%% and 1\\%%, respectively \\cite[Eq. (5)]{b854}} \\\\ \n'); 
fprintf(OUT, '\\multicolumn{10}{l}{$^{**}$ and $^{*}$ denote a $p$-value of less than 0.001 and 0.01, respectively} \\\\ \n');
fprintf(OUT, '\\multicolumn{10}{l}{\\textsuperscript{a} Categorical variable; numbers denote the assortativity coefficient \\cite[Eq. (2)]{b854}} \\\\ \n'); 
fprintf(OUT, '\\multicolumn{10}{l}{\\textsuperscript{b} Numerical variable; numbers denote the Pearson correlation coefficient \\cite[Eq. (21)]{b854}} \\\\ \n'); 
fprintf(OUT, '\\multicolumn{10}{l}{\\textsuperscript{c} In Dogster, the weight can only be chosen from a predefined set of ranges} \\\\ \n'); 
fprintf(OUT, '\\multicolumn{10}{l}{\\textsuperscript{d} In Catster, the exact pet weight can be specified} \\\\ \n'); 
fprintf(OUT, '\\multicolumn{10}{l}{\\textsuperscript{e} Not computed for households as all pets in one household share their location; geographical variable,} \\\\ \n');
fprintf(OUT, '\\multicolumn{10}{l}{\\phantom{\\textsuperscript{e}} numbers denote the distance correlation \\cite{b855}} \\\\ \n');
fprintf(OUT, '\\end{tabular} \n');

if fclose(OUT) < 0;  error;  end;

