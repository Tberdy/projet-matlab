function effetFilter = filter1(y, Fs , slider_data, slider_data2, slider_data3,handles)

[y1, y2, y3] = size(y);
if (y3 == 3)
    yI = (y(:,1)+y(:,2)+y(:,3))/3;
elseif (y2 == 2)
    yI = (y(:,1)+y(:,2))/2;
else
    yI = y;
end


% Pour chaque filtre, si l'effet est activé
% 1. On applique le filtre de Butterworth
% 2. On calcule la fonction de transfert

% Filtre passe bas
% Si le slider est à la valeur par défault (0) on désactive l'effet
if(slider_data == 0)
    effetFilter_low = 0;
    filt1 = 0;
else
    [low1,low2] = butter(4, (500)/(Fs/2),'low'); 
    effetFilter_low = slider_data*filter(low1, low2, yI);
    filt1 = tf(low1,low2); 
end

% Filtre passe bande
% Si le slider est à la valeur par défault (0) on désactive l'effet
if(slider_data2 ==0)
    effetFilter_mid = 0;
    filt2 = 0;
else   
    [mid1,mid2] = butter(4, [500 2000]/(Fs/2),'bandpass');
    effetFilter_mid = slider_data2*filter(mid1, mid2, yI); 
    filt2 = tf(mid1,mid2);
end

% Filtre passe haut
% Si le slider est à la valeur par défault (0) on désactive l'effet
if(slider_data3 ==0)
    effetFilter_high = 0;
    filt3 = 0;
else   
    [high1,high2] = butter(4, 2000/(Fs/2),'high');
    effetFilter_high = slider_data3*filter(high1, high2, yI); 
    filt3 = tf(high1,high2); 
end

% Si tous les filtres sont désactivés, on renvoit 0
if(slider_data3 == 0 && slider_data2 == 0 && slider_data ==0)
    effetFilter = 0;
else
    % On combine le résultat des trois filtres
    effetFilter = effetFilter_low + effetFilter_mid + effetFilter_high; 
    
    % On affiche le diagramme de bode
    axes(handles.bode_axes)
    bode(filt1 + filt2 + filt3); 
    set(handles.bode_axes,'XColor',[1 1 1]);
    set(handles.bode_axes,'YColor',[1 1 1]);
    
    % On affiche le diagramme de pole zero
    axes(handles.polezero_axes)
    z = roots(low1); %zeros
    p = roots(low2); %poles

    scatter(real(z),imag(z),'o');
    hold on
    scatter(real(p),imag(p),'x');
    grid
    axis equal

    set(handles.polezero_axes,'XColor',[1 1 1]);
    set(handles.polezero_axes,'YColor',[1 1 1]);
end



