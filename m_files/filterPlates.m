% a function wich filters out cuts that might not be a license plate 
% it returns a cell array wich the top row containing the cuts that are 
% probably licence plates and the bottom rom containing their BBs
function res = filterPlates(cuts)
   res = {};
   resi = 0;
   for i = 1:1:length(cuts)
       BBs = getCharBBs(cuts{i});
       [~,N] = size(BBs);
       if N >= 6
           res{:, resi} = {cuts{i}; BBs};
       end
   end
end