classdef MetricGroupTypes
    % MetricGroupTypes
    
    properties
        displayString
        dirName
        explanationString
    end
    
    enumeration
        Diattenuation (...
            'Diattenuation',...
            'Diattenuation',...
            'Contains all metrics that are determined from the diattenuation matrix found through the Lu-Chipman decomposition.');
        
        Polarizance (...
            'Polarizance',...
            'Polarizance',...
            'Contains all metrics that are determined from the polarizance matrix found through the Lu-Chipman decomposition.');
            
        Retardance (...
            'Retardance',...
            'Retardance',...
            'Contains all metrics that are determined from the retardance matrix found through the Lu-Chipman decomposition.');
        
        GeneralMetrics (...
            'General Metrics',...
            'General Metrics',...
            'Contains the metrics that are determined from the all of the Mueller Matrix entries, instead of just select indices. In particular, the Degree of Polarization, Depolarization Index, and Q Metric are found here.');
        
        AdditionalRetardanceMetrics (...
            'Additional Retardance Metrics',...
            'More Retardance Metrics',...
            'Contains additional retardance metrics that use the elements from the retardance matrix, but are not the standard set found in the Retardance directory.');
        
        StatsAndHistograms (...
            'Statistics And Histograms',...
            'Stats And Histograms',...
            'Contains some basic statistics and histograms of the metrics computed');
        
        MuellerMatrix (...
            'Mueller Matrix',...
            'MM',...
            'Contains the raw Mueller Matrix as produced by the normalization and computation method selected');
            
    end
    
    methods
        function enum = MetricGroupTypes(displayString, dirName, explanationString)
            enum.displayString = displayString;
            enum.dirName = dirName;
            enum.explanationString = explanationString;
        end
    end
    
end

