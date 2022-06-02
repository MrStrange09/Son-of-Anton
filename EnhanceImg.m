function varargout = EnhanceImg(varargin)
%ENHANCEIMG MATLAB code file for EnhanceImg.fig
%      ENHANCEIMG, by itself, creates a new ENHANCEIMG or raises the existing
%      singleton*.
%
%      H = ENHANCEIMG returns the handle to a new ENHANCEIMG or the handle to
%      the existing singleton*.
%
%      ENHANCEIMG('Property','Value',...) creates a new ENHANCEIMG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to EnhanceImg_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      ENHANCEIMG('CALLBACK') and ENHANCEIMG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in ENHANCEIMG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EnhanceImg

% Last Modified by GUIDE v2.5 11-May-2022 01:19:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EnhanceImg_OpeningFcn, ...
                   'gui_OutputFcn',  @EnhanceImg_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

global store;
global ind;

% --- Executes just before EnhanceImg is made visible.
function EnhanceImg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for EnhanceImg
handles.output = hObject;

ah = axes('unit','normalized', 'position', [0 0 1 1]);
bg = imread('leaf.jpg'); imagesc(bg);
set(ah, 'handlevisibility', 'off', 'visible', 'off');
uistack(ah, 'bottom');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EnhanceImg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EnhanceImg_OutputFcn(hObject, eventdata, handles)
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
b=uigetfile()
global store;
global ind;
a= imread(b);
axes(handles.OrgImage);
imshow(a);
setappdata(0,'a',a)
setappdata(0,'b',a)
imwrite(a,'OrgImg.jpg','jpg');
store = 'bw';
ind = 2;

% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'b');
imshow(a);
setappdata(0,'a',a)

% --- Executes on button press in ExitBtn.
function ExitBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ExitBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();

% --- Executes on button press in PeriodicN.
function PeriodicN_Callback(hObject, eventdata, handles)
% hObject    handle to PeriodicN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
[m n k] = size(a);
minS=min(m,n);
maxS=max(m,n);
x=(m-minS)/2;
y=(n-minS)/2;
a=a(x+1:minS,y+1:maxS-y,:);
if k > 1
  a = rgb2gray(a);
end
rowVector = (1 : m)';
period = 100; 
amplitude = 0.5; 
offset = 1 - amplitude; 
cosVector = amplitude * (1 + cos(2 * pi * rowVector / period))/2 + offset;
ripplesImage = repmat(cosVector, [1, minS]);
noise = ripplesImage .* double(a);
axes(handles.EnhancedImg);
imshow(noise, [0 255]);
imwrite(noise,'PeriodicNImg.jpg','jpg');
setappdata(0,'a',noise)
ind = ind+2;
store = append(store,'pn');

% --- Executes on button press in SnPN.
function SnPN_Callback(hObject, eventdata, handles)
% hObject    handle to SnPN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
noise= imnoise(a,'salt & pepper', 0.02);
axes(handles.EnhancedImg);
imshow(noise);
imwrite(noise,'SnPNoiseImg.jpg','jpg');
setappdata(0,'a',noise)
ind = ind+2;
store = append(store,'sn');

% --- Executes on button press in GaussianN.
function GaussianN_Callback(hObject, eventdata, handles)
% hObject    handle to GaussianN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
noise=imnoise(a, 'gaussian');
axes(handles.EnhancedImg);
imshow(noise);
imwrite(noise,'GnoiseImg.jpg','jpg');
setappdata(0,'a',noise)
ind = ind+2;
store = append(store,'gn');


% --- Executes on button press in Red.
function Red_Callback(hObject, eventdata, handles)
% hObject    handle to Red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
red=a;
red(:,:,2)=0;
red(:,:,3)=0;
axes(handles.EnhancedImg);
imshow(red)
imwrite(red,'redImg.jpg','jpg');
setappdata(0,'a',red)
ind = ind+2;
store = append(store,'re');



% --- Executes on button press in Green.
function Green_Callback(hObject, eventdata, handles)
% hObject    handle to Green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
green=a;
green(:,:,1)=0;
green(:,:,3)=0;
setappdata(0,'filename', green);
setappdata(0,'ImRotation', green);
axes(handles.EnhancedImg);
imshow(green)
imwrite(green,'GreenImg.jpg','jpg');
setappdata(0,'a',green)
ind = ind+2;
store = append(store,'gr');

% --- Executes on button press in Blue.
function Blue_Callback(hObject, eventdata, handles)
% hObject    handle to Blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
blue=a;
blue(:,:,1)=0;
blue(:,:,2)=0;
setappdata(0,'filename', blue);
setappdata(0,'ImRotation', blue);
axes(handles.EnhancedImg);
imshow(blue)
imwrite(blue,'blueImg.jpg','jpg');
setappdata(0,'a',blue)
setappdata(0,'table',blue)
ind = ind+2;
store = append(store,'bl');

% --- Executes on button press in RtoG.
function RtoG_Callback(hObject, eventdata, handles)
% hObject    handle to RtoG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0, 'a');
a_gray=rgb2gray(a);
axes(handles.EnhancedImg);
imshow(a_gray)
imwrite(gray,'GrayImg.jpg','jpg');
setappdata(0,'a',gray)
ind = ind+2;
store = append(store,'rg');

% --- Executes on button press in RtoBW.
function RtoBW_Callback(hObject, eventdata, handles)
% hObject    handle to RtoBW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0, 'a');
a_bw=im2bw(a,.57);
axes(handles.EnhancedImg);
imshow(a_bw)
imwrite(a_bw,'RGB2bwImg.jpg','jpg');
setappdata(0,'a',a_bw)
ind = ind+2;
store = append(store,'rb');

% --- Executes on button press in Sharp.
function Sharp_Callback(hObject, eventdata, handles)
% hObject    handle to Sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a= getappdata(0,'a');
sharp=imsharpen(a,'Radius',2,'Amount',10);
axes(handles.EnhancedImg);
imshow(sharp);
imwrite(sharp,'SharpenImage.jpg','jpg');
setappdata(0,'a',sharp)
ind = ind+2;
store = append(store,'sh');

% --- Executes on button press in Pink.
function Pink_Callback(hObject, eventdata, handles)
% hObject    handle to Pink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
pink=a;
pink(:,:,2)=0;
axes(handles.EnhancedImg);
imshow(pink)
imwrite(pink,'PinkImg.jpg','jpg');
setappdata(0,'a',pink)
ind = ind+2;
store = append(store,'pi');

% --- Executes on button press in Yellow.
function Yellow_Callback(hObject, eventdata, handles)
% hObject    handle to Yellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
yellow=a;
yellow(:,:,3)=0;
axes(handles.EnhancedImg);
imshow(yellow)
imwrite(yellow,'YellImg.jpg','jpg');
setappdata(0,'a',yellow)
ind = ind+2;
store = append(store,'ye');

% --- Executes on button press in Cyan.
function Cyan_Callback(hObject, eventdata, handles)
% hObject    handle to Cyan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
cyan=a;
cyan(:,:,1)=0;
axes(handles.EnhancedImg);
imshow(cyan)
imwrite(cyan,'CyanImg.jpg','jpg');
setappdata(0,'a',cyan)
ind = ind+2;
store = append(store,'cy');

% --- Executes on button press in GaussianF.
function GaussianF_Callback(hObject, eventdata, handles)
% hObject    handle to GaussianF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
gfilter= fspecial('gaussian');
gausF = imfilter(a,gfilter);
axes(handles.EnhancedImg);
imshow(gausF);
imwrite(gausF,'GFilterImg.jpg','jpg');
setappdata(0,'a',gausF)
ind = ind+2;
store = append(store,'gf');

% --- Executes on button press in MeanF.
function MeanF_Callback(hObject, eventdata, handles)
% hObject    handle to MeanF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
h=fspecial('average',3);
mfiltimg=imfilter(a,h); 
axes(handles.EnhancedImg);
imshow(mfiltimg);
imwrite(mfiltimg,'mfiltimg.jpg','jpg');
setappdata(0,'a',mfiltimg)
ind = ind+2;
store = append(store,'mn');

% --- Executes on button press in MedianF.
function MedianF_Callback(hObject, eventdata, handles)
% hObject    handle to MedianF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
a=getappdata(0,'a');
R = a(:,:,1);
G = a(:,:,2);
B = a(:,:,3);
c(:,:,1) = medfilt2(R);
c(:,:,2) = medfilt2(G);
c(:,:,3) = medfilt2(B);
axes(handles.EnhancedImg);
imshow(c);
imwrite(c,'MedFilterImg.jpg','jpg');
setappdata(0,'a',c)
ind = ind+2;
store = append(store,'md');

% --- Executes on slider movement.
function BrightSlider_Callback(hObject, eventdata, handles)
% hObject    handle to BrightSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global store;
global ind;
a=getappdata(0,'a');
% set(handleToSlider, 'min', 0);
% set(handleToSlider, 'max', 100);
value=get(hObject,'Value');
value=value*200 - 50;
bright = value + a;
axes(handles.EnhancedImg);
imshow(bright)
imwrite(bright,'brightImg.jpg','jpg');
pause(1);
setappdata(0,'a',bright)
ind = ind+2;
store = append(store,'br');



% --- Executes on slider movement.
function ContrastSlider_Callback(hObject, eventdata, handles)
% hObject    handle to ContrastSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global store;
global ind;
a=getappdata(0,'a');
value=get(hObject,'Value');
contrastIMG=a*value*5;
axes(handles.EnhancedImg);
imshow(contrastIMG)
imwrite(contrastIMG,'contrastImg.jpg','jpg');
pause(1);
setappdata(0,'a',contrastIMG)
ind = ind+2;
store = append(store,'co');


% --- Executes on slider movement.
function VignetteSlider_Callback(hObject, eventdata, handles)
% hObject    handle to VignetteSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
value=get(hObject,'Value');
[m n k] =  size(a);
Center = [m/2, n/2];
for row=1:m
    for col=1:n
        vignette(row, col) = sqrt((row-Center(1))^2+(col-Center(2))^2);
    end
end
vignette = vignette*value / max(vignette(:));
vignette = 1 - vignette;
vignette = cat(3, vignette, vignette, vignette);
vignette = uint8(double(a) .* vignette);
axes(handles.EnhancedImg);
imshow(vignette)
imwrite(vignette,'vigneImg.jpg','jpg');
pause(1);
setappdata(0,'a',vignette)
global store;
global ind;
ind = ind+2;
store = append(store,'vi');

% --- Executes on button press in HistEq.
function HistEq_Callback(hObject, eventdata, handles)
% hObject    handle to HistEq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
a_hist= histeq(a);
axes(handles.EnhancedImg);
imshow(a_hist)
imwrite(a_hist,'HistEqImg.jpg','jpg');
setappdata(0,'a',a_hist)
global store;
global ind;
ind = ind+2;
store = append(store,'hi');


% --- Executes on button press in ViewHist.
function ViewHist_Callback(hObject, eventdata, handles)
% hObject    handle to ViewHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
input = a;
input = rgb2gray(input);
axes(handles.EnhancedImg)
imhist(input)
imwrite(input,'ViewHist.jpg','jpg');
setappdata(0,'a',input)
global store;
global ind;
ind = ind+2;
store = append(store,'vh');

% --- Executes on button press in Rotate.
function Rotate_Callback(hObject, eventdata, handles)
% hObject    handle to Rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= getappdata(0,'a');
rotate=imrotate(a,90);
axes(handles.EnhancedImg);
imshow(rotate);
imwrite(rotate,'RotateImg.jpg','jpg');
setappdata(0,'a',rotate)
global store;
global ind;
ind = ind+2;
store = append(store,'ro');

% --- Executes on button press in flip.
function flip_Callback(hObject, eventdata, handles)
% hObject    handle to flip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(0,'a');
I2=flipdim(I,2);
axes(handles.EnhancedImg);
imshow(I2);
imwrite(I2,'FlipImg.jpg','jpg');
setappdata(0,'a',I2)
global store;
global ind;
ind = ind+2;
store = append(store,'fl');

% --- Executes on button press in powerTrans.
function powerTrans_Callback(hObject, eventdata, handles)
% hObject    handle to powerTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= getappdata(0,'a');
a=rgb2gray(a);
a = im2double(a);
[m,n] = size(a);
ex=zeros(m,n);
gamma=0.55;
c=1;
for i=1:m
    for j=1:n
        ex(i,j)= c*(a(i,j)^gamma);
    end
end

axes(handles.EnhancedImg);
imshow(ex);
imwrite(ex,'powerTransformImg.jpg','jpg');
setappdata(0,'a',ex)
global store;
global ind;
ind = ind+2;
store = append(store,'pt');

% --- Executes on button press in logTrans.
function logTrans_Callback(hObject, eventdata, handles)
% hObject    handle to logTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= getappdata(0,'a');
a=rgb2gray(a);
a=im2double(a);
[row,col]=size(a);
c=1;
ex=zeros(row,col);
for i=1:row
  for j=1:col
      ex(i,j)=c*log(1+a(i,j));
  end
end
axes(handles.EnhancedImg);
imshow(ex);
imwrite(ex,'logTransformImg.jpg','jpg');
setappdata(0,'a',ex)
global store;
global ind;
ind = ind+2;
store = append(store,'lt');

% --- Executes on button press in fourierTrans.
function fourierTrans_Callback(hObject, eventdata, handles)
% hObject    handle to fourierTrans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=getappdata(0,'a');
af= fft2(a);
axes(handles.EnhancedImg);
imshow(mat2gray(log(1+abs(af))));
imwrite(af,'fourierTransform.jpg', 'jpg');
setappdata(0,'a',af)
global store;
global ind;
ind = ind+2;
store = append(store,'ft');


% --- Executes on button press in sobelEdge.
function sobelEdge_Callback(hObject, eventdata, handles)
% hObject    handle to sobelEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= getappdata(0,'a');
m1=rgb2gray(a);
m2=double(m1);
f1=[-1 -2 1;0 0 0;1 2 -1];
[r,c]=size(m1);
rr=zeros(r-3,c-3);
for q1=1:(r-3)
    for p1=1:(c-3)
        m1=m2(q1:(q1+2),p1:(p1+2));  
        res=f1.*m1;
       rr(q1,p1)=sum(sum(res));
     
    end
end
axes(handles.EnhancedImg);
imshow(rr);
imwrite(rr,'SobelImg.jpg','jpg');
setappdata(0,'a',rr)
global store;
global ind;
ind = ind+2;
store = append(store,'se');

% --- Executes on button press in cannyEdge.
function cannyEdge_Callback(hObject, eventdata, handles)
% hObject    handle to cannyEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a= getappdata(0,'a');
y=rgb2gray(a);

x1=edge(y,'canny');
axes(handles.EnhancedImg);
imshow(x1);
imwrite(x1,'CannyEdge.jpg','jpg');
setappdata(0,'a',x1)
global store;
global ind;
ind = ind+2;
store = append(store,'ce');


% --- Executes on button press in Undo.
function Undo_Callback(hObject, eventdata, handles)
% hObject    handle to Undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
if ind>=2
ind = ind-2;
undo = UndoRedo(store,ind);
undo = imread(undo);
setappdata(0,'a',undo)
axes(handles.EnhancedImg);
imshow(undo);
end

% --- Executes on button press in Redo.
function Redo_Callback(hObject, eventdata, handles)
% hObject    handle to Redo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global store;
global ind;
[m n] = size(store);
if n>ind
ind = ind+2;
redo = UndoRedo(store,ind);
redo = imread(redo);
setappdata(0,'a',redo)
axes(handles.EnhancedImg);
imshow(redo);
end