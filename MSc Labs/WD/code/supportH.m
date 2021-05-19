function result = supportH(x, S)

if S > size(x,1)
    error('Too large S');
end

x = x.^2;
[~,result] = maxk(x,S);
result = sort(result);
end