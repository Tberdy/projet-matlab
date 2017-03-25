function effect_tremolo = tremolo(y2, Fs, value_slider, value_slider2)
%Fr�quence coeff : value_slider2;
%value_slider : coef pour l'effet
%On fait vari� l'amplitude du signal d'entree avec une boucle allant de 1 �
%la taille du signal d'entr�e.
for i = 1:length(y2)
    effect_tremolo(i)= y2(i)*(1+ value_slider*sin(2*pi*i*(value_slider2/Fs)))';
end
