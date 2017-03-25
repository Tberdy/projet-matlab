function effect_attenuation = attenuation(y2, value_slider)
%Ici nous utilisons la fonction filter appartenant à matlab
%Cette fonction contient 3 paramètres
%Le premier c''est le coef au numérateur de la tranformée en Z
%du signal y2!
%Le deuxième coef c'est le dénominateur!
%Il suffit d'augmenter le dénominateur afin de baisser l'amplitude
%du sans modifier le reste de la musique
%Il permet donc de faire varier l'amplitude des fréquences!

effect_attenuation = filter(1,value_slider,y2);