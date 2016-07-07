classdef MetricTypes
    % MetricTypes
    
    properties
        displayString
        metricGroupType
        filenameTag
        dataRange
        isCircularData
        numConnections % used for Bonferroni Correction (0.05/numConnections)
    end
    
    enumeration
        % ** DIATTENUATION GROUP **
        Diattenuation (...
            'Diattenuation',...
            MetricGroupTypes.Diattenuation,...
            'Full',...
            [0,1],...
            false,...
            6);
        
        Diattenuation_Horizontal (...
            'Diattenuation - Horizontal',...
            MetricGroupTypes.Diattenuation,...
            'Horz',...
            [-1,1],...
            false,...
            4);
        
        Diattenuation_45deg (...
            'Diattenuation - 45�',...
            MetricGroupTypes.Diattenuation,...
            '45�',...
            [-1,1],...
            false,...
            4);
        
        Diattenuation_Circular (...
            'Diattenuation - Circular',...
            MetricGroupTypes.Diattenuation,...
            'Circ',...
            [-1,1],...
            false,...
            3);
        
        Diattenuation_Linear (...
            'Diattenuation - Linear',...
            MetricGroupTypes.Diattenuation,...
            'Lin',...
            [0,1],...
            false,...
            5);
        
        % ** POLARIZANCE GROUP **
        Polarizance (...
            'Polarizance',...
            MetricGroupTypes.Polarizance,...
            'Full',...
            [0,1],...
            false,...
            6);
        
        Polarizance_Horizontal (...
            'Polarizance - Horizontal',...
            MetricGroupTypes.Polarizance,...
            'Horz',...
            [-1,1],...
            false,...
            4);
        
        Polarizance_45deg (...
            'Polarizance - 45�',...
            MetricGroupTypes.Polarizance,...
            '45�',...
            [-1,1],...
            false,...
            4);
        
        Polarizance_Circular (...
            'Polarizance - Circular',...
            MetricGroupTypes.Polarizance,...
            'Circ',...
            [-1,1],...
            false,...
            3);
        
        Polarizance_Linear (...
            'Polarizance - Linear',...
            MetricGroupTypes.Polarizance,...
            'Lin',...
            [0,1],...
            false,...
            5);
        
        % ** RETARDANCE GROUP **
        Retardance (...
            'Retardance',...
            MetricGroupTypes.Retardance,...
            'Full',...
            [0,180],...
            true,...
            8);
        
        Retardance_Horizontal (...
            'Retardance - Horizontal',...
            MetricGroupTypes.Retardance,...
            'Horz',...
            [-180,180],...
            true,...
            6);
        
        Retardance_45deg (...
            'Retardance - 45�',...
            MetricGroupTypes.Retardance,...
            '45�',...
            [-180,180],...
            true,...
            6);
        
        Retardance_Circular (...
            'Retardance - Circular',...
            MetricGroupTypes.Retardance,...
            'Circ',...
            [-180,180],...
            true,...
            5);
        
        Retardance_Linear (...
            'Retardance - Linear',...
            MetricGroupTypes.Retardance,...
            'Lin',...
            [0,180],...
            true,...
            7);
        
        % ** GENERAL METRIC GROUP **        
        DepolarizationIndex (...
            'Depolarization Index',...
            MetricGroupTypes.GeneralMetrics,...
            'DI',...
            [0,1],...
            false,...
            20);
                
        DepolarizationPower (...
            'Depolarization Power',...
            MetricGroupTypes.GeneralMetrics,...
            'DP',...
            [0,1],...
            false,...
            6);
        
        QMetric (...
            'Q Metric',...
            MetricGroupTypes.GeneralMetrics,...
            'Q',...
            [0,3],...
            false,...
            6);
        
        % ** ADDITIONAL RETARDANCE METRICS **
        Psi (...
            'Psi (Optical Rotation)',...
            MetricGroupTypes.AdditionalRetardanceMetrics,...
            'Psi',...
            [-90,90],...
            true,...
            6);
        
        Theta (...
            'Theta (Fast Axis Orientation)',...
            MetricGroupTypes.AdditionalRetardanceMetrics,...
            'Theta',...
            [0,180],...
            true,...
            6);
        
        Delta (...
            'Delta (Linear Retardance)',...
            MetricGroupTypes.AdditionalRetardanceMetrics,...
            'Delta',...
            [0,180],...
            true,...
            6);
        
    end
    
    methods
        function enum = MetricTypes(displayString, metricGroupType, filenameTag, dataRange, isCircularData, numConnections)
            enum.displayString = displayString;
            enum.metricGroupType = metricGroupType;
            enum.filenameTag = filenameTag;
            enum.dataRange = dataRange;
            enum.isCircularData = isCircularData;
            enum.numConnections = numConnections;
        end
        
        function labels = getMetricLabels(metricType)
            if metricType.isCircularData
                labels{1} = [metricType.displayString, ' ', Constants.CIRC_STATS_LABEL];
                labels{2} = [metricType.displayString, ' ', Constants.NON_CIRC_STATS_LABEL];
            else
                labels{1} = metricType.displayString;
            end
        end
        
        function useCircStats = getUseCircStats(metricType)
            if metricType.isCircularData()
                useCircStats = {true, false};
            else
                useCircStats = {false};
            end
        end
    
    end
    
end
