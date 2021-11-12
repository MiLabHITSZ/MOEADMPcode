function Rank = FNDS(P)
    [Num_P,~] = size(P);
    Dom_Sp = false(Num_P,Num_P);
    BeDom_np = zeros(1,Num_P);
    Rank = zeros(Num_P,1);
    for i = 1:Num_P
        P_temp = repmat(P(i,:),Num_P,1);
        Dom_Sp(:,i) = dominate_min(P_temp,P);
        BeDom_np(:,i) = sum(dominate_min(P,P_temp));
        if BeDom_np(:,i) == 0
            Rank(i,:) = 1;
        end
    end
    level = 1;
    while any(Rank == 0)
        get_index = (find(Rank == level))';
        for j = get_index
            sp_index = find(Dom_Sp(:,j) == 1);
            BeDom_np(sp_index) = BeDom_np(sp_index) - 1;
            NextLevel = BeDom_np(sp_index) == 0;
            Rank(sp_index(NextLevel),:) = level + 1;
        end
        level = level + 1;
    end
end