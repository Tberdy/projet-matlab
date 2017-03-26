function effetTremolo = tremolo(y2, Fs, slider_data, slider_data2)

% Pour réaliser l'effet tremolo on applique à chaque instant de la piste
% audio une modification qui dépend de la force de l'effet (slider_data),
% de l'intensité de l'effet (slider_data2) et du taux d'échantillonnage (Fs)

% Pré-alloue la variable de retour pour optimiser le traitement
effetTremolo = 1:length(y2);
effetTremolo = zeros(size(effetTremolo));

for i = 1:length(y2)
    effetTremolo(i)= y2(i) * (1 + slider_data * sin(2 * pi * i * (slider_data2 / Fs)))';
end
