function varargout = LegacySubsectionSelectionSessionMetadataEntry(varargin)
% LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY MATLAB code for LegacySubsectionSelectionSessionMetadataEntry.fig
%      LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY, by itself, creates a new LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY or raises the existing
%      singleton*.
%
%      H = LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY returns the handle to a new LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY or the handle to
%      the existing singleton*.
%
%      LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY.M with the given input arguments.
%
%      LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY('Property','Value',...) creates a new LEGACYSUBSECTIONSELECTIONSESSIONMETADATAENTRY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LegacySubsectionSelectionSessionMetadataEntry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LegacySubsectionSelectionSessionMetadataEntry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LegacySubsectionSelectionSessionMetadataEntry

% Last Modified by GUIDE v2.5 08-Mar-2016 11:18:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LegacySubsectionSelectionSessionMetadataEntry_OpeningFcn, ...
                   'gui_OutputFcn',  @LegacySubsectionSelectionSessionMetadataEntry_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1}) && ~isempty(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before LegacySubsectionSelectionSessionMetadataEntry is made visible.
function LegacySubsectionSelectionSessionMetadataEntry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LegacySubsectionSelectionSessionMetadataEntry (see VARARGIN)

% Choose default command line output for LegacySubsectionSelectionSessionMetadataEntry
handles.output = hObject;

%***************************************************************
%INPUT: (importPath, userName, sessionChoices, isEdit, session*)
%        *may be empty)
%***************************************************************

handles.importPath = varargin{1}; %Param is importPath
handles.userName = varargin{2}; %Param is userName
handles.sessionChoices = varargin{3}; %Param is sessionChoices

isEdit = varargin{4};

session = [];

if length(varargin) > 4
    session = varargin{5};
end

if isempty(session)
    session = LegacySubsectionSelectionSession;
end
    
handles.cancel = false;

if isEdit    
    set(handles.importPathTitle, 'Visible', 'off');
    set(handles.importPathDisplay, 'Visible', 'off');
    
    handles.sessionDate = session.sessionDate;    
    handles.sessionDoneBy = session.sessionDoneBy;
    handles.linkedSessionNumbers = session.linkedSessionNumbers;
    handles.croppingType = session.croppingType;
    
    handles.coords = session.coords;
    
    handles.rejected = session.rejected;
    handles.rejectedReason = session.rejectedReason;
    handles.rejectedBy = session.rejectedBy;
    handles.sessionNotes = session.notes;
    
else
    defaultSession = LegacySubsectionSelectionSession;
    
    set(handles.importPathDisplay, 'String', handles.importPath);
        
    handles.sessionDate = session.sessionDate;
    
    if isempty(session.sessionDoneBy)
        handles.sessionDoneBy = handles.userName;
    else    
        handles.sessionDoneBy = session.sessionDoneBy;    
    end
    
    handles.linkedSessionNumbers = session.linkedSessionNumbers;
    handles.croppingType = defaultSession.croppingType;
    
    handles.coords = defaultSession.coords;
    
    handles.rejected = defaultSession.rejected;
    handles.rejectedReason = defaultSession.rejectedReason;
    handles.rejectedBy = defaultSession.rejectedBy;
    handles.sessionNotes = defaultSession.notes;
end

if isempty(handles.coords)
    handles.xCoord = [];
    handles.yCoord = [];
    handles.width = [];
    handles.height = [];
else
    handles.xCoord = handles.coords(1);
    handles.yCoord = handles.coords(2);
    handles.width = handles.coords(3);
    handles.height = handles.coords(4);
end

% ** SET TEXT FIELDS **

if isempty(handles.sessionDate) || handles.sessionDate == 0
    set(handles.sessionDateDisplay, 'String', '');
else    
    set(handles.sessionDateDisplay, 'String', displayDate(handles.sessionDate));
end

set(handles.sessionDoneByInput, 'String', handles.sessionDoneBy);
set(handles.sessionNotesInput, 'String', handles.sessionNotes);

set(handles.xCoordInput, 'String', num2str(handles.xCoord));
set(handles.yCoordInput, 'String', num2str(handles.yCoord));
set(handles.widthInput, 'String', num2str(handles.width));
set(handles.heightInput, 'String', num2str(handles.height));


% ** SET POP UP MENUS **

[choices, ~] = choicesFromEnum('CroppingTypes');
defaultChoiceString = 'Select a Cropping Type';

selectedChoice = handles.croppingType;


setPopUpMenu(handles.croppingTypeMenu, defaultChoiceString, choices, selectedChoice);


% ** SET LISTBOXES **

listBoxHandle = handles.sessionListBox;

setSessionListBox(listBoxHandle, handles.sessionChoices, handles.linkedSessionNumbers);


% ** SET REJECTED INPUTS **

handles = setRejectedInputFields(handles); 

% ** SET DONE BUTTON **

checkToEnableOkButton(handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LegacySubsectionSelectionSessionMetadataEntry wait for user response (see UIRESUME)
uiwait(handles.legacySubsectionSelectionSessionMetadataEntry);
end

% --- Outputs from this function are returned to the command line.
function varargout = LegacySubsectionSelectionSessionMetadataEntry_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%********************************************************************************************************************************
%OUTPUT:  [cancel, sessionDate, sessionDoneBy, notes, croppingType, coords, rejected, rejectedReason, rejectedBy, sessionChoices]
%********************************************************************************************************************************

handles.sessionChoices = getSessionNumbersFromListBox(handles.sessionListBox, handles.sessionChoices);
guidata(hObject, handles);

% Get default command line output from handles structure
varargout{1} = handles.cancel;
varargout{2} = handles.sessionDate;
varargout{3} = handles.sessionDoneBy;
varargout{4} = handles.sessionNotes;
varargout{5} = handles.croppingType;
varargout{6} = handles.coords;
varargout{7} = handles.rejected;
varargout{8} = handles.rejectedReason;
varargout{9} = handles.rejectedBy;
varargout{10} = handles.sessionChoices;

close(handles.legacySubsectionSelectionSessionMetadataEntry);
end


function importPathDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to importPathDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of importPathDisplay as text
%        str2double(get(hObject,'String')) returns contents of importPathDisplay as a double

set(handles.importPathDisplay, 'String', handles.importPath);
guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function importPathDisplay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to importPathDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function sessionDateDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to sessionDateDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sessionDateDisplay as text
%        str2double(get(hObject,'String')) returns contents of sessionDateDisplay as a double
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

% --- Executes on button press in sessionDatePick.
function sessionDatePick_Callback(hObject, eventdata, handles)
% hObject    handle to sessionDatePick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

justDate = true;

serialDate = guiDatePicker(now, justDate);

handles.sessionDate = serialDate;

setDateInput(handles.sessionDateDisplay, serialDate, justDate);

checkToEnableOkButton(handles);

guidata(hObject, handles);


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

% --- Executes on selection change in croppingTypeMenu.
function croppingTypeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to croppingTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns croppingTypeMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from croppingTypeMenu

[choices, ~] = choicesFromEnum('CroppingTypes');


% Check if value is default value
if get(hObject, 'Value') == 1 
    handles.croppingType = [];
else
    handles.croppingType = choices(get(hObject, 'Value')-1); 
end

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function croppingTypeMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to croppingTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function xCoordInput_Callback(hObject, eventdata, handles)
% hObject    handle to xCoordInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xCoordInput as text
%        str2double(get(hObject,'String')) returns contents of xCoordInput as a double

%Get value from input box
if isnan(str2double(get(hObject, 'String')))
    
    set(handles.xCoordInput, 'String', '');
    handles.xCoord = [];
    
    warndlg('X Coordinate must be numerical.', 'Coordinates Error', 'modal'); 
    
else
    handles.xCoord = str2double(get(hObject, 'String'));
end

handles.coords = [handles.xCoord, handles.yCoord, handles.width, handles.height];

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function xCoordInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xCoordInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function yCoordInput_Callback(hObject, eventdata, handles)
% hObject    handle to yCoordInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yCoordInput as text
%        str2double(get(hObject,'String')) returns contents of yCoordInput as a double

%Get value from input box
if isnan(str2double(get(hObject, 'String')))
    
    set(handles.yCoordInput, 'String', '');
    handles.yCoord = [];
    
    warndlg('Y Coordinate must be numerical.', 'Coordinates Error', 'modal'); 
    
else
    handles.yCoord = str2double(get(hObject, 'String'));
end

handles.coords = [handles.xCoord, handles.yCoord, handles.width, handles.height];

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function yCoordInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yCoordInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function widthInput_Callback(hObject, eventdata, handles)
% hObject    handle to widthInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of widthInput as text
%        str2double(get(hObject,'String')) returns contents of widthInput as a double

%Get value from input box
if isnan(str2double(get(hObject, 'String')))
    
    set(handles.widthInput, 'String', '');
    handles.width = [];
    
    warndlg('Width must be numerical.', 'Width Error', 'modal'); 
    
else
    handles.width = str2double(get(hObject, 'String'));
end

handles.coords = [handles.xCoord, handles.yCoord, handles.width, handles.height];

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function widthInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widthInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function heightInput_Callback(hObject, eventdata, handles)
% hObject    handle to heightInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heightInput as text
%        str2double(get(hObject,'String')) returns contents of heightInput as a double

%Get value from input box
if isnan(str2double(get(hObject, 'String')))
    
    set(handles.heightInput, 'String', '');
    handles.height = [];
    
    warndlg('Height must be numerical.', 'Height Error', 'modal'); 
    
else
    handles.height = str2double(get(hObject, 'String'));
end

handles.coords = [handles.xCoord, handles.yCoord, handles.width, handles.height];

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function heightInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heightInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function rejectedReasonInput_Callback(hObject, eventdata, handles)
% hObject    handle to rejectedReasonInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rejectedReasonInput as text
%        str2double(get(hObject,'String')) returns contents of rejectedReasonInput as a double

handles.rejectedReason = strjoin(rot90(cellstr(get(hObject, 'String'))));

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function rejectedReasonInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rejectedReasonInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

enableLineScrolling(hObject);

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
        
        handles.sessionDate = [];
        handles.sessionDoneBy = '';
        handles.sessionNotes = '';
        handles.croppingType = [];
        handles.xCoord = [];
        handles.yCoord = [];
        handles.width = [];
        handles.height = [];
        handles.coords = [handles.xCoord, handles.yCoord, handles.width, handles.height];
        handles.rejected = [];
        handles.rejectedReason = '';
        handles.rejectedBy = '';
        guidata(hObject, handles);
        uiresume(handles.legacySubsectionSelectionSessionMetadataEntry);
    case 'No'
end

end

% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);
uiresume(handles.legacySubsectionSelectionSessionMetadataEntry);

end

% --- Executes on button press in yesRejectedButton.
function yesRejectedButton_Callback(hObject, eventdata, handles)
% hObject    handle to yesRejectedButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of yesRejectedButton

set(handles.noRejectedButton, 'Value', 0);

handles.rejected = true;

set(handles.yesRejectedButton, 'Value', 1);

set(handles.rejectedReasonInput, 'enable', 'on');
set(handles.rejectedByInput, 'enable', 'on');
set(handles.rejectedByInput, 'String', handles.userName);

handles.rejectedBy = handles.userName;

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

set(handles.rejectedReasonInput, 'enable', 'off');
set(handles.rejectedByInput, 'enable', 'off');
set(handles.rejectedReasonInput, 'String', '');
set(handles.rejectedByInput, 'String', '');

handles.rejectedBy = '';
handles.rejectedReason = '';

checkToEnableOkButton(handles);

guidata(hObject, handles);

end

% --- Executes when user attempts to close legacySubsectionSelectionSessionMetadataEntry.
function legacySubsectionSelectionSessionMetadataEntry_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to legacySubsectionSelectionSessionMetadataEntry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    handles.cancel = true;
    handles.sessionDate = [];
    handles.sessionDoneBy = '';
    handles.sessionNotes = '';
    handles.croppingType = [];
    handles.xCoord = [];
    handles.yCoord = [];
    handles.width = [];
    handles.height = [];
    handles.coords = [handles.xCoord, handles.yCoord, handles.width, handles.height];
    handles.rejected = [];
    handles.rejectedReason = '';
    handles.rejectedBy = '';
    guidata(hObject, handles);
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    handles.cancel = true;
    handles.sessionDate = [];
    handles.sessionDoneBy = '';
    handles.sessionNotes = '';
    handles.croppingType = [];
    handles.xCoord = [];
    handles.yCoord = [];
    handles.width = [];
    handles.height = [];
    handles.coords = [handles.xCoord, handles.yCoord, handles.width, handles.height];
    handles.rejected = [];
    handles.rejectedReason = '';
    handles.rejectedBy = '';
    guidata(hObject, handles);
    delete(hObject);
end
end


% --- Executes on selection change in sessionListBox.
function sessionListBox_Callback(hObject, eventdata, handles)
% hObject    handle to sessionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sessionListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sessionListBox

checkToEnableOkButton(handles);

end

% --- Executes during object creation, after setting all properties.
function sessionListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%% Local Functions

function checkToEnableOkButton(handles)

%This function will check to see if any of the input variables are empty,
%and if not it will enable the OK button

if ~isempty(handles.sessionDate) && ~isempty(handles.sessionDoneBy) && ~isempty(handles.croppingType) && ~isempty(handles.xCoord) && ~isempty(handles.yCoord) && ~isempty(handles.width) && ~isempty(handles.height) && ~isempty(handles.rejected) && ~isempty(get(handles.sessionListBox, 'Value'))
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




