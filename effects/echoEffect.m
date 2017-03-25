function effect_echo = echoEffect(y2, Fs ,value_slider)

%L'utilisateur peut choisir le retard de l'echo
i = round(value_slider);
z = 1; %C'est le compteur pour l'attenuation progressive de l'echo
for n=i+1:length(y2)
    z = z+1; %Condition d'attenuation.
    if(z == 3) %Après une attenuation x3 on revient initialement avec 0 attenuation.
        z=1;
    end
    y2(n-i) = filter(1,z,y2(n-i)); %On attenue progressivement le son qui est en retard
    
    effect_echo(n)=y2(n)+y2(n-i); %On affecte le nouveau signal après l'effet echo
end