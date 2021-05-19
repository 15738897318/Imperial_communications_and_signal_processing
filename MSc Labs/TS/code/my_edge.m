function I_edge = my_edge(I,kernal)
% get the edge of the image based on the kernal
scale = 4;
I_edge = abs(conv2(I, kernal,'same'));
cutoff = scale * sum(I_edge(:),'double') / numel(I_edge);
thresh = sqrt(cutoff);
I_edge(I_edge > thresh) = 1;
I_edge(I_edge <= thresh) = 0;

end

