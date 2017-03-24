function y = wobble(y,Fs, value_slider1, value_slider2)
[y1, y2, y3] = size(y);
if (y3 == 3)
    yI = (y(:,1)+y(:,2)+y(:,3))/3;
elseif (y2 == 2)
    yI = (y(:,1)+y(:,2))/2;
else
    yI = y;
end
value_slider = value_slider/Fs;
for i=1:length(yI),
    
    wav = 0.1*sin(2*pi*value_slider*i);
    
    [low1,low2] = butter(2, value_slider2+wav ,'low'); %
    % Pour la bandpass il faut avoir un vecteur de deux éléments! comprit
    % entre 0 et 1
    [mid1,mid2] = butter(2, [wav+value_slider2+0.1 wav+value_slider2-0.1],'bandpass');
    %[wav+value_slider2-0.1 wav+value_slider2+0.1]
    effect_filter(i) = filter(low1,low2,yI(i)) + 2*filter(mid1,mid2,yI(i));
end

