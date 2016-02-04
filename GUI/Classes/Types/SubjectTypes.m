classdef SubjectTypes
    %SubjectTypes
    
    properties
        displayString
        subjectClass
    end
    
    enumeration
        Dog         ('Dog', NaturalSubject)
        Human       ('Human', NaturalSubject)
        PureAmyloid ('Pure Amyloid', ArtificalSubject)
    end
    
    methods
        function enum = SubjectTypes(string, class)
            enum.displayString = string;
            enum.subjectClass = class;
        end
    end
    
end

