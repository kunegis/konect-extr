
function [text_f text_a text_rel] = petster_homophily_format(h, feature)

frmt = '$%s%.4f%s$';


%
% Friendship
%

if ~ isfield(h.h_f, feature)
    text_f = '\qquad---';
elseif strcmp(h.t_f.(feature), 'number')

    rho = full(h.h_f.(feature))
    p = full(h.p_f.(feature))

    if rho < 0,  fminus = '{-}';  else,  fminus = '\phantom{-}';  end
    % if abs(rho) < 0.1  fzero = '\phantom{0}';  else,  fzero = '';  end
    % if rho < 0 && abs(rho) < 0.1,  fminus = '\phantom{0}'; fzero = '{-}';  end

    if     p < 1e-3,      ptext = '^{**}';   
    elseif p < 1e-2,      ptext = '^{*}';
    else                  ptext = '';
    end

    text_f = sprintf(frmt, fminus, abs(rho), ptext); 

elseif strcmp(h.t_f.(feature), 'category')

    rho = full(h.h_f.(feature))
    rho_sigma = full(h.p_f.(feature))
    sigmas = abs(rho / rho_sigma)

    if rho < 0,  fminus = '{-}';  else,  fminus = '\phantom{-}';  end
    % if abs(rho) < 0.1  fzero = '\phantom{0}';  else,  fzero = '';  end
    % if rho < 0 && abs(rho) < 0.1,  fminus = '\phantom{0}'; fzero = '{-}';  end

    if     sigmas > 1000,   ptext = '^{++}';
    elseif sigmas >  100,   ptext = '^{+}';
    else                    ptext = '';
    end

    text_f = sprintf(frmt, fminus, abs(rho), ptext); 
else
    error;
end

%
% Household
%

if ~ isfield(h.h_h, feature)
    text_a = '\qquad---';
elseif strcmp(h.t_h.(feature), 'number')

    rho = full(h.h_h.(feature))
    p = full(h.p_h.(feature))

    if rho < 0,  fminus = '{-}';  else,  fminus = '\phantom{-}';  end
    % if abs(rho) < 0.1  fzero = '\phantom{0}';  else,  fzero = '';  end
    % if rho < 0 && abs(rho) < 0.1,  fminus = '\phantom{0}'; fzero = '{-}';  end

    if     p < 1e-3,      ptext = '^{**}';   
    elseif p < 1e-2,      ptext = '^{*}';
    else                  ptext = '';
    end

    text_a = sprintf(frmt, fminus, abs(rho), ptext); 

elseif strcmp(h.t_h.(feature), 'category')

    rho = full(h.h_h.(feature))
    rho_sigma = full(h.p_h.(feature))
    sigmas = abs(rho / rho_sigma)

    if rho < 0,  fminus = '{-}';  else,  fminus = '\phantom{-}';  end
    % if abs(rho) < 0.1  fzero = '\phantom{0}';  else,  fzero = '';  end
    % if rho < 0 && abs(rho) < 0.1,  fminus = '\phantom{0}'; fzero = '{-}';  end

    if     sigmas > 100,   ptext = '^{++}';
    elseif sigmas >  10,   ptext = '^{+}';
    else                   ptext = '';
    end

    text_a = sprintf(frmt, fminus, abs(rho), ptext); 
else
    error; 
end

%
% Relative value
%

if (~ isfield(h.h_f, feature)) | (~ isfield(h.h_h, feature))
    text_rel = '---'; 
else
    rho_f = full(h.h_f.(feature))
    rho_a = full(h.h_h.(feature))
    rho_rel = abs(rho_a / rho_f)
    text_rel = sprintf('%.3f', rho_rel) 
end
