function ws = wseries (pc);
% Generate serioes from parallel cascade description
%

% Copyright 2003, Robert E Kearney and David T Westwick
% This file is part of the nlid toolbox, and is released under the GNU 
% General Public License For details, see ../copying.txt and ../gpl.txt 

num_paths=size(pc);
hlen=get(pc.nlm{1,1},'NLags');
k0 = 0;
k1 = zeros(hlen,1);
k2 = zeros(hlen,hlen);
for i=1:num_paths,
   h =double (pc.nlm{i,1});
   p=pc.nlm{i,2};
   set(p,'polyType','power');
   mc=get(p,'Coef');
   k0 = k0 + mc(1);
   if length (mc) > 1,
      k1 = k1 + mc(2)*h;
      if length(mc) >2,
         k2 = k2 + mc(3)*h*h';
      end
   end
end
incr=get(pc.nlm{1,1},'domainincr');
k0=wkern('order',0,'Comment','zero order kernel','domainincr',incr, 'data',k0);
k1=wkern('order',1,'comment','first-order kernel','domainincr',incr,'data',k1);
k2=wkern('order',2,'comment','second-order kernel','domainincr',incr,'data',k2);
k = { k0; k1; k2 };
ws=wseries;
set(ws,'elements',k);





  
