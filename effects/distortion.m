function effetDistortion = distortion(y2, Fs, slider_data, slider_data2)

% L'effet dépend du gain (slider_data) et du mix (slider_data2) choisi par
% l'utilisateur

% Pré-alloue la variable de retour pour optimiser le traitement
effetDistortion = 1:length(y2);
effetDistortion = zeros(size(effetDistortion));

% On utilise la fonction mathématique pour la distortion du signal.
function_1 = y2 * slider_data / max(abs(y2));
function_distortion = sign(-function_1).*(1-exp(sign(-function_1).*function_1));

% Pour chaque instant de la piste audio on applique la fonction
% mathématique
for i = 1:length(y2)
    effetDistortion(i) = slider_data2*function_distortion(i)*max(abs(y2(i)))/max(abs(function_distortion(i))+(1-slider_data2)*y2(i));
    effetDistortion(i) = effetDistortion(i)* max(abs(y2(i)))/max(abs(effetDistortion(i)));
end