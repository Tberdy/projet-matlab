function effect_flanger = flanger(y, Fs ,value_slider , value_slider2)
%value_slider : delay entre 1% et 10%) Petit delai pour le flanger
%value_slider2 : percentage of flange
%Idem que pour les autres filtres, on divise le signal d'entrée par deux en
%utilisant les deux premier sample.
[y1, y2, y3] = size(y);
if (y3 == 3)
    yI = (y(:,1)+y(:,2)+y(:,3))/3; %on sélectionne toutes les lignes :, de la 1er colonne. etc..
elseif (y2 == 2)
    yI = (y(:,1)+y(:,2))/2;
else
    yI = y;
end

n=length(yI); % Connaitre la longueur du signal
M=1:n; %Création d'une matrice allant de 1 à la longueur du signal n
r=round(value_slider*Fs); %On veut avoir un int donc on arrondi!
%Delai * le rate du signal!
f0=value_slider2/Fs; % % of flange / rate du signal

matrice_sin=sin(2*pi*M*f0);
%On utilise la fct mathématique pour modifier le signal ! (effet flanger)
for i = 1:r, %boucle allant de 1 à r
    effect_flanger(i)=yI(i); 
    for i=(r+1):n, %boucle allant de r+1 à n
        matrice_sin_abs=abs(matrice_sin(i));
        matrice_sin_delay=ceil(matrice_sin_abs*r);
        effect_flanger(i)=yI(i)+yI(i-matrice_sin_delay); % On renvoit le résulat avec le délai
    end
end

