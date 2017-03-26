function effetFilter = filter_low(y, Fs, slider_data, handles)

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
if(slider_data ==0)
    effetFilter = 0;
else   
    [low1,low2] = butter(4, (500)/(Fs/2),'low');
    effetFilter = slider_data*filter(low1, low2, yI); 
    filt = tf(low1,low2); 
    
    % On affiche le diagramme de bode
    axes(handles.bode_axes)
    bode(filt); 
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
