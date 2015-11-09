classdef EXP3G<handle
    % EXP 3G
    properties
        W % graph : adjacency matrix
        gamma % exploration rate
        eta % learning rate
        qt %
        It % action
        l_t % estimator of lt
    end
    
    methods
        
        function self = EXP3G(W,gamma,eta)
            self.W = W;
            self.gamma = gamma;
            self.eta = eta;
            self.It = 1;
        end
        
        function self = init(self)
        self.qt=(1/size(self.W,1))*ones(1,size(self.W,1));
        self.l_t=zeros(1,size(self.W,1));
        end

        function self = play(self,lt)
            %Draw It with pt distribution
            pt=(1-self.gamma)*self.qt+self.gamma*(1/size(self.W,1))*ones(1,size(self.W,1));
            pt=pt/sum(pt);
            self.It=draw(pt)+1;
            
            Pt=zeros(size(self.W,1),1);
            for i=1:size(self.W,1)
                for j=1:size(self.W,1)
                    if self.W(j,i) == 1
                        Pt(i)=Pt(i)+pt(j);
                    end
                end
                
                if Pt(i) > 0
                    self.l_t(i) = (self.W(self.It,i)==1)*lt(i)/Pt(i);
                else
                    self.l_t(i) = Inf;
                end
            end
        end
        
        function self = update(self)
            self.qt=self.qt.*exp(self.eta*self.l_t)./(sum(self.qt.*exp(-self.eta*self.l_t)));
        end
                
    end    
end