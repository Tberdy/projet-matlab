function effetFilter = filter_mid(y, Fs, slider_data, handles)

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

% Filtre passe bande
% Si le slider est à la valeur par défault (0) on désactive l'effet
if(slider_data ==0)
    effetFilter = 0;
else
    [mid1,mid2] = butter(4, [500 2000]/(Fs/2),'bandpass');
    effetFilter = slider_data*filter(mid1, mid2, yI); 
    filt = tf(mid1,mid2); 
    
    % On affiche le diagramme de bode
    axes(handles.bode_axes)
    bode(filt); 
    set(handles.bode_axes,'XColor',[1 1 1]);
    set(handles.bode_axes,'YColor',[1 1 1]);
    
    % On affiche le diagramme de pole zero
    axes(handles.polezero_axes)
    z = roots(mid1); %zeros
    p = roots(mid2); %poles

    scatter(real(z),imag(z),'o');
    hold on
    scatter(real(p),imag(p),'x');
    grid
    axis equal

    set(handles.polezero_axes,'XColor',[1 1 1]);
    set(handles.polezero_axes,'YColor',[1 1 1]);
end
