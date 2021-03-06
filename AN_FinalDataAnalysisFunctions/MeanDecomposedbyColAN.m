function [newdata2] = MeanDecomposedbyColAN(nms,nms2,dir,midcoord,fincoord,index1,param1,flag,N,thresh)


for k=1:size(nms,2)        % load however many files are in the nms string
    filename{k} = [dir filesep  nms{k} '.mat'];
    load(filename{k},'peaks','plate1');
    disp(['loaded file: ' filename{k}]);
    col = plate1.colonies;
    for ii=1:length(col)
        
        ncell = size(col(ii).data,1);
        if ncell == N
            b = col(ii).data(:,index1(1))./col(ii).data(:,5);
            non = col(ii).data(:,index1(1));
            %plot(b,c,'.','Color',colors(ncell,:),'MarkerSize',10); hold on;% use scatter
            
            if b>thresh
                newdata2(k,1)=mean(b);
                newdata2(k,2)=std(b);
                newdata2(k,3)=mean(non);
                
            elseif isempty(thresh)
                newdata2(k,1)=mean(b);
                newdata2(k,2)=std(b);
                newdata2(k,3)=mean(non);
            end
            
        end
        if flag == 1
            
            figure(7),errorbar(newdata2(:,1),newdata2(:,2)) ;
            
            set(gca,'Xtick',1:size(nms2,2));
            set(gca,'Xticklabel',nms2);
            limit2 = max(newdata2(:,1))+0.5;
            ylim([0 limit2]);
            
            if size(index1) == 1
                ylabel(param1);
            else
                ylabel([param1,'/DAPI']);
            end
        end
        
    end
end
