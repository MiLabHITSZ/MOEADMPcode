function WV = WV_generator(N,m)
    H = 0;
    while nchoosek(H+m-1,m-1) <= N
        H = H+1;
    end
    H = H-1;
    n = nchoosek(H+m-1,m-1);
    WV_idx = nchoosek(1:(H+m-1),m-1);
    WV = zeros(n,m);
    for i = 1:n
        for j = 2:m-1
            WV(i,j) = (WV_idx(i,j)-WV_idx(i,j-1)-1)/H;
        end
    end
    WV(:,1) = (WV_idx(:,1)-1)/H;
    WV(:,m) = (H+m-1-WV_idx(:,m-1))/H;
    WV = max(WV,1e-6);
end