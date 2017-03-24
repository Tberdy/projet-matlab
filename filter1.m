function effect_filter = filter1(y, Fs ,value_slider, value_slider2, value_slider3,handles)

%Afin de diminuer au minimum le temps de calcule on divise le signal
%d'entrée par 3 en prenant les 3 premiers samples.
[y1, y2, y3] = size(y);
if (y3 == 3)
    yI = (y(:,1)+y(:,2)+y(:,3))/3;
elseif (y2 == 2)
    yI = (y(:,1)+y(:,2))/2;
else
    yI = y;
end

%Filtre passe bas
if(value_slider == 0) %Si le slider est à 0, pas de filtre laissant passer les basses fréquences
    effect_filter_low = 0;
    filt1 = 0;
else
    [low1,low2] = butter(4, (500)/(Fs/2),'low'); %Butterworth
    effect_filter_low = value_slider*filter(low1, low2, yI); %On récupère les données après traitment du filtre
    filt1 = tf(low1,low2); %Fonction de transfert du filtre passe bas.
end

%Filtre passe bande
if(value_slider2 ==0) %Si le slider est à 0, pas de filtre laissant passer les moyennes fréquences
    effect_filter_mid = 0;
    filt2 = 0;
else   
    [mid1,mid2] = butter(4, [500 2000]/(Fs/2),'bandpass'); %Butterworth
    effect_filter_mid = value_slider2*filter(mid1, mid2, yI); %On récupère les données après traitment du filtre
    filt2 = tf(mid1,mid2); %Fonction de transfert du filtre passe bande.
end

%Filtre passe haut
if(value_slider3 ==0)
    effect_filter_high = 0; %Si le slider est à 0, pas de filtre laissant passer les hautes fréquences
    filt3 = 0;
else   
    [high1,high2] = butter(4, 2000/(Fs/2),'high');
    effect_filter_high = value_slider3*filter(high1, high2, yI); %On récupère les données après traitment du filtre
    filt3 = tf(high1,high2); %Fonction de transfert du filtre passe haut.
end

%Affichage du bode et on revoit les nouvelles données du signal traité
if(value_slider3 == 0 && value_slider2 == 0 && value_slider ==0)
    effect_filter = 0;
else
    effect_filter = effect_filter_low + effect_filter_mid + effect_filter_high; %On renvoit le signal après traitement des 3 filtres
    axes(handles.bode_axes)
    %On affiche bode de nos filtres sur notre interface graphique
    bode(filt1 + filt2 + filt3); 
    fvtool(high1,high2,low1,low2,mid1,mid2,'FrequencyScale','log'); %Autre Affichage complémentaire.
    set(handles.bode_axes,'XColor',[1 1 1]);
    set(handles.bode_axes,'YColor',[1 1 1]);
end



