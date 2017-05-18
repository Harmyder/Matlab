classdef ex_11_2
    % Exercise 11.2 
    % Fit x^{-1} by e^x, sin(x), Gamma(x)
    % y = a * gamma(x) + b * sin(x) + c * exp(x) - x.^(-1)
    properties
        m_SamplesCount;
        m_SamplesPoints;
    end
    
    methods
        function obj = ex_11_2(samplesCount)
            obj.m_SamplesCount = samplesCount;
            obj.m_SamplesPoints = linspace(0, 1, samplesCount);
        end
        
        function [a, b, c] = ls(obj)
            A = transpose([
                gamma(obj.m_SamplesPoints); 
                sin(obj.m_SamplesPoints); 
                exp(obj.m_SamplesPoints)
                ]);
            
            b = transpose(obj.m_SamplesPoints.^(-1)); 
            
            [Q, R] = qr(A, 0);
            
            b1 = transpose(Q) * b;
            
            x = inv(R) * b1;
            
            a = x(1);
            b = x(2);
            c = x(3);
        end
    end
end

