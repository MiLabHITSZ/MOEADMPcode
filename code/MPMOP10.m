classdef MPMOP10< handle
% <MPMOP>
    properties
    %% Initialization
        M;
        D;
        DM;
        min;
        max;
        encoding = 'real';
    end
    methods
        %% Initialization
        function obj = Init_D(obj,d)
           obj.M = 9;
           obj.DM = 3;
           obj.D = d;
           obj.min = zeros(1,obj.D);
           obj.max = ones(1,obj.D);
        end
        %% Calculate objective values for each party
        function PopObj = CalV(obj,PopDec)
            PopObj(:,[1:obj.M/3])=MPMOP_Value('MPMOP5', PopDec, 0);
            PopObj(:,[obj.M/3+1:2*obj.M/3])=MPMOP_Value('MPMOP5', PopDec, 1);
            PopObj(:,[2*obj.M/3+1:obj.M])=MPMOP_Value('MPMOP5', PopDec, 1.5);           
        end
        %% Sample reference points on Pareto front
        function P = PF(obj)
            t1=0;
            t2=1;
            t3=1.5;
            [~,true_y1,true_y2,true_y3]=true_PS(obj.D,'MPMOP10',t1,t2,t3);
            P=[true_y1,true_y2,true_y3];
        end
        
        %% Sample reference points on Pareto optimal set
        function P = PS(obj)
            t1=0;
            t2=1;
            t3=1.5;
            P=true_PS(obj.D,'MPMOP10',t1,t2,t3);
        end
        
    end
end