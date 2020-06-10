function coord=lin_interp_coord(coord,ck,rng,L,Z,T)

for i=1:size(ck,1)
    
    if coord(i,1)-1>0
        x1L=rng(coord(i,1)-1);
        x1R=rng(coord(i,1));
        f1L=Z(coord(i,1)-1,ck(i));
        f1R=Z(coord(i,1),ck(i));
        
        slope = (f1R-f1L) / (x1R-x1L);
        intercept = f1R-slope*x1R;
        
        x=(T-intercept)/slope;
        
        if ~isinf(x) && ~isnan(x)
            coord(i,1)=max(round(x),1);
        end
    else
        coord(i,1)=rng(coord(i,1));
    end
    
    if coord(i,2)+1<=size(Z,1)
        x2L=rng(coord(i,2));
        x2R=rng(coord(i,2)+1);
        f2L=Z(coord(i,2),ck(i));
        f2R=Z(coord(i,2)+1,ck(i));
        
        slope = (f2R-f2L) / (x2R-x2L);
        intercept = f2R-slope*x2R;
        
        x=(T-intercept)/slope;
        
        if ~isinf(x) && ~isnan(x)
            coord(i,2)=min(round(x),L);
        end
    else
        coord(i,2)=rng(coord(i,2));
    end
end