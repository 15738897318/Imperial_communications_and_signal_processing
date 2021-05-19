function orderedH = orderedHadamard(size)
H=hadamard(size); 
kernal = [0,0,0;0,1,-1;0,0,0];
zeroCorssing = abs(conv2(H,kernal,'same'));
zeroCorssing(zeroCorssing~=2) = 0;
[~,I] = sort(sum(zeroCorssing,2)/2); % get the order
orderedH = H(I,:); % order the image
end

