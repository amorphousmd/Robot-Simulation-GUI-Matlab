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

% Last Modified by GUIDE v2.5 15-Nov-2022 23:39:50

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

% Initialise tabs
handles.tabManager = TabManager( hObject );

% Set-up a selection changed function on the create tab groups
tabGroups = handles.tabManager.TabGroups;
for tgi=1:length(tabGroups)
    set(tabGroups(tgi),'SelectionChangedFcn',@tabChangedCB)
end

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
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;



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
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;

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
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
forwardUpdateIncrement(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
global prevS1;
global prevS2;
global prevS3;
global prevS4;
global prevS5;
global prevS6;
global prevS7;
global endEffectorX;
global endEffectorY;
global endEffectorZ;
global prevX10;
global prevX20;
global prevY10;
global prevY20;
global prevZ10;
global prevZ20;
global prevX11;
global prevX21;
global prevY11;
global prevY21;
global prevZ11;
global prevZ21;
global prevX12;
global prevX22;
global prevY12;
global prevY22;
global prevZ12;
global prevZ22;
global prevX13;
global prevX23;
global prevY13;
global prevY23;
global prevZ13;
global prevZ23;
global prevX14;
global prevX24;
global prevY14;
global prevY24;
global prevZ14;
global prevZ24;
global drawCoordsAllow;
global drawPathAllow;
drawCoordsAllow = 0;
drawPathAllow = 0;
global theta1Old;
global theta2Old;
global theta3Old;
global theta4Old;
handles.jointAngles.theta1 = 0;
handles.jointAngles.theta2 = 90;
handles.jointAngles.theta3 = -90;
handles.jointAngles.theta4 = 0;

theta1Old = 0;
theta2Old = 90;
theta3Old = -90;
theta4Old = 0;

handles.inverseAngles.theta1 = 0;
handles.inverseAngles.theta2 = 90;
handles.inverseAngles.theta3 = -90;
handles.inverseAngles.theta4 = 0;

handles.inverseAngles.EEffectorX = 27.4;
handles.inverseAngles.EEffectorY = 0;
handles.inverseAngles.EEffectorZ = 20.5;
handles.inverseAngles.EEffectorPitch = 0;

set(handles.editTheta1, 'String', handles.jointAngles.theta1);
set(handles.editTheta2, 'String', handles.jointAngles.theta2);
set(handles.editTheta3, 'String', handles.jointAngles.theta3);
set(handles.editTheta4, 'String', handles.jointAngles.theta4);

set(handles.editInverseX, 'String', handles.inverseAngles.EEffectorX);
set(handles.editInverseY, 'String', handles.inverseAngles.EEffectorY);
set(handles.editInverseZ, 'String', handles.inverseAngles.EEffectorZ);
set(handles.editInversePitch, 'String', handles.inverseAngles.EEffectorPitch);

set(handles.sliderInverseX, 'Value', handles.inverseAngles.EEffectorX);
set(handles.sliderInverseY, 'Value', handles.inverseAngles.EEffectorY);
set(handles.sliderInverseZ, 'Value', handles.inverseAngles.EEffectorZ);
set(handles.sliderInversePitch, 'Value', handles.inverseAngles.EEffectorPitch);

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
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;

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
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
global theta1Old
global theta2Old
global theta3Old
global theta4Old
theta1Old = theta1;
theta2Old = theta2;
theta3Old = theta3;
theta4Old = theta4;


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
hold off
global theta1Old;
global theta2Old;
global theta3Old;
global theta4Old;
theta1Old = 0;
theta2Old = 90;
theta3Old = -90;
theta4Old = 0;
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

function calculateInverseKinematics(hObject, eventdata, handles)
offsetAngle = 10.6197;
EEffectorX = handles.inverseAngles.EEffectorX
EEffectorY = handles.inverseAngles.EEffectorY
EEffectorZ = handles.inverseAngles.EEffectorZ
pitch = handles.inverseAngles.EEffectorPitch

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
set(handles.editTheta1,'String',num2str(theta1));
set(handles.editTheta2,'String',num2str(theta2));
set(handles.editTheta3,'String',num2str(theta3));
set(handles.editTheta4,'String',num2str(theta4));
set(handles.sliderTheta1,'value',theta1);
set(handles.sliderTheta2,'value',theta2);
set(handles.sliderTheta3,'value',theta3);
set(handles.sliderTheta4,'value',theta4);
guidata(hObject,handles)

forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);

function calculateInverseKinematicsPath(hObject, eventdata, handles, EEffectorX, EEffectorY, EEffectorZ, pitch)
offsetAngle = 10.6197;
% EEffectorX = handles.inverseAngles.EEffectorX
% EEffectorY = handles.inverseAngles.EEffectorY
% EEffectorZ = handles.inverseAngles.EEffectorZ
% pitch = handles.inverseAngles.EEffectorPitch

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
set(handles.editTheta1,'String',num2str(theta1));
set(handles.editTheta2,'String',num2str(theta2));
set(handles.editTheta3,'String',num2str(theta3));
set(handles.editTheta4,'String',num2str(theta4));
set(handles.sliderTheta1,'value',theta1);
set(handles.sliderTheta2,'value',theta2);
set(handles.sliderTheta3,'value',theta3);
set(handles.sliderTheta4,'value',theta4);
guidata(hObject,handles)

forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


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
EEffectorX = str2double(get(hObject, 'String'));
if isnan(EEffectorX)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorX = EEffectorX;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


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
EEffectorY = str2double(get(hObject, 'String'));
if isnan(EEffectorY)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorY = EEffectorY;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


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
EEffectorZ = str2double(get(hObject, 'String'));
if isnan(EEffectorZ)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorZ = EEffectorZ;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


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
EEffectorPitch = str2double(get(hObject, 'String'));
if isnan(EEffectorPitch)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.inverseAngles.EEffectorPitch = EEffectorPitch;
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



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
EEffectorX = handles.inverseAngles.EEffectorX
EEffectorY = handles.inverseAngles.EEffectorY
EEffectorZ = handles.inverseAngles.EEffectorZ
pitch = handles.inverseAngles.EEffectorPitch

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
set(handles.editTheta1,'String',num2str(theta1));
set(handles.editTheta2,'String',num2str(theta2));
set(handles.editTheta3,'String',num2str(theta3));
set(handles.editTheta4,'String',num2str(theta4));
set(handles.sliderTheta1,'value',theta1);
set(handles.sliderTheta2,'value',theta2);
set(handles.sliderTheta3,'value',theta3);
set(handles.sliderTheta4,'value',theta4);
guidata(hObject,handles)

forwardUpdate(theta1, theta2, theta3, theta4);
updateEndEffector(hObject, eventdata, handles);


% --- Executes on slider movement.
function sliderInverseX_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorX = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorX = EEffectorX;
set(handles.editInverseX,'String',num2str(EEffectorX));
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function sliderInverseX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInverseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderInverseY_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorY = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorY = EEffectorY;
set(handles.editInverseY,'String',num2str(EEffectorY));
updateEndEffector(hObject, eventdata, handles)
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function sliderInverseY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInverseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderInverseZ_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorZ = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorZ = EEffectorZ;
set(handles.editInverseZ,'String',num2str(EEffectorZ));
updateEndEffector(hObject, eventdata, handles)
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function sliderInverseZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInverseZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderInversePitch_Callback(hObject, eventdata, handles)
% hObject    handle to sliderInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EEffectorPitch = get(hObject, 'Value');
% Save the new density value
handles.inverseAngles.EEffectorPitch = EEffectorPitch;
set(handles.editInversePitch,'String',num2str(EEffectorPitch));
updateEndEffector(hObject, eventdata, handles)
guidata(hObject,handles)
calculateInverseKinematics(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function sliderInversePitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderInversePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
state = get(hObject,'Value')
global drawCoordsAllow;
drawCoordsAllow = state;


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
state = get(hObject,'Value')
global drawPathAllow;
drawPathAllow = state;



function editInterpolateX_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolateX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolateX as text
%        str2double(get(hObject,'String')) returns contents of editInterpolateX as a double
EEffectorX = str2double(get(hObject, 'String'));
if isnan(EEffectorX)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorX = EEffectorX;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolateX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolateX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInterpolateY_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolateY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolateY as text
%        str2double(get(hObject,'String')) returns contents of editInterpolateY as a double
EEffectorY = str2double(get(hObject, 'String'));
if isnan(EEffectorY)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorY = EEffectorY;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolateY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolateY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInterpolateZ_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolateZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolateZ as text
%        str2double(get(hObject,'String')) returns contents of editInterpolateZ as a double
EEffectorZ = str2double(get(hObject, 'String'));
if isnan(EEffectorZ)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorZ = EEffectorZ;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolateZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolateZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editInterpolatePitch_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpolatePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpolatePitch as text
%        str2double(get(hObject,'String')) returns contents of editInterpolatePitch as a double
EEffectorPitch = str2double(get(hObject, 'String'));
if isnan(EEffectorPitch)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.EEffectorPitch = EEffectorPitch;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editInterpolatePitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpolatePitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnInterPolate.
function btnInterPolate_Callback(hObject, eventdata, handles)
% hObject    handle to btnInterPolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EEffectorX1 = handles.inverseAngles.EEffectorX;
EEffectorY1 = handles.inverseAngles.EEffectorY;
EEffectorZ1 = handles.inverseAngles.EEffectorZ;
pitch1 = handles.inverseAngles.EEffectorPitch;
EEffectorX2 = handles.interpolateVars.EEffectorX;
EEffectorY2 = handles.interpolateVars.EEffectorY;
EEffectorZ2 = handles.interpolateVars.EEffectorZ;
pitch2 = handles.interpolateVars.EEffectorPitch;
pmax = sqrt((EEffectorX2 - EEffectorX1)^2 + (EEffectorY2 - EEffectorY1)^2 + (EEffectorZ2 - EEffectorZ1)^2)
amax = handles.interpolateVars.Amax;
vmax = handles.interpolateVars.Vmax;
[x, y1, y2, y3] = createProfile(pmax, vmax, amax);
list = [];
for i = 1:100
    list = [list, y3(30*i)];
end
list = list / pmax;
hold(handles.axes1,'on');
plot(handles.axes1, x, y1);
hold(handles.axes2,'on');
plot(handles.axes2, x, y2);
hold(handles.axes3,'on');
plot(handles.axes3, x, y3);
EEffectorXPoints = [];
EEffectorYPoints = [];
EEffectorZPoints = [];
pitchPoints = [];
for i = 1:100
    EEffectorXPoints = [EEffectorXPoints, EEffectorX1 + (EEffectorX2 - EEffectorX1) * list(i)];
    EEffectorYPoints = [EEffectorYPoints, EEffectorY1 + (EEffectorY2 - EEffectorY1) * list(i)];
    EEffectorZPoints = [EEffectorZPoints, EEffectorZ1 + (EEffectorZ2 - EEffectorZ1) * list(i)];
    pitchPoints = [pitchPoints, pitch1 + (pitch2 - pitch1) * list(i)];
end
% EEffectorXPoints = linspace(EEffectorX1, EEffectorX2, 100);
% EEffectorYPoints = linspace(EEffectorY1, EEffectorY2, 100);
% EEffectorZPoints = linspace(EEffectorZ1, EEffectorZ2, 100);
% pitchPoints = linspace(pitch1, pitch2, 100)
for i = 1:100
    calculateInverseKinematicsPath(hObject, eventdata, handles, EEffectorXPoints(i), EEffectorYPoints(i), EEffectorZPoints(i), pitchPoints(i));
    pause(0.0001);
end



function editVMax_Callback(hObject, eventdata, handles)
% hObject    handle to editVMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVMax as text
%        str2double(get(hObject,'String')) returns contents of editVMax as a double
Vmax = str2double(get(hObject, 'String'));
if isnan(Vmax)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.Vmax = Vmax;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editVMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAMax_Callback(hObject, eventdata, handles)
% hObject    handle to editAMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAMax as text
%        str2double(get(hObject,'String')) returns contents of editAMax as a double
Amax = str2double(get(hObject, 'String'));
if isnan(Amax)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new volume value
handles.interpolateVars.Amax = Amax;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editAMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
