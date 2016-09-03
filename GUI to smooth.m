function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 04-May-2016 16:35:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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

% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% % Choose default command line output for test
% handles.output = hObject;

% % Update handles structure
% guidata(hObject, handles);

set(0,'Units','normalized') %获得并将显示器显示设置为[0,0,1,1]的格式，这样无论你在多大的分辨率上显示器上运行GUI，首先都会将显示器设置为[0,0,1,1]
f=gcf;%获得GUI句柄
set(f,'units','norm','position',[.1 .1 .5 .5]) % Set units to norm, and re-size.%将GUI的显示也设置为normalized，此时GUI内所有控件的单位都是normalized，同时设置起始位置.
h=get(gcf,'Children');%获取GUI的所有子Object，由于除了Object以外，字体单位也应该设置为normalized才能保持一致性
h1=findobj(h,'FontUnits','points');%找到所有的FontUnits'为points类型的Object（默认字体都是points类型的，如果你做了修改，这里就要改下了）
set(h1,'FontUnits','norm');%所有FontUnits都设置为normalized
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using test.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles)
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
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


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



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
input = str2num(get(hObject,'String')); % string
if (isempty(input)) 
     set(hObject,'String','0') 
end 
guidata(hObject, handles); 

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
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Choose a data file(txt form)');
path = strcat(PathName,'/');
path_final = strcat(path,FileName);
data = importdata(path_final);
set(handles.edit1,'String',num2str(data(1,1)));
set(handles.edit5,'String',num2str(data(2,1)));
set(handles.edit9,'String',num2str(data(3,1)));
set(handles.edit13,'String',num2str(data(4,1)));
set(handles.edit17,'String',num2str(data(5,1)));
set(handles.edit21,'String',num2str(data(6,1)));

set(handles.edit2,'String',num2str(data(1,2)));
set(handles.edit6,'String',num2str(data(2,2)));
set(handles.edit10,'String',num2str(data(3,2)));
set(handles.edit14,'String',num2str(data(4,2)));
set(handles.edit18,'String',num2str(data(5,2)));
set(handles.edit22,'String',num2str(data(6,2)));


function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
cla;

x_offset = zeros(6,1);
y_offset = zeros(6,1);
y_diff_offset = zeros(2,1);

a = get(handles.edit1,'String');x_offset(1) = str2num(a);
a = get(handles.edit5,'String');x_offset(2) = str2num(a);
a = get(handles.edit9,'String');x_offset(3) = str2num(a);
a = get(handles.edit13,'String');x_offset(4) = str2num(a);
a = get(handles.edit17,'String');x_offset(5) = str2num(a);
a = get(handles.edit21,'String');x_offset(6) = str2num(a);

a = get(handles.edit2,'String');y_offset(1) = str2num(a);
a = get(handles.edit6,'String');y_offset(2) = str2num(a);
a = get(handles.edit10,'String');y_offset(3) = str2num(a);
a = get(handles.edit14,'String');y_offset(4) = str2num(a);
a = get(handles.edit18,'String');y_offset(5) = str2num(a);
a = get(handles.edit22,'String');y_offset(6) = str2num(a);

a = get(handles.edit25,'String'); y_diff_offset(1) = str2num(a);
a = get(handles.edit27,'String');y_diff_offset(2) = str2num(a);

n = length(x_offset);

spline_coeff = zeros(n+2,1);
spline_matrix = zeros(n+2,n+2);

power = [0,1,2,3];
x_matirx = zeros(n,4);
for i = 1:n
    for j = 1:4
        x_matirx(i,j) = x_offset(i)^power(j);
    end
end
spline_matrix(1:n,1:4) = x_matirx;
for i = 3:n
    for j = 5:i+2
        spline_matrix(i,j)= (x_offset(i)-x_offset(j-3))^3;
    end
end
spline_matrix(n+1,2)=1;
spline_matrix(n+1,3)=2*x_offset(1);
spline_matrix(n+1,4)=3*x_offset(1)^2;  %This is the matrix for the derivative at start point

spline_matrix(n+2,2)=1;  %This is the matrix for the derivative at the end point
spline_matrix(n+2,3)=2*x_offset(n);
spline_matrix(n+2,4)=3*x_offset(n)^2; 
for i = 5:n+2
    spline_matrix(n+2,i)=3*(x_offset(n)-x_offset(i-3))^2;
end

spline_right = zeros(n+2,1);
spline_right(1:n,1) = y_offset';
spline_right(n+1,1) = y_diff_offset(1);
spline_right(n+2,1) = y_diff_offset(2);

spline_coeff = inv(spline_matrix)*spline_right;

set(handles.text20,'String',num2str(spline_coeff(1)));
set(handles.text21,'String',num2str(spline_coeff(2)));
set(handles.text22,'String',num2str(spline_coeff(3)));
set(handles.text23,'String',num2str(spline_coeff(4)));
set(handles.text24,'String',num2str(spline_coeff(5)));
set(handles.text25,'String',num2str(spline_coeff(6)));
set(handles.text26,'String',num2str(spline_coeff(7)));
set(handles.text27,'String',num2str(spline_coeff(8)));

x_plot = linspace(x_offset(1),x_offset(n),1000);
N = length(x_plot);
x_plot_matrix = zeros(n+2,N);
x_plot_matrix(1,:)=x_plot.^0;
x_plot_matrix(2,:)=x_plot;
x_plot_matrix(3,:)=x_plot.^2;
x_plot_matrix(4,:)=x_plot.^3;
for i = 5:n+2
    for j= 1:N
        if(x_plot(j)>x_offset(i-3))
            x_plot_matrix(i,j)=(x_plot(j)-x_offset(i-3))^3;
        end
    end
end

plot(x_offset,y_offset,'o');
y_plot = spline_coeff'*x_plot_matrix;
hold on;
plot(x_plot,y_plot);
legend('Original Offset', 'Cubic Spline Interpolation Curve','Curve After Smooth');
xlabel('X','FontWeight','bold');
ylabel('Y','FontWeight','bold');
title('Original Offser, Cubic Spline Interpolation Curve Before and After Smooth','FontWeight','bold');

axes(handles.axes2);
cla;

x_plot_curve = zeros(n+2,N);
x_plot_curve(1,:)=0;
x_plot_curve(2,:)=0;
x_plot_curve(3,:)=2*x_plot.^0;
x_plot_curve(4,:)=6*x_plot;
for i = 5:n+2
    for j= 1:N
        if(x_plot(j)>x_offset(i-3))
            x_plot_curve(i,j) = 6*(x_plot(j)-x_offset(i-3));
        end
    end
end
y_curve = spline_coeff'*x_plot_curve;

plot(x_plot,y_curve);
xlabel('X','FontWeight','bold');
ylabel('Curvature \rho','FontWeight','bold');
title('Curvature','FontWeight','bold');


x_curvature = zeros(n+2,n);
x_curvature(1,:)=0;
x_curvature(2,:)=0;
x_curvature(3,:)=2*x_offset.^0;
x_curvature(4,:)=6*x_offset;
for i = 5:n+2
    for j= 1:n
        if(x_offset(j)>x_offset(i-3))
            x_curvature(i,j) = 6*(x_offset(j)-x_offset(i-3));
        end
    end
end
y_curve_judge = spline_coeff'*x_curvature;

flag = true;
for i = 2:n-1
    if (y_curve_judge(i-1)*y_curve_judge(i)<0 && y_curve_judge(i+1)*y_curve_judge(i)<0)
        flag = false;
    end
end

if(flag)
    set(handles.text10,'String','Not Smooth');
else
    set(handles.text10,'String','Smooth');
end

guidata(hObject, handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
cla;

x_offset = zeros(6,1);
y_offset = zeros(6,1);
y_diff_offset = zeros(2,1);

a = get(handles.edit1,'String');x_offset(1) = str2num(a);
a = get(handles.edit5,'String');x_offset(2) = str2num(a);
a = get(handles.edit9,'String');x_offset(3) = str2num(a);
a = get(handles.edit13,'String');x_offset(4) = str2num(a);
a = get(handles.edit17,'String');x_offset(5) = str2num(a);
a = get(handles.edit21,'String');x_offset(6) = str2num(a);

a = get(handles.edit2,'String');y_offset(1) = str2num(a);
a = get(handles.edit6,'String');y_offset(2) = str2num(a);
a = get(handles.edit10,'String');y_offset(3) = str2num(a);
a = get(handles.edit14,'String');y_offset(4) = str2num(a);
a = get(handles.edit18,'String');y_offset(5) = str2num(a);
a = get(handles.edit22,'String');y_offset(6) = str2num(a);

a = get(handles.edit25,'String'); y_diff_offset(1) = str2num(a);
a = get(handles.edit27,'String');y_diff_offset(2) = str2num(a);

n = length(x_offset);

spline_coeff = zeros(n+2,1);
smooth_coeff = zeros(n+2,1);

spline_matrix = zeros(n+2,n+2);

power = [0,1,2,3];
x_matirx = zeros(n,4);
for i = 1:n
    for j = 1:4
        x_matirx(i,j) = x_offset(i)^power(j);
    end
end
spline_matrix(1:n,1:4) = x_matirx;
for i = 3:n
    for j = 5:i+2
        spline_matrix(i,j)= (x_offset(i)-x_offset(j-3))^3;
    end
end
spline_matrix(n+1,2)=1;
spline_matrix(n+1,3)=2*x_offset(1);
spline_matrix(n+1,4)=3*x_offset(1)^2;  %This is the matrix for the derivative at start point

spline_matrix(n+2,2)=1;  %This is the matrix for the derivative at the end point
spline_matrix(n+2,3)=2*x_offset(n);
spline_matrix(n+2,4)=3*x_offset(n)^2; 
for i = 5:n+2
    spline_matrix(n+2,i)=3*(x_offset(n)-x_offset(i-3))^2;
end

spline_right = zeros(n+2,1);
spline_right(1:n,1) = y_offset';
spline_right(n+1,1) = y_diff_offset(1);
spline_right(n+2,1) = y_diff_offset(2);

smooth_matrix  = zeros(2*n,n+2);
smooth_matrix(1:n+2,1:n+2) = spline_matrix;
shear_force = eye(n-2,n-2);
smooth_matrix(n+3:2*n,5:n+2)=shear_force;

smooth_right=zeros(2*n,1);
smooth_right(1:n+2,1)=spline_right;

weight_dis = eye(n,n); %The weight of the displacement at each point
weight_diff = eye(2,2); %The weight of the derivative at the start and end point
weight_force = eye(n-2,n-2); %The weight of the shear force at each connection point

a = get(handles.edit3,'String');weight_dis(1) = str2num(a);
a = get(handles.edit7,'String');weight_dis(2) = str2num(a);
a = get(handles.edit11,'String');weight_dis(3) = str2num(a);
a = get(handles.edit15,'String');weight_dis(4) = str2num(a);
a = get(handles.edit19,'String');weight_dis(5) = str2num(a);
a = get(handles.edit23,'String');weight_dis(6) = str2num(a);

a = get(handles.edit26,'String');weight_diff(1) = str2num(a);
a = get(handles.edit28,'String');weight_diff(2) = str2num(a);

a = get(handles.edit8,'String');weight_force(1) = str2num(a);
a = get(handles.edit12,'String');weight_force(2) = str2num(a);
a = get(handles.edit16,'String');weight_force(3) = str2num(a);
a = get(handles.edit20,'String');weight_force(4) = str2num(a);

weight = eye(2*n,2*n); %initialize the weight matrix;
weight(1:n,1:n) = weight_dis;
weight(n+1:n+2,n+1:n+2) = weight_diff;
weight(n+3:2*n,n+3:2*n) = weight_force;

smooth_coeff = inv(smooth_matrix'*weight*smooth_matrix)*smooth_matrix'*weight*smooth_right;
spline_coeff = inv(spline_matrix)*spline_right;

set(handles.text20,'String',num2str(smooth_coeff(1)));
set(handles.text21,'String',num2str(smooth_coeff(2)));
set(handles.text22,'String',num2str(smooth_coeff(3)));
set(handles.text23,'String',num2str(smooth_coeff(4)));
set(handles.text24,'String',num2str(smooth_coeff(5)));
set(handles.text25,'String',num2str(smooth_coeff(6)));
set(handles.text26,'String',num2str(smooth_coeff(7)));
set(handles.text27,'String',num2str(smooth_coeff(8)));

x_plot = linspace(x_offset(1),x_offset(n),1000);
N = length(x_plot);
x_plot_matrix = zeros(n+2,N);
x_plot_matrix(1,:)=x_plot.^0;
x_plot_matrix(2,:)=x_plot;
x_plot_matrix(3,:)=x_plot.^2;
x_plot_matrix(4,:)=x_plot.^3;
for i = 5:n+2
    for j= 1:N
        if(x_plot(j)>x_offset(i-3))
            x_plot_matrix(i,j)=(x_plot(j)-x_offset(i-3))^3;
        end
    end
end

y_plot = spline_coeff'*x_plot_matrix;
y_plot_smooth = smooth_coeff'*x_plot_matrix;

plot(x_offset,y_offset,'o');
hold on;
plot(x_plot,y_plot);
hold on;
plot(x_plot,y_plot_smooth);

legend('Original Offset', 'Cubic Spline Interpolation Curve','Curve After Smooth');
xlabel('X','FontWeight','bold');
ylabel('Y','FontWeight','bold');
title('Original Offser, Cubic Spline Interpolation Curve Before and After Smooth','FontWeight','bold');

axes(handles.axes2);
cla;

x_plot_curve = zeros(n+2,N);
x_plot_curve(1,:)=0;
x_plot_curve(2,:)=0;
x_plot_curve(3,:)=2*x_plot.^0;
x_plot_curve(4,:)=6*x_plot;
for i = 5:n+2
    for j= 1:N
        if(x_plot(j)>x_offset(i-3))
            x_plot_curve(i,j) = 6*(x_plot(j)-x_offset(i-3));
        end
    end
end
y_curve = smooth_coeff'*x_plot_curve;

plot(x_plot,y_curve);
xlabel('X','FontWeight','bold');
ylabel('Curvature \rho','FontWeight','bold');
title('Curvature','FontWeight','bold');

x_curvature = zeros(n+2,n);
x_curvature(1,:)=0;
x_curvature(2,:)=0;
x_curvature(3,:)=2*x_offset.^0;
x_curvature(4,:)=6*x_offset;
for i = 5:n+2
    for j= 1:n
        if(x_offset(j)>x_offset(i-3))
            x_curvature(i,j) = 6*(x_offset(j)-x_offset(i-3));
        end
    end
end
y_curve_judge = smooth_coeff'*x_curvature;

flag = true;
for i = 2:n-1
    if (y_curve_judge(i-1)*y_curve_judge(i)<0 && y_curve_judge(i+1)*y_curve_judge(i)<0)
        flag = false;
    end
end

if(flag)
    set(handles.text10,'String','Smooth');
else
    set(handles.text10,'String','Not Smooth');
end



guidata(hObject, handles);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
delete(handles);


function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
