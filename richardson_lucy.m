function deconvolved = richardson_lucy(image, otf, num_iters, varargin)

SHOW_PROGRESS = 0;
if nargin > 3
    SHOW_PROGRESS = 1;
end

if SHOW_PROGRESS
    progress = waitbar(0, 'Richardson-Lucy deconvolution progress...');
end
estimate = ones(size(image)) .* mean(image(:));
for i=1:num_iters
    reblurred = real(ifftn(fftn(estimate) .* otf));
    ratio = image ./ (reblurred + 1E-10);
    estimate = estimate .* real(ifftn(fftn(ratio) .* otf));
    if SHOW_PROGRESS
        waitbar(i / num_iters)
    end
end
if SHOW_PROGRESS
    close(progress);
end

deconvolved = estimate;
    
end
