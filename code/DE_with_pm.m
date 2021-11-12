function offspring = DE_with_pm(X1,X2,X3,MOP)

    D = MOP.D;
    r_pm = zeros(1,D);
    %DE parameter
    CR = 0.7;
    F = 0.5;
    pm = 1/D;
    dis_idx = 20;
    
    %变异算子
    Ut = X1 + F * (X2 - X3);
    
    %交叉算子（二项式交叉）

    cross_index = rand(1,D) < CR;
    if sum(cross_index) == 0
        cross_index(1,randi(D)) = true;
    end
    offspring = X1;
    offspring(1,cross_index) = Ut(1,cross_index);

    
    %处理越界问题    
    lb = MOP.min;
    ub = MOP.max;
    x = offspring;
    length_bound = ub - lb;
%     x=(x<lb).*(lb+rem((lb-x), length_bound))+(x>=lb).*x;
%     x=(x>ub).*(ub-rem((x-ub), length_bound))+(x<=ub).*x;
    x=(x<lb).*(lb)+(x>=lb).*x;
    x=(x>ub).*(ub)+(x<=ub).*x;
    
    %polynomial mutation
        
%     for i = 1:D
%         r_rand = rand;
%         if r_rand < 0.5
%             r_pm(:,i) = (2 * r_rand)^(1/(dis_idx + 1))-1;
%         else
%             r_pm(:,i) = 1-(2-2 * r_rand)^(1/(dis_idx + 1));
%         end
%     end
% 
%     y_pm = r_pm .* length_bound;
%     pm_idx = rand(1,D) < pm;
%     x(:,pm_idx) = x(:,pm_idx) + y_pm(:,pm_idx);

    pm_idx = rand(1,D) < pm;
    r_rand = rand(1,D);

    for i = 1:D
        if r_rand(1,i) <= 0.5
            r_pm(:,i) = (2*r_rand(1,i) + (1-2*r_rand(1,i))*(1-(x(:,i)-lb(:,i))/length_bound(:,i))^(dis_idx+1))^(1/(dis_idx+1))-1;
        else
            r_pm(:,i) = 1-(2*(1-r_rand(1,i)) + 2*(r_rand(1,i)-0.5)*(1-(ub(:,i)-x(:,i))/length_bound(:,i))^(dis_idx+1))^(1/(dis_idx+1));
        end
    end

    y_pm = r_pm .* length_bound;
    x(:,pm_idx) = x(:,pm_idx) + y_pm(:,pm_idx);   

    %处理越界问题
    x=(x<lb).*(lb)+(x>=lb).*x;
    x=(x>ub).*(ub)+(x<=ub).*x;
        
    offspring = x;
    
end