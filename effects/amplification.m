function effetAmplification = amplification(y2, slider_data)

% On utilise la fonction filter() qui r�alise la transform�e en Z des
% donn�es audio
% filter() filtre les donn�es audio y2 gr�ce aux coefficients du 
% num�rateur (slider_data) et du d�nominateur (1)
% Si l'on augmente la valeur du slider, cela augmente la valeur du
% coefficient du num�rateur et cela amplifie la piste audio

effetAmplification = filter(slider_data,1,y2);