function effetAttenuation = attenuation(y2, slider_data)

% On utilise la fonction filter() qui réalise la transformée en Z des
% données audio
% filter() filtre les données audio y2 grâce aux coefficients du 
% numérateur (1) et du dénominateur (slider_data)
% Si l'on augmente la valeur du slider, cela augmente la valeur du
% coefficient du dénominateur et cela atténue la piste audio

effetAttenuation = filter(1,slider_data,y2);