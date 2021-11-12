function Pop = Init_Pop(MOP,N)
    if strcmp(MOP.encoding,'real')
        Pop = unifrnd(repmat(MOP.min,N,1),repmat(MOP.max,N,1),N,MOP.D);
    elseif strcmp(MOP.encoding,'bin')
        Pop = randi([0,1],N,MOP.D);
    end
end