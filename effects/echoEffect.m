function effetEcho = echoEffect(y2, slider_data)

% 
% i est le retard de l'écho, défini par l'utilisateur grâce au slider
% z est compteur pour l'attenuation progressive de l'effet d'écho
i = round(slider_data);
z = 1; 

% Pré-alloue la variable de retour pour optimiser le traitement
effetEcho = i+1:length(y2);
effetEcho = zeros(size(effetEcho));

for n=i+1:length(y2)
    z = z+1;
    
    % Si le son a été atténué 3 fois on revient à une atténuation normale.
    if(z == 3) 
        z=1;
    end
    % On atténue progressivement le son qui est en retard (cf fonction
    % attenuation)
    y2(n-i) = filter(1,z,y2(n-i)); 
    
    % On affecte le son généré 
    effetEcho(n)=y2(n)+y2(n-i);
end