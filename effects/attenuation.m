function effect_attenuation = attenuation(y2, value_slider)
%Ici nous utilisons la fonction filter appartenant � matlab
%Cette fonction contient 3 param�tres
%Le premier c''est le coef au num�rateur de la tranform�e en Z
%du signal y2!
%Le deuxi�me coef c'est le d�nominateur!
%Il suffit d'augmenter le d�nominateur afin de baisser l'amplitude
%du sans modifier le reste de la musique
%Il permet donc de faire varier l'amplitude des fr�quences!

effect_attenuation = filter(1,value_slider,y2);