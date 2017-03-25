function effect_amplification = amplification(y2, value_slider)
%Idem que pour l'attenuation mais la on change le premier coef!

effect_amplification = filter(value_slider,1,y2);