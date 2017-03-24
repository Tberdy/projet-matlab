function effect_distortion = distortion(y2, Fs ,value_slider,value_slider2)

%value_slider2 : mix
%value_slider : gain

%On utilise la fonction mathématique pour la distortion du signal.
function_1 = y2 * value_slider / max(abs(y2));

%Idem pour ici
function_distortion = sign(-function_1).*(1-exp(sign(-function_1).*function_1));

%Ensuite on fait une boucle allant de 1 à la taille du signal y2 reçu en
%parametre. On suit toujours la fonction mathématique afin de retourner la
%distortion.
for i = 1:length(y2);
    effect_distortion(i) = value_slider2*function_distortion(i)*max(abs(y2(i)))/max(abs(function_distortion(i))+(1-value_slider2)*y2(i));
    effect_distortion(i) = effect_distortion(i)* max(abs(y2(i)))/max(abs(effect_distortion(i)));
end