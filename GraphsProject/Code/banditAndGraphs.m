%Plot graphs
addpath('gplotdc')
% 
% %Strongly observable graph
% n=5;
% Wstrong=strongGraph(n);
% coord=randn(n,2);
% gplotdc(Wstrong,coord,'LineWidth',2,'MarkerSize',8);
% 
% %Weakly observable graph
% n=10;
% W=weakGraph(10);
% coord=randn(n,2);
% gplotdc(W,coord,'LineWidth',2,'MarkerSize',8);
% 
% %Non observable graph
% n=10;
% W=nonObservableGraph(n);
% coord=randn(n,2);
% gplotdc(W,coord,'LineWidth',2,'MarkerSize',8);





% Revealing action graph
W_revealing=[ones(1,10);[zeros(9,1) eye(9,9)]];
%W_revealing(1,1)=0; % use unstability
%W_revealing(2,1)=1;
coord=randn(10,2);
gplotdc(W_revealing,coord,'LineWidth',2,'MarkerSize',8);
alpha = 4;
delta = 1;

% sequence of loss functions
% "Worst case"
T=2000;
N=10;
lt=rand(N,T);


% Run EXP3G algorithm
W=W_revealing;
gamma=min(sqrt((1/alpha*T)),1/2); %min {sqrt ( 1/(alpha*T)^(0.5) , 1/2) } and eta = 2 * gamma
eta=2*gamma;
E=EXP3G(W,gamma,eta);
E.init();

N_monte_carlo=2000;
Regret=zeros(T,N_monte_carlo);
for n=1:N_monte_carlo
        loss_t=zeros(1,T);
        
    for t=1:T

        E.play(lt(:,t));
        E.update();
        loss_t(1,t)=lt(E.It,t);
        Regret(t,n)=sum(loss_t)-min(sum(lt(:,[1:t]),2));
    end
    %if mod(floor(100*n/N_monte_carlo),100)==0
        disp(n);
    %end
end
regret = (1/N_monte_carlo)*sum(Regret,2);
