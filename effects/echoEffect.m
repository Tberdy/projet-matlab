function effetEcho = echoEffect(y2, slider_data)

% 
% i est le retard de l'�cho, d�fini par l'utilisateur gr�ce au slider
% z est compteur pour l'attenuation progressive de l'effet d'�cho
i = round(slider_data);
z = 1; 

% Pr�-alloue la variable de retour pour optimiser le traitement
effetEcho = i+1:length(y2);
effetEcho = zeros(size(effetEcho));

for n=i+1:length(y2)
    z = z+1;
    
    % Si le son a �t� att�nu� 3 fois on revient � une att�nuation normale.
    if(z == 3) 
        z=1;
    end
    % On att�nue progressivement le son qui est en retard (cf fonction
    % attenuation)
    y2(n-i) = filter(1,z,y2(n-i)); 
    
    % On affecte le son g�n�r� 
    effetEcho(n)=y2(n)+y2(n-i);
end