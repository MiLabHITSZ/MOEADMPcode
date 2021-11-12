function fin = dominate_min(a,b)
    fin = (min(a <= b,[],2) == 1) & (max(a < b,[],2) == 1);
end