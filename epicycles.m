function varargout = epicycles(varargin)
% EPICYCLES MATLAB code for epicycles.fig
%      EPICYCLES, by itself, creates a new EPICYCLES or raises the existing
%      singleton*.
%
%      H = EPICYCLES returns the handle to a new EPICYCLES or the handle to
%      the existing singleton*.
%
%      EPICYCLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EPICYCLES.M with the given input arguments.
%
%      EPICYCLES('Property','Value',...) creates a new EPICYCLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before epicycles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to epicycles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help epicycles

% Last Modified by GUIDE v2.5 18-May-2022 22:43:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @epicycles_OpeningFcn, ...
                   'gui_OutputFcn',  @epicycles_OutputFcn, ...
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
global n;
n = 2;

% --- Executes just before epicycles is made visible.
function epicycles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to epicycles (see VARARGIN)

% Choose default command line output for epicycles
handles.output = hObject;

ah = axes('unit','normalized', 'position', [0 0 1 1]);
bg = imread('leaf.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');


% Update handles structure
guidata(hObject, handles);
set_up_the_drawing(handles);
% UIWAIT makes epicycles wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = epicycles_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_draw_reset.
function button_draw_reset_Callback(hObject, eventdata, handles)
% hObject    handle to button_draw_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xy;

cla(handles.draw);
cla(handles.result);
xy = [];

set_up_the_drawing(handles);

% --- Executes on button press in button_draw_ok.
function button_draw_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_draw_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xy;
global n;
fourier_epicycles(xy(:,1), xy(:,2),n,handles);



function set_up_the_drawing(handles)
global xy;
xy = [];
axes(handles.draw);
try
    hFH = imfreehand();
if isempty(hFH)
  return;
end
xy = hFH.getPosition;
xy = [xy; xy(1,:)];
delete(hFH);
xCoordinates = xy(:, 1);
yCoordinates = xy(:, 2);
plot(xCoordinates, yCoordinates, 'r', 'LineWidth', 2);
hold off;
set(handles.text_nocircles,'String', size(xy,1));
catch me
end



% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xy;
switch(get(eventdata.NewValue,'Tag'))
    case 'Ascending'
        global n;
        n = 1;
    case 'Descending'
        global n;
        n = 2;
    otherwise
        global n;
        n = 0;
end
fourier_epicycles(xy(:,1), xy(:,2),n,handles);
   

function fourier_epicycles(curve_x, curve_y,n,handles)
    Z = complex(curve_x(:), curve_y(:));
    N = length(Z);
    X = fft(Z, N)/N;       
    freq = 0:N-1;     
    radius = abs(X);   
    phase = angle(X);  
    
    if n == 1
        [radius, idx] = sort(radius, 'ascend');
         X = X(idx);
         freq = freq(idx);
         phase = phase(idx);
    elseif n == 2
            [radius, idx] = sort(radius, 'descend');
            X = X(idx);
            freq = freq(idx);
            phase = phase(idx);
     end
            
    time_step = 2*pi/length(X);
    
    time = 0;
    wave = [];
    while 1
        [x, y] = draw_epicycles(freq, radius, phase, time, wave,handles);
        wave = [wave; [x,y]];
        time = time + time_step;
    end


function [x, y] = draw_epicycles(freq, radius, phase, time, wave, handles)
    x = 0;      
    y = 0;
    N = length(freq);
    centers = zeros(N,2);
    radii_lines = zeros(N,4);
    for i = 1:N
        prevx = x;
        prevy = y;
  
        x = x + radius(i) * cos(freq(i)*time + phase(i));
        y = y + radius(i) * sin(freq(i)*time + phase(i));

        centers(i,:) = [prevx, prevy];

        radii_lines(i,:) = [prevx, x, prevy, y];
    end    

    axes(handles.result);
    cla;
    viscircles(centers, radius, 'Color', 0.7 * [0, 1, 0], 'LineWidth', 0.1);
    hold on;

    plot( radii_lines(:,1:2), radii_lines(:,3:4), 'Color', [0 0 1], 'LineWidth', 0.1);
    hold on;

    if ~isempty(wave), plot( wave(:,1), wave(:,2), 'k', 'LineWidth', 2); hold on; end

    plot( x, y, 'or', 'MarkerFaceColor', 'r');
    hold off;
    axis equal;
    %axis off;
   
    drawnow;


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
