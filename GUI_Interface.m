function varargout = GUI_Interface(varargin)
% GUI_INTERFACE MATLAB code for GUI_Interface.fig
%      GUI_INTERFACE, by itself, creates a new GUI_INTERFACE or raises the existing
%      singleton*.
%
%      H = GUI_INTERFACE returns the handle to a new GUI_INTERFACE or the handle to
%      the existing singleton*.
%
%      GUI_INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_INTERFACE.M with the given input arguments.
%
%      GUI_INTERFACE('Property','Value',...) creates a new GUI_INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Interface

% include effects
addpath('./effects/');

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Interface_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% initialisation de l'interface graphique (GUI) lors du lancement du
% programme

% --- Executes just before GUI_Interface is made visible.
function GUI_Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Interface (see VARARGIN)

% Choose default command line output for GUI_Interface
handles.output = hObject;
handles.player=0;

% Création du fond d'écran 
% 1. affichage d'un graphe en plein écran
% 2. importation d'une image et affichage de celle-ci sur le graphe
% 3. verrouillage du graphe en arrière plan
gui = axes('unit', 'normalized', 'position', [0 0 1 1]);
image = imread('img/theme.png'); 
imagesc(image);
set(gui,'handlevisibility','off','visible','off')
uistack(gui, 'bottom');


% initialisation des différents sliders à des valeurs par défault
set(handles.slider_attenuation, 'min', 1);
set(handles.slider_attenuation, 'max', 50);
set(handles.slider_attenuation, 'Value', 1);

set(handles.slider_amplification, 'min', 1);
set(handles.slider_amplification, 'max', 10);
set(handles.slider_amplification, 'Value', 1);

set(handles.slider_tremolo, 'min', 0.1);
set(handles.slider_tremolo, 'max', 3);
set(handles.slider_tremolo, 'Value', 0.1);
set(handles.slider_tremolo2, 'min', 1);
set(handles.slider_tremolo2, 'max', 50);
set(handles.slider_tremolo2, 'Value', 1);

set(handles.slider_echo, 'min', 5000);
set(handles.slider_echo, 'max', 50000);
set(handles.slider_echo, 'Value', 5000);

set(handles.slider_distortion, 'min', 0);
set(handles.slider_distortion, 'max', 10);
set(handles.slider_distortion, 'Value', 0);
set(handles.slider_distortion2, 'min', 1);
set(handles.slider_distortion2, 'max', 10);
set(handles.slider_distortion2, 'Value', 1);

set(handles.slider_flanger, 'min', 0.001);
set(handles.slider_flanger, 'max', 0.01);
set(handles.slider_flanger, 'Value', 0.001);
set(handles.slider_flanger2, 'min', 1);
set(handles.slider_flanger2, 'max', 10);
set(handles.slider_flanger2, 'Value', 1);

set(handles.slider_filter1, 'min', 0);
set(handles.slider_filter1, 'max', 2);
set(handles.slider_filter1, 'Value', 1);
set(handles.slider_filter2, 'min', 0);
set(handles.slider_filter2, 'max', 2);
set(handles.slider_filter2, 'Value', 1);
set(handles.slider_filter3, 'min', 0);
set(handles.slider_filter3, 'max', 2);
set(handles.slider_filter3, 'Value', 1);

set(handles.slider_wobble, 'min', 1);
set(handles.slider_wobble, 'max', 10);
set(handles.slider_wobble, 'Value', 1);
set(handles.slider_wobble2, 'min', 0.3);
set(handles.slider_wobble2, 'max', 0.7);
set(handles.slider_wobble2, 'Value', 0.3);

set(handles.slider_deceleration, 'Value', 1);
set(handles.slider_acceleration, 'Value', 1);


% activation de la vue "Temporelle" par défault
set(handles.frequencial_display,'Value',0);
set(handles.temporal_display,'Value',1);

% mise à jour des données du GUI
guidata(hObject, handles);

% UIWAIT makes GUI_Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in import.
function import_Callback(hObject, eventdata, handles)
% hObject    handle to import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% importation d'un fichier au format .wav dans matlab
% 1. on ouvre un explorateur pour sélectionner un fichier
% 2. on lit les données du fichier avec la fonction audioread() :
% -> y : les données audio
% -> Fs : le taux d'échantillonnage 
% 3. On stocke les données (audio et taux d'échantillonnage) en double dans
% le buffer handle. Le stockage se fait en double car il y a la version
% originale et la version que nous allons modifier
% 4. On renvoit le buffer handle au GUI
file_name = uigetfile; 
set(handles.path,'String',file_name);
[y,Fs]=audioread(file_name); 
handles.y1=y; 
handles.y2=y; 
handles.Fs=Fs;
handles.Fs2=Fs;
guidata(hObject,handles); 
    
% Lancement d'une piste audio en mode normal
% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Lecture de la piste audio
% 1. On recupère les données audio (y) et le taux d'échantillonnage (Fs) depuis le
% buffer 
% 2. On crée un objet de type audioplayer pour jouer notre piste audio
% 3. On lance la piste audio
% 4. On renvoit le buffer au GUI
y=handles.y1; 
Fs=handles.Fs; 
handles.player=audioplayer(y,Fs);
play(handles.player);
guidata(hObject,handles);

% Affichage des données audio
% 1. On sélectionne le graphe original_wave
% 2. On affiche les données audio
% 3. On légende le graphe
% 4. On met de la couleur
axes(handles.original_wave_axes)
plot(y);
xlabel('Time');
ylabel('Amplitude');
set(handles.frequencial_display,'Value',0);
set(handles.temporal_display,'Value',1);
%h = bode(y,Fs);
%axes(handles.bode_axes)
%plot(h);
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);

%POUR JOUER LA MUSIQUE AVEC LEFFET ou LES EFFETS
% --- Executes on button press in play_effect.
function play_effect_Callback(hObject, eventdata, handles)
% hObject    handle to play_effect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Lecture de la piste audio
% 1. On recupère les données audio (y) et le taux d'échantillonnage (Fs) depuis le
% buffer 
% 2. On crée un objet de type audioplayer pour jouer notre piste audio
% 3. On lance la piste audio
% 4. On renvoit le buffer au GUI
handles.player=audioplayer(handles.y2,handles.Fs2); %On stocke en mémoire dans le sub class handle l'audio_player
play(handles.player);%On joue la musique modifié par les effets.
set(handles.frequencial_display,'Value',0); %on met par defaut à 0 l'affichage en fréquence.
set(handles.temporal_display,'Value',1); %On affiche l'affichage temporelle.
guidata(hObject,handles);

% Affichage des données audio
% 1. On sélectionne le graphe original_wave
% 2. On affiche les données audio
% 3. On légende le graphe
% 4. On met de la couleur
axes(handles.modified_wave_axes)
plot(handles.y2);
xlabel('Time');
ylabel('Amplitude');
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);

guidata(hObject,handles);


% Mettre la lecture en pause
% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pause(handles.player);

% Reprendre la lecture
% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)
% hObject    handle to resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resume(handles.player);

% Réinitialisation de l'interface
% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%on supprime les graphes et on arrete la musique

% Réinitialisation de l'interface 
% 1. On arrête la lecture
% 2. On détruit l'instance de l'audioplayer
% 3. On efface les graphes
% 4. On reconfigure la couleur des graphes
stop(handles.player);
delete(handles.player);
cla(handles.original_wave_axes,'reset');
cla(handles.modified_wave_axes,'reset');
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);

% Bode
cla(handles.bode_axes,'reset');
set(handles.bode_axes,'XColor',[1 1 1]);
set(handles.bode_axes,'YColor',[1 1 1]);

% Pole Zero
cla(handles.polezero_axes,'reset');
set(handles.polezero_axes,'XColor',[1 1 1]);
set(handles.polezero_axes,'YColor',[1 1 1]);

%On Réinitialise toutes les données son à 0.
handles.y1=0;
handles.y2=0
% On réinitialise le chemin du fichier .wav
handles.path.String ='Path';
guidata(hObject,handles);
            
% On réinitialise l'affichage de l'activation des filtres
set(handles.text_echo,'String','OFF');
set(handles.text_echo,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_tremolo,'String','OFF');
set(handles.text_tremolo,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_amplification,'String','OFF');
set(handles.text_amplification,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_attenuation,'String','OFF');
set(handles.text_attenuation,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_wobble,'String','OFF');
set(handles.text_wobble,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_flanger,'String','OFF');
set(handles.text_flanger,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_distortion,'String','OFF');
set(handles.text_distortion,'backgroundcolor',[0.5 0.5 .5]);
set(handles.text_filter1,'String','OFF');
set(handles.text_filter1,'backgroundcolor',[0.5 0.5 .5]);

% On réinitialise les sliders à leurs positions initiales
set(handles.slider_amplification, 'Value', 1);
set(handles.slider_attenuation, 'Value', 1);
set(handles.slider_tremolo, 'Value', 0.1);
set(handles.slider_tremolo2, 'Value', 1);
set(handles.slider_echo, 'Value', 5000);
set(handles.slider_distortion, 'Value', 0);
set(handles.slider_distortion2, 'Value', 1);
set(handles.slider_flanger, 'Value', 0.001);
set(handles.slider_flanger2, 'Value', 1);
set(handles.slider_filter1, 'Value', 1);
set(handles.slider_filter2, 'Value', 1);
set(handles.slider_filter3, 'Value', 1);
set(handles.slider_wobble, 'Value', 1);
set(handles.slider_wobble2, 'Value', 0.3);
set(handles.slider_acceleration, 'Value', 1);
set(handles.slider_deceleration, 'Value', 1);

% On réinitialise l'affichage des valeurs des sliders
set(handles.text_value_amplification,'String','1');
set(handles.text_value_attenuation,'String','1');
set(handles.text_value_tremolo,'String','0.1');
set(handles.text_value_tremolo2,'String','1');
set(handles.text_value_echo,'String','5000');
set(handles.text_value_distortion,'String','0');
set(handles.text_value_distortion2,'String','1');
set(handles.text_value_flanger,'String','0.001');
set(handles.text_value_flanger2,'String','1');
set(handles.text_low,'String','1');
set(handles.text_mid,'String','1');
set(handles.text_high,'String','1');
set(handles.text_value_wobble,'String','1');
set(handles.text_value_wobble2,'String','0.2');
set(handles.text_acceleration,'String','Acceleration :');
set(handles.text_deceleration,'String','Deceleration :');

% On réinitialise le sélecteur 
set(handles.popupmenu1, 'Value', 1);


% Sortie de l'application
% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% Sauvegarde de la piste audio modifiée
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name,path_name]=uiputfile('.wav','Sauvegarde la piste audio modifiée','nouveau.wav');
wave_path=fullfile(path_name,file_name);
audiowrite(wave_path,handles.y2,handles.Fs2);
msgbox('La piste audio a été sauvegardée avec succès.');

% Callback du sélecteur des échantillons audio
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 1. Récupération du choix de l'utilisateur 
% 2. Lecture du fichier pour récupérer le taux d'échantillonnage Fs et les
% données audio y
% 3. On stocke ces données dans le buffer en double, pour avoir les données
% originales et les données que l'on modifiera
% 4. On renvoit le buffer à l'interface (GUI) 
choice=get(hObject,'Value');
switch choice 
    case 2
        filename='samples/guitar.wav';
    case 3
        filename='samples/instruments.wav';        
    case 4
        filename='samples/piano.wav';
    case 5
        filename='samples/violant.wav';      
end
set(handles.path,'String',filename);
[y,Fs]=audioread(filename);
handles.y1=y;
handles.y2=y;
handles.Fs=Fs;
handles.Fs2=Fs;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Affichage des signaux en mode temporel.
% --- Executes on button press in temporal_display.
function temporal_display_Callback(hObject, eventdata, handles)
% hObject    handle to temporal_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Affichage des signaux en mode temporel.
% 1. On met à 0 la valeur du sélecteur du mode fréquentiel
% 2. On sélectionne le graphe de la piste originale 
% 3. On affiche les données audio sur la graphe
% 4. On renvoit le buffer au GUI
set(handles.frequencial_display,'Value',0);
axes(handles.original_wave_axes)
plot(handles.y1);
xlabel('Time');
ylabel('Amplitude');
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);

% On fait la même chose pour le graphe du son modifié
axes(handles.modified_wave_axes)
plot(handles.y2);
xlabel('Time');
ylabel('Amplitude');
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);

guidata(hObject,handles); 

% Affichage des signaux en mode fréquenciel.
% --- Executes on button press in frequencial_display.
function frequencial_display_Callback(hObject, eventdata, handles)
% hObject    handle to frequencial_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Affichage des signaux en mode fréquenciel.
% 1. On met à 0 la valeur du sélecteur du mode temporel
% 2. On calcule la fréquence d'échantillonnage
% 3. On réalise la transformée de Fourrier des données audio de la piste
% 4. On sélectionne le graphe de la piste originale 
% 5. On affiche la fréquence d'échantillonnage en fonction de la valeur 
% absolue de la TF des données audio sur la graphe
% 6. On légende les axes
% 7. On renvoit le buffer au GUI

set(handles.temporal_display,'Value',0);

n = length(handles.y1) -1;  
F = 0:handles.Fs / n:handles.Fs; 
Y = abs(fft(handles.y1));%fourier transform en valeur absolu

axes(handles.original_wave_axes)
plot(F,Y);
xlabel('Frequency in Hz');
ylabel('Magnitude in dB');
set(handles.original_wave_axes,'XColor',[1 1 1]);
set(handles.original_wave_axes,'YColor',[1 1 1]);

% On fait la même chose pour le graphe de la piste modifiée
n = length(handles.y2) -1; 
F2 = 0:handles.Fs2 / n:handles.Fs2;
Y2 = abs(fft(handles.y2));

axes(handles.modified_wave_axes)
plot(F2,Y2);
xlabel('Frequency in Hz');
ylabel('Magnitude in dB');
set(handles.modified_wave_axes,'XColor',[1 1 1]);
set(handles.modified_wave_axes,'YColor',[1 1 1]);

guidata(hObject,handles); 



% Pour toutes les fonctions callback des différents slider 
% 1. On récupère la valeur du slider 
% 2. On la convertit au format texte et on actualise l'affichage de la
% valeur du slider

%%% SLIDER ECHO
% --- Executes on slider movement.
function slider_echo_Callback(hObject, eventdata, handles)
data = get(handles.slider_echo,'Value');
set(handles.text_value_echo,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_echo_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%% SLIDERS DISTORTION
% --- Executes on slider movement.
function slider_distortion_Callback(hObject, eventdata, handles)
data = get(handles.slider_distortion,'Value');
set(handles.text_value_distortion,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_distortion_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function slider_distortion2_Callback(hObject, eventdata, handles)
data = get(handles.slider_distortion2,'Value');
set(handles.text_value_distortion2,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_distortion2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%% SLIDERS FLANGER
% --- Executes on slider movement.
function slider_flanger_Callback(hObject, eventdata, handles)
data = get(handles.slider_flanger,'Value');
set(handles.text_value_flanger,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_flanger_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function slider_flanger2_Callback(hObject, eventdata, handles)
data = get(handles.slider_flanger2,'Value');
set(handles.text_value_flanger2,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_flanger2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%% SLIDERS WOBBLE
% --- Executes on slider movement.
function slider_wobble_Callback(hObject, eventdata, handles)
data = get(handles.slider_wobble,'Value');
set(handles.text_value_wobble,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_wobble_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function slider_wobble2_Callback(hObject, eventdata, handles)
data = get(handles.slider_wobble2,'Value');
set(handles.text_value_wobble2,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_wobble2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%% SLIDERS FILTERS
% --- Executes on slider movement.
function slider_filter1_Callback(hObject, eventdata, handles)
data = get(handles.slider_filter1,'Value');
set(handles.text_low,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_filter1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function slider_filter2_Callback(hObject, eventdata, handles)
data = get(handles.slider_filter2,'Value');
set(handles.text_mid,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_filter2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function slider_filter3_Callback(hObject, eventdata, handles)
data = get(handles.slider_filter3,'Value');
set(handles.text_high,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_filter3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%% SLIDER ATTENUATION
% --- Executes on slider movement.
function slider_attenuation_Callback(hObject, eventdata, handles)
data = get(handles.slider_attenuation,'Value');
set(handles.text_value_attenuation,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_attenuation_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%% SLIDER AMPLIFICATION
% --- Executes on slider movement.
function slider_amplification_Callback(hObject, eventdata, handles)
data = get(handles.slider_amplification,'Value');
set(handles.text_value_amplification,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_amplification_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%% SLIDERS TREMOLO
% --- Executes on slider movement.
function slider_tremolo_Callback(hObject, eventdata, handles)
data = get(handles.slider_tremolo,'Value');
set(handles.text_value_tremolo,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_tremolo_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function slider_tremolo2_Callback(hObject, eventdata, handles)
data = get(handles.slider_tremolo2,'Value');
set(handles.text_value_tremolo2,'String',num2str(data));
% --- Executes during object creation, after setting all properties.
function slider_tremolo2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% Pour les fonctions callback des effets 
% 1. On récupère les données audio
% 2. On récupère les valeur des sliders de l'effet pour avoir la force
% souhaitée
% 3. On appelle la fonction echo avec les données audio, le taux
% d'échantillonnage et la force de l'effet
% 4. On copie les données retournées par la fonction dans le buffer et on
% renvoit le buffer au GUI

% Callback de l'effet echo
% --- Executes on button press in echo.
function echo_Callback(hObject, eventdata, handles)
y2=handles.y2;
data = get(handles.slider_echo,'Value');
new_data = echoEffect(y2, handles.Fs2 ,data);
handles.y2= new_data;
guidata(hObject,handles);
set(handles.text_echo,'String','ON');
set(handles.text_echo,'backgroundcolor',[0.1 .7 0]);

% Callback de l'effet distortion
% --- Executes on button press in distortion.
function distortion_Callback(hObject, eventdata, handles)
y2=handles.y2;
value_slider = get(handles.slider_distortion,'Value');
value_slider2 = get(handles.slider_distortion2,'Value');
new_data = distortion(y2, handles.Fs ,value_slider,value_slider2);
handles.y2= new_data;
guidata(hObject,handles);
set(handles.text_distortion,'String','ON');
set(handles.text_distortion,'backgroundcolor',[0.1 .7 0]);

% Callback de l'effet flanger
% --- Executes on button press in flanger.
function flanger_Callback(hObject, eventdata, handles)
y2 = handles.y2;
value_slider = get(handles.slider_flanger,'Value');
value_slider2 = get(handles.slider_flanger2,'Value');
new_data = flanger(y2, handles.Fs , value_slider , value_slider2);
handles.y2= new_data;
guidata(hObject,handles); 
set(handles.text_flanger,'String','ON');
set(handles.text_flanger,'backgroundcolor',[0.1 .7 0]);

% Callback de l'effet wobble
% --- Executes on button press in wobble.
function wobble_Callback(hObject, eventdata, handles)
y2=handles.y2;
value_slider = get(handles.slider_wobble,'Value');
value_slider2 = get(handles.slider_wobble2,'Value');
value_data = wobble(y2, handles.Fs, value_slider,value_slider2);
handles.y2= value_data;
guidata(hObject,handles); 
set(handles.text_wobble,'String','ON');
set(handles.text_wobble,'backgroundcolor',[0.1 .7 0]);

% Callback des fltres passe bas, medium et haut
% --- Executes on button press in filter_1.
function filter_1_Callback(hObject, eventdata, handles)
y2=handles.y2;
value_slider = get(handles.slider_filter1,'Value');
value_slider2 = get(handles.slider_filter2,'Value');
value_slider3 = get(handles.slider_filter3,'Value');
value_data = filter1(y2, handles.Fs2 ,value_slider, value_slider2, value_slider3,handles);
handles.y2= value_data;
guidata(hObject,handles); 
set(handles.text_filter1,'String','ON');
set(handles.text_filter1,'backgroundcolor',[0.1 .7 0]);

% Callback de l'effet atténuation
% --- Executes on button press in attenuation.
function attenuation_Callback(hObject, eventdata, handles)
y2=handles.y2;
value_slider = get(handles.slider_attenuation,'Value');
new_data = attenuation(y2, value_slider);
handles.y2= new_data;
guidata(hObject,handles); 
set(handles.text_attenuation,'String','ON');
set(handles.text_attenuation,'backgroundcolor',[0.1 .7 0]);

% Callback de l'effet amplification
% --- Executes on button press in amplification.
function amplification_Callback(hObject, eventdata, handles)
y2=handles.y2;
value_slider = get(handles.slider_amplification,'Value');
new_data = amplification(y2, value_slider);
handles.y2= new_data;
guidata(hObject,handles); 
set(handles.text_amplification,'String','ON');
set(handles.text_amplification,'backgroundcolor',[0.1 .7 0]);

% Callback de l'effet tremolo
% --- Executes on button press in tremolo.
function tremolo_Callback(hObject, eventdata, handles)
y2=handles.y2;
value_slider = get(handles.slider_tremolo,'Value');
value_slider2 = get(handles.slider_tremolo2,'Value');
new_data = tremolo(y2, handles.Fs ,value_slider,value_slider2);
handles.y2= new_data;
guidata(hObject,handles); 
set(handles.text_tremolo,'String','ON');
set(handles.text_tremolo,'backgroundcolor',[0.1 .7 0]);




% Décélération de la piste audio
% --- Executes on slider movement.
function slider_deceleration_Callback(hObject, eventdata, handles)

% 1. Récupération de l'arrondi de la valeur du slider
value_slider = get(handles.slider_deceleration,'Value');
msgbox(num2str(value_slider));
value_slider = round(value_slider);
%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav. On prend FS cette fois ci ! 
value_data = filter(1,value_slider,handles.Fs);
%On recopie de nouveau dans les données !
handles.Fs2= value_data;

s = num2str(value_slider);
s1 = strcat('Décélération :','  /', s);
set(handles.text_deceleration,'String',s1);
%On enregistre toutes ses nouvelles données!
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function slider_deceleration_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Accélération de la piste audio
% --- Executes on slider movement.
function slider_acceleration_Callback(hObject, eventdata, handles)

%Récupération du positionnement du slider!
value_slider = get(handles.slider_acceleration,'Value');
value_slider = round(value_slider);

%Appelle de la fonction pour le filtre et change les valeurs du data et du
%rate de la musique wav. IDem que pour la decceleation en utilisant Fs
value_data = filter(value_slider,1,handles.Fs);
%On recopie de nouveau dans les données !
handles.Fs2= value_data;

s = num2str(value_slider);
s1 = strcat('Acceleration :','  x', s);
set(handles.text_acceleration,'String',s1);
%On enregistre toutes ses nouvelles données!
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function slider_acceleration_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
