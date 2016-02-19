function varargout = MicroscopeSessionMetadataEntry(varargin)
% MICROSCOPESESSIONMETADATAENTRY MATLAB code for MicroscopeSessionMetadataEntry.fig
%      MICROSCOPESESSIONMETADATAENTRY, by itself, creates a new MICROSCOPESESSIONMETADATAENTRY or raises the existing
%      singleton*.
%
%      H = MICROSCOPESESSIONMETADATAENTRY returns the handle to a new MICROSCOPESESSIONMETADATAENTRY or the handle to
%      the existing singleton*.
%
%      MICROSCOPESESSIONMETADATAENTRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MICROSCOPESESSIONMETADATAENTRY.M with the given input arguments.
%
%      MICROSCOPESESSIONMETADATAENTRY('Property','Value',...) creates a new MICROSCOPESESSIONMETADATAENTRY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MicroscopeSessionMetadataEntry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MicroscopeSessionMetadataEntry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MicroscopeSessionMetadataEntry

% Last Modified by GUIDE v2.5 19-Feb-2016 10:46:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MicroscopeSessionMetadataEntry_OpeningFcn, ...
                   'gui_OutputFcn',  @MicroscopeSessionMetadataEntry_OutputFcn, ...
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
end

% --- Executes just before MicroscopeSessionMetadataEntry is made visible.
function MicroscopeSessionMetadataEntry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MicroscopeSessionMetadataEntry (see VARARGIN)

% Choose default command line output for MicroscopeSessionMetadataEntry
handles.output = hObject;

% *****************************
% INPUT: (userName, importPath)
% *****************************

handles.userName = varargin{1}; %Param is userName
handles.importPath = varargin{2}; % Param is importPath

%Defining the different input variables, awaiting user input
handles.magnification = MicroscopeNamingConventions.DEFAULT_METADATA_GUI_MAGNIFICATION;
handles.pixelSizeMicrons = MicroscopeNamingConventions.DEFAULT_METADATA_GUI_PIXEL_SIZE_MICRONS;
handles.instrument = MicroscopeNamingConventions.DEFAULT_METADATA_GUI_INSTRUMENT;
handles.fluoroSignature = 0;
handles.crossedSignature = 0;
handles.visualSignature = 0;
handles.sessionDate = '';
handles.sessionDoneBy = handles.userName;
handles.sessionNotes = '';
handles.rejected = 0;
handles.rejectedReason = '';
handles.rejectedBy = '';

handles.cancel = false;

set(handles.importPathTitle, 'String', handles.importPath);
set(handles.sessionDoneByInput, 'String', handles.userName);
set(handles.magnificationInput, 'String', num2str(MicroscopeNamingConventions.DEFAULT_METADATA_GUI_MAGNIFICATION));
set(handles.pixelSizeInput, 'String', num2str(MicroscopeNamingConventions.DEFAULT_METADATA_GUI_PIXEL_SIZE_MICRONS));
set(handles.instrumentInput, 'String', MicroscopeNamingConventions.DEFAULT_METADATA_GUI_INSTRUMENT);
set(handles.yesRejectedButton, 'Value', 0);
set(handles.noRejectedButton, 'Value', 1);
set(handles.OK, 'enable', 'off');
set(handles.reasonForRejectionInput, 'enable', 'off');
set(handles.rejectedByInput, 'enable', 'off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MicroscopeSessionMetadataEntry wait for user response (see UIRESUME)
uiwait(handles.MicroscopeSessionMetadataEntry);
end

% --- Outputs from this function are returned to the command line.
function varargout = MicroscopeSessionMetadataEntry_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ******************************************************************************************************************************************************************************
% OUTPUT: [cancel, magnification, pixelSizeMicrons, instrument, fluoroSignature, crossedSignature, visualSignature, sessionDate, sessionDoneBy, notes, rejected, rejectedReason]
% ******************************************************************************************************************************************************************************

%Output from GUI
varargout{1} = handles.cancel;
varargout{2} = handles.magnification;
varargout{3} = handles.pixelSizeMicrons;
varargout{4} = handles.instrument;
varargout{5} = handles.fluoroSignature;
varargout{6} = handles.crossedSignature;
varargout{7} = handles.visualSignature;
varargout{8} = handles.sessionDate;
varargout{9} = handles.sessionDoneBy;
varargout{10} = handles.sessionNotes;
varargout{11} = handles.rejected;
varargout{12} = handles.rejectedReason;
varargout{13} = handles.rejectedBy;

close(handles.MicroscopeSessionMetadataEntry);
end


function magnificationInput_Callback(hObject, eventdata, handles)
% hObject    handle to magnificationInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of magnificationInput as text
%        str2double(get(hObject,'String')) returns contents of magnificationInput as a double

if isnan(str2double(get(hObject, 'String')))
    
    set(handles.magnificationInput, 'String', '');
    handles.magnification = [];
    
    warndlg('Magnification must be numerical.', 'Magnification Error', 'modal'); 
    
else
    handles.magnification = str2double(get(hObject, 'String'));
end

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function magnificationInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to magnificationInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function pixelSizeInput_Callback(hObject, eventdata, handles)
% hObject    handle to pixelSizeInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pixelSizeInput as text
%        str2double(get(hObject,'String')) returns contents of pixelSizeInput as a double

if isnan(str2double(get(hObject, 'String')))
    
    set(handles.pixelSizeInput, 'String', '');
    handles.pixelSizeMicrons = [];
    
    warndlg('Pixel size must be numerical.', 'Pixel Size Error', 'modal'); 
    
else
    handles.pixelSizeMicrons = str2double(get(hObject, 'String'));
end

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function pixelSizeInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pixelSizeInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function instrumentInput_Callback(hObject, eventdata, handles)
% hObject    handle to instrumentInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of instrumentInput as text
%        str2double(get(hObject,'String')) returns contents of instrumentInput as a double

handles.instrument = get(hObject, 'String');

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function instrumentInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to instrumentInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes during object creation, after setting all properties.
function sessionDateDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionDateDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function sessionDoneByInput_Callback(hObject, eventdata, handles)
% hObject    handle to sessionDoneByInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sessionDoneByInput as text
%        str2double(get(hObject,'String')) returns contents of sessionDoneByInput as a double

handles.sessionDoneBy = get(hObject, 'String');

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function sessionDoneByInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionDoneByInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function sessionNotesInput_Callback(hObject, eventdata, handles)
% hObject    handle to sessionNotesInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sessionNotesInput as text
%        str2double(get(hObject,'String')) returns contents of sessionNotesInput as a double

handles.sessionNotes = strjoin(rot90(cellstr(get(hObject, 'String'))));

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function sessionNotesInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionNotesInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

enableLineScrolling(hObject);

end


function reasonForRejectionInput_Callback(hObject, eventdata, handles)
% hObject    handle to reasonForRejectionInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reasonForRejectionInput as text
%        str2double(get(hObject,'String')) returns contents of reasonForRejectionInput as a double

handles.rejectedReason = strjoin(rot90(cellstr(get(hObject, 'String'))));

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function reasonForRejectionInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reasonForRejectionInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

enableLineScrolling(hObject);

end

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exit = questdlg('Are you sure you want to quit?','Quit','Yes','No','No'); 
switch exit
    case 'Yes'
        %Clears variables in the case that they wish to exit the program
        handles.cancel = true;
        
        handles.magnification = [];
        handles.pixelSizeMicrons = [];
        handles.instrument = '';
        handles.fluoroSignature = [];
        handles.crossedSignature = [];
        handles.visualSignature = [];
        handles.sessionDate = '';
        handles.sessionDoneBy = '';
        handles.sessionNotes = '';
        handles.rejected = [];
        handles.rejectedReason = '';
        handles.rejectedBy = '';
        guidata(hObject, handles);
        uiresume(handles.MicroscopeSessionMetadataEntry);
    case 'No'
end


end

% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);
uiresume(handles.MicroscopeSessionMetadataEntry);

end


% --- Executes on button press in fluoroBox.
function fluoroBox_Callback(hObject, eventdata, handles)
% hObject    handle to fluoroBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fluoroBox

handles.fluoroSignature = get(hObject, 'Value');

checkToEnableOkButton(handles);

guidata(hObject, handles);
end

% --- Executes on button press in crossedBox.
function crossedBox_Callback(hObject, eventdata, handles)
% hObject    handle to crossedBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of crossedBox

handles.crossedSignature = get(hObject, 'Value');

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes on button press in visualBox.
function visualBox_Callback(hObject, eventdata, handles)
% hObject    handle to visualBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of visualBox

handles.visualSignature = get(hObject, 'Value');

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes on button press in yesRejectedButton.
function yesRejectedButton_Callback(hObject, eventdata, handles)
% hObject    handle to yesRejectedButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of yesRejectedButton

set(handles.yesRejectedButton, 'Value', 1);

handles.rejected = true;
handles.rejectedBy = handles.userName;

set(handles.noRejectedButton, 'Value', 0);

set(handles.reasonForRejectionInput, 'enable', 'on');
set(handles.rejectedByInput, 'enable', 'on');
set(handles.rejectedByInput, 'String', handles.userName);

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes on button press in noRejectedButton.
function noRejectedButton_Callback(hObject, eventdata, handles)
% hObject    handle to noRejectedButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noRejectedButton
set(handles.noRejectedButton, 'Value', 1);

handles.rejected = false;

set(handles.yesRejectedButton, 'Value', 0);

checkToEnableOkButton(handles);

set(handles.reasonForRejectionInput, 'enable', 'off');
set(handles.reasonForRejectionInput, 'String', '');
set(handles.rejectedByInput, 'enable', 'off');
set(handles.rejectedByInput, 'String', '');

handles.rejectedReason = '';
handles.rejectedBy = '';

guidata(hObject, handles);

end

% --- Executes when user attempts to close MicroscopeSessionMetadataEntry.
function MicroscopeSessionMetadataEntry_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to MicroscopeSessionMetadataEntry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    handles.cancel = true;
    handles.magnification = [];
    handles.pixelSizeMicrons = [];
    handles.instrument = '';
    handles.fluoroSignature = [];
    handles.crossedSignature = [];
    handles.visualSignature = [];
    handles.sessionDate = '';
    handles.sessionDoneBy = '';
    handles.sessionNotes = '';
    handles.rejected = [];
    handles.rejectedReason = '';
    handles.rejectedBy = '';
    guidata(hObject, handles);
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    handles.cancel = true;
    handles.magnification = [];
    handles.pixelSizeMicrons = [];
    handles.instrument = '';
    handles.fluoroSignature = [];
    handles.crossedSignature = [];
    handles.visualSignature = [];
    handles.sessionDate = '';
    handles.sessionDoneBy = '';
    handles.sessionNotes = '';
    handles.rejected = [];
    handles.rejectedReason = '';
    handles.rejectedBy = '';
    guidata(hObject, handles);
    delete(hObject);
end
end

function importPathTitle_Callback(hObject, eventdata, handles)
% hObject    handle to importPathTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of importPathTitle as text
%        str2double(get(hObject,'String')) returns contents of importPathTitle as a double

set(handles.importPathTitle, 'String', handles.importPath);
guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function importPathTitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to importPathTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in pickImagingDate.
function pickImagingDate_Callback(hObject, eventdata, handles)
% hObject    handle to pickImagingDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

serialDate = guiDatePicker(now);

handles.sessionDate = serialDate;
set(handles.sessionDateDisplay, 'String', displayDate(serialDate));

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

function rejectedByInput_Callback(hObject, eventdata, handles)
% hObject    handle to rejectedByInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rejectedByInput as text
%        str2double(get(hObject,'String')) returns contents of rejectedByInput as a double

handles.rejectedBy = get(hObject, 'String');

checkToEnableOkButton(handles);

guidata(hObject, handles);


end

% --- Executes during object creation, after setting all properties.
function rejectedByInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rejectedByInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%% Local Functions

function checkToEnableOkButton(handles)

%This function will check to see if any of the input variables are empty,
%and if not it will enable the OK button

if ~isempty(handles.magnification) && ~isempty(handles.pixelSizeMicrons) && ~isempty(handles.instrument) && ~isempty(handles.sessionDate) && ~isempty(handles.sessionDoneBy) && ~isempty(handles.rejected)
    if handles.rejected 
        if ~isempty(handles.rejectedReason) && ~isempty(handles.rejectedBy)
            set(handles.OK, 'enable', 'on');
        else
            set(handles.OK, 'enable', 'off');
        end
    else
        set(handles.OK, 'enable', 'on');
    end
else
    set(handles.OK, 'enable', 'off');
end

end


