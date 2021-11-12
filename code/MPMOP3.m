classdef MPMOP3< handle
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
            obj.min = [0,ones(1,obj.D-1).*(-1)];
            obj.max = ones(1,obj.D);
        end
        %% Calculate objective values for each party
        function PopObj = CalV(obj,PopDec)
            PopObj(:,[1:obj.M/2])=MPMOP_Value('MPMOP3', PopDec, 0);
            PopObj(:,[obj.M/2+1:obj.M])=MPMOP_Value('MPMOP3', PopDec,pi/2);
        end
        %% Sample reference points on Pareto front
        function P = PF(obj)
            t1=0;
            t2=pi/2;
            [~,true_y1,true_y2]=true_PS(obj.D,'MPMOP3',t1,t2);
            P=[true_y1,true_y2];
        end
        
        %% Sample reference points on Pareto optimal set
        function P = PS(obj)
            t1=0;
            t2=pi/2;
            P=true_PS(obj.D,'MPMOP3',t1,t2);
        end
     
        
    end
end