function Characteristics(H,T,Ho,To,step,fig,C,name)
%Program was written to map characteristics (1/07/10)
%The program color_line is used to add colormap which represents C.
H = mean(Ho) + H;
H = [Ho H];
T = [To T];
C = [C(:,1) C];
%If the figure already exhists lets not change to text size
if ishandle(fig)
    figure(fig)
    Exs = 'on';
    fprintf(' Figure %2.0f already exhists.\n',fig)
else
    fg1 = figure(fig)
    axes('Parent',fg1,'FontSize',16);
    Exs = 'on';
end
for n = 1:step:size(H,1)
    color_line(H(n,1:n+1),T(n,1:n+1),C(n,1:n+1),C(n,1:n+1),'linewidth',2); hold on
    if n == 1
        n = n + 1;
        color_line(H(n:end,n),T(n:end,n),C(n:end,n),C(n:end,n),'linewidth',2);
    else
        color_line(H(n-1:end,n),T(n-1:end,n),C(n-1:end,n),C(n-1:end,n),'linewidth',2);
    end
end
if strcmp('on',Exs)
    set(gcf,'windowstyle','docked')
    %If the figure exhists dont label
    xlabel('Lagrangian Depth (µm)','FontSize',16)
    ylabel('Time (ns)','FontSize',16)
    h = colorbar('peer',gca,'FontSize',16);
    set(get(h,'title'),'String',name,'Rotation',360,'FontSize',16)
end
%plot(H(352,1:352+1),T(352,1:352+1),'k','linewidth',2); hold on