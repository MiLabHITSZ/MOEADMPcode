classdef MPMOP1 < handle
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
            obj.M = 4;
            obj.DM = 2;
            obj.D = d;
            obj.min = [1,zeros(1,obj.D-1)];
            obj.max = [4,ones(1,obj.D-1)];
        end
        %% Calculate objective values for each party
        function PopObj = CalV(obj,PopDec) 
            PopObj(:,[1:obj.M/2])=MPMOP_Value('MPMOP1', PopDec, 1);
            PopObj(:,[obj.M/2+1:obj.M])=MPMOP_Value('MPMOP1', PopDec, 2);
        end
        %% Sample reference points on Pareto front
        function P = PF(obj)
            t1=1;
            t2=2;
            [~,true_y1,true_y2]=true_PS(obj.D,'MPMOP1',t1,t2);
            P=[true_y1,true_y2];
        end
        
        %% Sample reference points on Pareto optimal set
        function P = PS(obj)
            t1=1;
            t2=2;
            P=true_PS(obj.D,'MPMOP1',t1,t2);
        end
        
    end
end