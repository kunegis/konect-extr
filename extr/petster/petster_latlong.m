%
% Plot distribution of locations.
%
% PARAMETERS 
%	$SPECIES
%
% INPUT FILES 
%	dat-petster/ent.petster-$SPECIES.latlong
%
% OUTPUT FILES 
% 	plot-petster/latlong.a.$SPECIES.eps
%

inverse_density = 400; 

species = getenv('SPECIES');

colors = petster_colors(); 

color = colors.(species); 

filename = 'map/Blank_Map_Equirectangular_states.light.png';
%%filename = 'map/equidistant_cylindrical.png';
%%filename = 'map/Projection_4326.png';
%%filename = 'map/projection_plate_carree.png';

offset_lat  = +3;	fact_lat  = 1.03;
offset_long = -5;	fact_long = 0.97;

I = imread(filename);

I = double(I); 

size_I = size(I)

if size(I,3) == 1
    I(1:size(I,1), 1:size(I,2), 2) = I;
    I(1:size(I,1), 1:size(I,2), 3) = I(:,:,1); 
end

if max(max(max(I))) > 1
    I = double(I) / max(max(max(I)));
end

assert(min(min(min(I))) >= 0);
assert(max(max(max(I))) <= 1);

res_lat = size(I,1)
res_lng = size(I,2)

% Max points per pixel
k = inverse_density / res_lat / res_lng * 256 * 128; 

M = load(sprintf('dat-petster/ent.petster-%s.latlong', species));

M(:,1) = M(:,1) * fact_lat  + offset_lat;
M(:,2) = M(:,2) * fact_long + offset_long;

M_1_min = min(M(:,1))
M_1_max = max(M(:,1))
M_2_min = min(M(:,2))
M_2_max = max(M(:,2))

H = zeros(res_lat, res_lng); 

for i = 1 : size(M,1)
    lat = M(i,1);
    lng = M(i,2);
    if ~isfinite(lat),  continue;  end; 
    x = 1 + floor((-lat + 90)  / 180 * res_lat);
    y = 1 + floor(( lng + 180) / 360 * res_lng);
    if (x == 1 + res_lat),  x = res_lat;  end;
    if (y == 1 + res_lng),  y = res_lng;  end;
    assert(x >= 1 && x <= res_lat); 
    assert(y >= 1 && y <= res_lng); 
    H(x,y) = H(x,y) + 1/k;
end

% Cut off values over 1
H = min(1, H); 

H_beg = H(50:60, 80:90)
I_beg = I(50:60, 80:90)

color_1 = color(1)

for i = 1 : 3
    I(1:res_lat,1:res_lng,i) = I(1:res_lat,1:res_lng,i) .* (-H + 1) + color(i) * H;
end

image(I);

axis off; 

konect_print(sprintf('plot-petster/latlong.a.%s.eps', species));

