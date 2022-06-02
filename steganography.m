function varargout = steganography(varargin)
% STEGANOGRAPHY MATLAB code for steganography.fig
%      STEGANOGRAPHY, by itself, creates a new STEGANOGRAPHY or raises the existing
%      singleton*.
%
%      H = STEGANOGRAPHY returns the handle to a new STEGANOGRAPHY or the handle to
%      the existing singleton*.
%
%      STEGANOGRAPHY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGANOGRAPHY.M with the given input arguments.
%
%      STEGANOGRAPHY('Property','Value',...) creates a new STEGANOGRAPHY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before steganography_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to steganography_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help steganography

% Last Modified by GUIDE v2.5 02-May-2022 02:20:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steganography_OpeningFcn, ...
                   'gui_OutputFcn',  @steganography_OutputFcn, ...
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


% --- Executes just before steganography is made visible.
function steganography_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steganography (see VARARGIN)

% Choose default command line output for steganography
handles.output = hObject;
ah = axes('unit','normalized', 'position', [0 0 1 1]);
bg = imread('leaf.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');
Base = imread('pcbBase.jpg');
Message = imread('pcbMsg.jpeg');
axes(handles.axes3);
imshow(Message);
axes(handles.axes4);
imshow(Base);
guidata(hObject, handles);

% UIWAIT makes steganography wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = steganography_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=uigetfile()
filename=a;
setappdata(0,'filename', filename);
a= imread(a);
axes(handles.axes1);
imshow(a);
setappdata(0,'a',a)
setappdata(0, 'filename',a);
plot(handles.axes1, 'a')

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close steganography

% --- Executes on button press in hide.
function hide_Callback(hObject, eventdata, handles)
% hObject    handle to hide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Base = imread('pcbBase.jpg');
Message = imread('pcbMsg.jpeg');
Msg = imbinarize(rgb2gray(Message));
Msg = imresize(Msg,size(Base(:,:,1)));
New = Base;
New(:,:,1) = bitset(New(:,:,1),1,Msg);
axes(handles.axes5);
imshow(New);
imwrite(New,'pcbMsgIm.bmp');
clear all;

% --- Executes on button press in read.
function read_Callback(hObject, eventdata, handles)
% hObject    handle to read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Im = imread('pcbMsgIm.bmp');
[indexedImage, map] = rgb2ind(Im, 6);
MessageImage = bitget(Im(:,:,1),1);
Im =(logical(MessageImage));
rgbImage2 = ind2rgb(Im, map);
axes(handles.axes6);
imshow(rgbImage2);