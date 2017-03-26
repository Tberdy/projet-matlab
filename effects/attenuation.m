function effetAttenuation = attenuation(y2, slider_data)

% On utilise la fonction filter() qui r�alise la transform�e en Z des
% donn�es audio
% filter() filtre les donn�es audio y2 gr�ce aux coefficients du 
% num�rateur (1) et du d�nominateur (slider_data)
% Si l'on augmente la valeur du slider, cela augmente la valeur du
% coefficient du d�nominateur et cela att�nue la piste audio

effetAttenuation = filter(1,slider_data,y2);