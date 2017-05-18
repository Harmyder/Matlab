function y = Lagrange(x, sampleX, sampleY)
    if size(sampleX,2) ~= size(sampleY,2)
        error('sampleX and sampleY of different lengths');
    else
        len_x = length(x);
        len_sample = length(sampleX);
        L = zeros(len_sample, len_x);
        for j = 1:len_sample
            L(j, :) = lj(x, j, sampleX);
        end
        
        y = sampleY * L;
    end
    
    function ljs = lj(x, j, samplesX)
        ljs = ones(1, length(x));
        for i = 1:length(samplesX)
            if i ~= j
                ljs = ljs .* (x - samplesX(i)) / (samplesX(j) - samplesX(i));
            end
        end
    end
end