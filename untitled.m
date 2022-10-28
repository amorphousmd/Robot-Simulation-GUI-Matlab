function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 24-Oct-2022 13:24:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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

% --- Executes just before untitled is made visible.

function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using untitled.
initialize_gui(hObject, handles, false);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles)
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



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});

function editTheta1_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta1 as text
%        str2double(get(hObject,'String')) returns contents of editTheta1 as a double
theta1 = str2double(get(hObject, 'String'));
if isnan(theta1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta1 = theta1;
set(handles.sliderTheta1,'value',theta1);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function editTheta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta2_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta2 as text
%        str2double(get(hObject,'String')) returns contents of editTheta2 as a double
theta2 = str2double(get(hObject, 'String'));
if isnan(theta2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta2 = theta2;
set(handles.sliderTheta2,'value',theta2);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function editTheta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta3_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta3 as text
%        str2double(get(hObject,'String')) returns contents of editTheta3 as a double
theta3 = str2double(get(hObject, 'String'));
if isnan(theta3)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta3 = theta3;
set(handles.sliderTheta3,'value',theta3);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function editTheta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTheta4_Callback(hObject, eventdata, handles)
% hObject    handle to editTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTheta4 as text
%        str2double(get(hObject,'String')) returns contents of editTheta4 as a double
theta4 = str2double(get(hObject, 'String'));
if isnan(theta4)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.jointAngles.theta4 = theta4;
set(handles.sliderTheta4,'value',theta4);
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function editTheta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end
global endEffectorX;
global endEffectorY;
global endEffectorZ;
handles.jointAngles.theta1 = 0;
handles.jointAngles.theta2 = 90;
handles.jointAngles.theta3 = -90;
handles.jointAngles.theta4 = 0;

handles.inverseAngles.theta1 = 0;
handles.inverseAngles.theta2 = 90;
handles.inverseAngles.theta3 = -90;
handles.inverseAngles.theta4 = 0;

handles.inverseAngles.EEfectorX = 27.4;
handles.inverseAngles.EEfectorY = 0;
handles.inverseAngles.EEfectorZ = 20.5;
handles.inverseAngles.EEfectorPitch = 0;

set(handles.editTheta1, 'String', handles.jointAngles.theta1);
set(handles.editTheta2, 'String', handles.jointAngles.theta2);
set(handles.editTheta3, 'String', handles.jointAngles.theta3);
set(handles.editTheta4, 'String', handles.jointAngles.theta4);

% Update handles structure
guidata(handles.figure1, handles);
theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);



% --- Executes on slider movement.
function sliderTheta1_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta1 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta1 = theta1;
set(handles.editTheta1,'String',num2str(theta1));
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function sliderTheta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta2 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta2 = theta2;
set(handles.editTheta2,'String',num2str(theta2));
guidata(hObject,handles)

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function sliderTheta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta3_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta3 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta3 = theta3;
set(handles.editTheta3,'String',num2str(theta3));
guidata(hObject,handles);

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function sliderTheta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta4_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta4 = get(hObject, 'Value');
% Save the new density value
handles.jointAngles.theta4 = theta4;
set(handles.editTheta4,'String',num2str(theta4));
guidata(hObject,handles);

theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function sliderTheta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.jointAngles.theta1 = 0;
handles.jointAngles.theta2 = 90;
handles.jointAngles.theta3 = -90;
handles.jointAngles.theta4 = 0;

set(handles.editTheta1, 'String', handles.jointAngles.theta1);
set(handles.editTheta2, 'String', handles.jointAngles.theta2);
set(handles.editTheta3, 'String', handles.jointAngles.theta3);
set(handles.editTheta4, 'String', handles.jointAngles.theta4);

set(handles.sliderTheta1, 'Value', handles.jointAngles.theta1);
set(handles.sliderTheta2, 'Value', handles.jointAngles.theta2);
set(handles.sliderTheta3, 'Value', handles.jointAngles.theta3);
set(handles.sliderTheta4, 'Value', handles.jointAngles.theta4);


% Update handles structure
guidata(handles.figure1, handles);
theta1 = handles.jointAngles.theta1;
theta2 = handles.jointAngles.theta2;
theta3 = handles.jointAngles.theta3;
theta4 = handles.jointAngles.theta4;
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

function updateEndEffector(hObject, eventdata, handles)
global endEffectorX;
global endEffectorY;
global endEffectorZ;
global endEffectorRoll;
global endEffectorPitch;
global endEffectorYaw;
set(handles.editEndEffectorX, 'String', num2str(endEffectorX));
set(handles.editEndEffectorY, 'String', num2str(endEffectorY));
set(handles.editEndEffectorZ, 'String', num2str(endEffectorZ));
set(handles.editEndEffectorRoll, 'String', num2str(endEffectorRoll / pi * 180));
set(handles.editEndEffectorPitch, 'String', num2str(endEffectorPitch / pi * 180));
set(handles.editEndEffectorYaw, 'String', num2str(endEffectorYaw / pi * 180));



function editEndEffectorX_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorX as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorX as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorY_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorY as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorY as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorZ_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorZ as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorZ as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorRoll_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorRoll as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorRoll as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorRoll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorPitch_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorPitch as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorPitch as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorPitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorPitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEndEffectorYaw_Callback(hObject, eventdata, handles)
% hObject    handle to editEndEffectorYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEndEffectorYaw as text
%        str2double(get(hObject,'String')) returns contents of editEndEffectorYaw as a double


% --- Executes during object creation, after setting all properties.
function editEndEffectorYaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEndEffectorYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInverseX_Callback(hObject, eventdata, handles)
% hObject    handle to editInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInverseX as text
%        str2double(get(hObject,'String')) returns contents of editInverseX as a double
EEfectorX = str2double(get(hObject, 'String'));
if isnan(EEfectorX)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEfectorX = EEfectorX;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInverseX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInverseY_Callback(hObject, eventdata, handles)
% hObject    handle to editInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInverseY as text
%        str2double(get(hObject,'String')) returns contents of editInverseY as a double
EEfectorY = str2double(get(hObject, 'String'));
if isnan(EEfectorY)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEfectorY = EEfectorY;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInverseY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInverseZ_Callback(hObject, eventdata, handles)
% hObject    handle to editInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInverseZ as text
%        str2double(get(hObject,'String')) returns contents of editInverseZ as a double
EEfectorZ = str2double(get(hObject, 'String'));
if isnan(EEfectorZ)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEfectorZ = EEfectorZ;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInverseZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInversePitch_Callback(hObject, eventdata, handles)
% hObject    handle to editInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInversePitch as text
%        str2double(get(hObject,'String')) returns contents of editInversePitch as a double
EEfectorPitch = str2double(get(hObject, 'String'));
if isnan(EEfectorPitch)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEfectorPitch = EEfectorPitch;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInversePitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnCalculateInverseKinematics.
function btnCalculateInverseKinematics_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalculateInverseKinematics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
offsetAngle = 10.6197;
EEffectorX = handles.inverseAngles.EEfectorX
EEffectorY = handles.inverseAngles.EEfectorY
EEffectorZ = handles.inverseAngles.EEfectorZ
pitch = handles.inverseAngles.EEfectorPitch

theta1 = atan2(EEffectorY, EEffectorX) * 180 / pi

Y = EEffectorZ - 7.7;
X = sqrt(EEffectorX * EEffectorX + EEffectorY * EEffectorY) ;
beta = -pitch;
% beta = pitch;
P2x = X - 12.6 * cos(beta * pi / 180)
P2y = Y - 12.6 * sin(beta * pi / 180)
theta3 = acos((P2x*P2x + P2y*P2y - 13.0231*13.0231 - 12.4*12.4) / (2 * 13.0231 * 12.4)) * 180 / pi 
theta2 = (atan(P2y/ P2x) - atan2( (12.4 * sin(theta3 * pi / 180)) , (13.0231 + 12.4 * cos(theta3 * pi / 180))))* 180 / pi + 10.6197
theta4 = beta - theta3 - theta2
theta3 = theta3 - 10.6197
theta4 = theta4 + 10.6197
forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

