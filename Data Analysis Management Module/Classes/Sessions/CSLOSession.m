classdef CSLOSession < DataCollectionSession
    %CSLOSession
    %holds metadata for images taken in a CSLO
    
    properties
        magnification
        pixelSizeMicrons % size of pixel in microns (used for generating scale bars)
        instrument
        confocalPinholeSizeMicrons %diameter of confocal pinhole in microns
        lightLevelMicroWatts %laser output level in microwatts
        fieldOfViewDegrees %field of view in degrees
        entrancePinholeSizeMicrons %diameter of entrance pinhole in microns
        
        % these three describe how the deposit was found
        fluoroSignature % T/F
        crossedSignature % T/F
        visualSignature % T/F
    end
    
    methods
        function [cancel, session] = enterMetadata(session, importPath, userName)
            
            %Call to CSLO Session Metadata Entry GUI
            [cancel, magnification, pixelSizeMicrons, instrument, entrancePinholeSizeMicrons, confocalPinholeSizeMicrons, lightLevelMicroWatts, fieldOfViewDegrees, sessionDate, sessionDoneBy, fluoroSignature, crossedSignature, visualSignature, rejected, rejectedReason, rejectedBy, notes] = CSLOSessionMetadataEntry(userName, importPath);
            
            if ~cancel
                %Assigning values to CSLO Session Properties
                session.magnification = magnification;
                session.pixelSizeMicrons = pixelSizeMicrons;
                session.instrument = instrument;
                session.entrancePinholeSizeMicrons = entrancePinholeSizeMicrons;
                session.confocalPinholeSizeMicrons = confocalPinholeSizeMicrons;
                session.lightLevelMicroWatts = lightLevelMicroWatts;
                session.fieldOfViewDegrees = fieldOfViewDegrees;
                session.sessionDate = sessionDate;
                session.sessionDoneBy = sessionDoneBy;
                session.fluoroSignature = fluoroSignature;
                session.crossedSignature = crossedSignature;
                session.visualSignature = visualSignature;
                session.rejected = rejected;
                session.rejectedReason = rejectedReason;
                session.rejectedBy = rejectedBy;
                session.notes = notes; 
            end
            
        end
        function metadataString = getMetadataString(session)
            
            [sessionDateString, sessionDoneByString, sessionNumberString, rejectedString, rejectedReasonString, rejectedByString, sessionNotesString] = getSessionMetadataString(session);
            
            magnificationString = ['Magnification: ' num2str(session.magnification)];
            pixelSizeMicronsString  = ['Pixel Size (microns): ', num2str(session.pixelSizeMicrons)];
            instrumentString = ['Instrument: ', session.instrument];
            fluoroSignatureString = ['Fluoro Signature: ', booleanToString(session.fluoroSignature)];
            crossedSignatureString = ['Crossed Signature: ', booleanToString(session.crossedSignature)];
            visualSignatureString = ['Visual Signature: ', booleanToString(session.visualSignature)];
            entrancePinholeSizeMicronsString = ['Entrance Pinhole Size (microns): ', num2str(session.entrancePinholeSizeMicrons)];
            confocalPinholeSizeMicronsString = ['Confocal Pinhole Size (microns): ', num2str(session.confocalPinholeSizeMicrons)];
            lightLevelMicroWattsString = ['Laser Power (microWatts): ', num2str(session.lightLevelMicroWatts)];
            fieldOfViewDegreesString = ['Field of View (degrees): ', num2str(session.fieldOfViewDegrees)];
            
            metadataString = [sessionDateString, sessionDoneByString, sessionNumberString, magnificationString, pixelSizeMicronsString, instrumentString, entrancePinholeSizeMicronsString, confocalPinholeSizeMicronsString, lightLevelMicroWattsString, fieldOfViewDegreesString, fluoroSignatureString, crossedSignatureString, visualSignatureString, rejectedString, rejectedReasonString, rejectedByString, sessionNotesString];
            
        end
    end
    
end
