function effetAmplification = amplification(y2, slider_data)

% On utilise la fonction filter() qui réalise la transformée en Z des
% données audio
% filter() filtre les données audio y2 grâce aux coefficients du 
% numérateur (slider_data) et du dénominateur (1)
% Si l'on augmente la valeur du slider, cela augmente la valeur du
% coefficient du numérateur et cela amplifie la piste audio

effetAmplification = filter(slider_data,1,y2);