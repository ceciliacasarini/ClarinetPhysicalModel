function varargout = clarinet_physical_model(varargin)
% CLARINET_PHYSICAL_MODEL MATLAB code for clarinet_physical_model.fig
%      CLARINET_PHYSICAL_MODEL, by itself, creates a new CLARINET_PHYSICAL_MODEL or raises the existing
%      singleton*.
%
%      H = CLARINET_PHYSICAL_MODEL returns the handle to a new CLARINET_PHYSICAL_MODEL or the handle to
%      the existing singleton*.
%
%      CLARINET_PHYSICAL_MODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLARINET_PHYSICAL_MODEL.M with the given input arguments.
%
%      CLARINET_PHYSICAL_MODEL('Property','Value',...) creates a new CLARINET_PHYSICAL_MODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before clarinet_physical_model_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to clarinet_physical_model_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help clarinet_physical_model

% Last Modified by GUIDE v2.5 27-Oct-2017 17:45:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @clarinet_physical_model_OpeningFcn, ...
                   'gui_OutputFcn',  @clarinet_physical_model_OutputFcn, ...
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


% --- Executes just before clarinet_physical_model is made visible.
function clarinet_physical_model_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to clarinet_physical_model (see VARARGIN)

% Choose default command line output for clarinet_physical_model
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes clarinet_physical_model wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = clarinet_physical_model_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Background image
ha = axes('units','normalized', ...
            'position',[0 0 1 1]);
uistack(ha,'bottom');
I=imread('clarinet.jpg');
hi = imagesc(I);
colormap gray
set(ha,'handlevisibility','off', ...
            'visible','off')




% --- Executes on button press in Playbutton.
function Playbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Playbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(get(handles.uibuttongroup1, 'SelectedObject'), 'Tag') 
    case 'singlenote'
        % Obtaining the length of the clarinet depending on the pitch
        switch get(handles.selectedpitch,'Value')   
            case 1
                L = 0.67;
            case 2
                L = 0.67*15/16;
            case 3
                L = 0.67*8/9;
            case 4
                L = 0.67*5/6;
            case 5
                L = 0.67*4/5;
            case 6
                L = 0.67*3/4;
            case 7
                L = 0.67*32/45;
            case 8
                L = 0.67*2/3;
            case 9
                L = 0.67*5/8;
            case 10
                L = 0.67*3/5;
            case 11
                L = 0.67*9/16;
            case 12
                L = 0.67*8/15;
        end
        switch get(handles.selectedoctave,'Value')
            case 1
                L = L/1;
            case 2
                L = L/2;
            case 3
                L = L/4;
        end
        N = 32000;
        Fs = 44100;
        y = clarinet_physical_model_function_to_call(L, N);
        soundsc(y, Fs);
    case 'Mozart'
        Fs = 44100;
        A = 0.67*9/17;
        T = 32000;
        N = [T*2, T*3, T, T, T, T*3];
        L = [A, A*3/4, A*3/5, A*3/5, A*2/3, A*3/4 ];
        y1 = clarinet_physical_model_function_to_call(L(1), N(1));
        y2 = clarinet_physical_model_function_to_call(L(2), N(2));
        y3 = clarinet_physical_model_function_to_call(L(3), N(3));
        y4 = clarinet_physical_model_function_to_call(L(4), N(4));
        y5 = clarinet_physical_model_function_to_call(L(5), N(5));
        y6 = clarinet_physical_model_function_to_call(L(6), N(6));
        out = [y1; y2; y3; y4; y5; y6];
        soundsc(out, Fs);
        
    case 'childrensong'
        Fs = 44100;
        N = [32000, 16000, 32000, 16000, 16000, 16000, 16000, 32000, 16000];
        L = [0.67*2/3, 0.67*4/5, 0.67*2/3, 0.67*4/5,0.67*3/4, 0.67*4/5, 0.67*8/9, 0.67*4/5, 0.67 ];
        y1 = clarinet_physical_model_function_to_call(L(1), N(1));
        y2 = clarinet_physical_model_function_to_call(L(2), N(2));
        y3 = clarinet_physical_model_function_to_call(L(3), N(3));
        y4 = clarinet_physical_model_function_to_call(L(4), N(4));
        y5 = clarinet_physical_model_function_to_call(L(5), N(5));
        y6 = clarinet_physical_model_function_to_call(L(6), N(6));
        y7 = clarinet_physical_model_function_to_call(L(7), N(7));
        y8 = clarinet_physical_model_function_to_call(L(8), N(8));
        y9 = clarinet_physical_model_function_to_call(L(9), N(9));
        out = [y1; y2; y3; y4; y5; y6; y7; y8; y9];
        soundsc(out, Fs);
end
        
% --- Executes on selection change in selectedpitch.
function selectedpitch_Callback(hObject, eventdata, handles)
% hObject    handle to selectedpitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectedpitch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectedpitch


% --- Executes during object creation, after setting all properties.
function selectedpitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedpitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Playbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Playbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in selectedoctave.
function selectedoctave_Callback(hObject, eventdata, handles)
% hObject    handle to selectedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectedoctave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectedoctave


% --- Executes during object creation, after setting all properties.
function selectedoctave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectedoctave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
