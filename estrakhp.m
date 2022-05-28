function varargout = estrakhp(varargin)
% ESTRAKHP MATLAB code for estrakhp.fig
%      ESTRAKHP, by itself, creates a new ESTRAKHP or raises the existing
%      singleton*.
%
%      H = ESTRAKHP returns the handle to a new ESTRAKHP or the handle to
%      the existing singleton*.
%
%      ESTRAKHP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESTRAKHP.M with the given input arguments.
%
%      ESTRAKHP('Property','Value',...) creates a new ESTRAKHP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before estrakhp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to estrakhp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help estrakhp

% Last Modified by GUIDE v2.5 28-May-2022 14:19:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @estrakhp_OpeningFcn, ...
                   'gui_OutputFcn',  @estrakhp_OutputFcn, ...
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


% --- Executes just before estrakhp is made visible.
function estrakhp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to estrakhp (see VARARGIN)

% Choose default command line output for estrakhp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes estrakhp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = estrakhp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nama_file,nama_folder]=uigetfile('*.jpg; *.png; *.jpeg');

%jika ada nama file yang terpilih maka akan mengeksekusi percabanan ini
if ~isequal(nama_file,0)
    %membaca ctra rgb
    citra=imread(fullfile(nama_folder,nama_file));
    %menampikan citra di axes
    axes(handles.axes1)
    imshow(citra)
    title('citra yang di olah')
    %simpan variabel i d dalam handles agar bisa di simpan
    handles.citra=citra;
    guidata(hObject,handles)
    set(handles.edit13,'string',nama_file)
else
    %jika tidak ada file maka akan kembali
    return    
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ekstrak_citra=handles.citra;
ekstrak_citra=rgb2hsv(ekstrak_citra);
h=ekstrak_citra(:,:,1);
s=ekstrak_citra(:,:,2);
v=ekstrak_citra(:,:,3);
binary_citra=im2bw(s,.25);
binary_citra=imfill(binary_citra,'holes');
binary_citra=bwareaopen(binary_citra,100);
axes(handles.axes2)
imshow(binary_citra)
title('citra binary')
[bonding,long]=bwboundaries(binary_citra,'noholes');
stats=regionprops(long,'ALL')
perimeter=cat(1,stats.Perimeter);
area=cat(1,stats.Area);


set(handles.edit1,'string',num2str(area,'%0.2f'));
set(handles.edit2,'string',perimeter);



function edit1_Callback(hObject, eventdata, handles)



% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
