function varargout = Encryption(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Encryption_OpeningFcn, ...
                   'gui_OutputFcn',  @Encryption_OutputFcn, ...
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

function Encryption_OpeningFcn(hObject, eventdata, handles, varargin)


handles.output = hObject;

ah = axes('unit','normalized', 'position', [0 0 1 1]);
bg = imread('leaf.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

guidata(hObject, handles);
clear all;
clc;

global Img;
global EncImg;
global DecImg;

function varargout = Encryption_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)

global Img;
X = uigetfile('*.jpg;*.tiff;*.ppm;*.pgm;*.png;*.jpeg*','pick a jpge file');
Img = imread(X);
  axes(handles.axes1)
  imshow(Img);
  
guidata(hObject, handles);

function pushbutton2_Callback(hObject, eventdata, handles)
global Img ;
global EncImg; 
[n m k] = size(Img);
pass = input("\nEnter 6 digit password: ");
key = Key(n*m,pass);
EncImg = encryptImg(Img,key);
axes(handles.axes2)
imshow(EncImg);
imwrite(EncImg,'Encoded.jpg','jpg');
guidata(hObject, handles);

function pushbutton3_Callback(hObject, eventdata, handles)
global DecImg;
global EncImg;
[n m k] = size(EncImg);
pass = input("\nEnter 6 digit password: ");
key = Key(n*m,pass);
DecImg = encryptImg(EncImg,key);
axes(handles.axes3);
imshow(DecImg);
imwrite(DecImg,'Decoded.jpg','jpg');
guidata(hObject, handles);



% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
