p4=[];
for runs=1  
    N = repmat('W', 100000, 1);
    z=randsample(100000,5000);
    N(z)=['M'];
    n=poissrnd(10,1,1000);   
    a1=[];
    arr_mutP=[];
    for i=1:length(n)
        if n(i)>0
            a=[];
            for j=1:n(i)        
                x = randi(100000);
                a=[a N(x)];
            end           
            b=sum(a=='M');               
            c=sum(a=='W');     
            if c>0                  
                groupfrequency=(b+c)*c;              
            else                
                groupfrequency=(b+c);              
            end          
            MutFreq=(b/(b+c))*groupfrequency;
            WildFreq=(c/(b+c))*groupfrequency;           
            if groupfrequency==1               
                MutP=groupfrequency*0.5*0.3;  %0.3 is survival probability of spore                  
                WildP=groupfrequency*1*0.3;                               
            else               
                if MutFreq>0 && WildFreq>0                    
                    MutP=MutFreq*0.9;  %0.9 is survival probability of spore                   
                    WildP=WildFreq*0.7*0.9;                
                elseif MutFreq>0 && WildFreq==0                    
                    MutP=MutFreq*0.5*0.9;                
                elseif MutFreq==0 && WildFreq>0                    
                    WildP=WildFreq*0.9;                     
                end               
            end                               
            mutantproportion=MutP/(MutP+WildP);               
            a1=[a1 a];                 
        end
        arr_mutP=[arr_mutP mutantproportion];
    end
    mutantpool=mean(arr_mutP);  
    v=ceil(mutantpool*100000);    
    gens=[];   
    p3=[];
    for generations=1:1000     
        N = repmat('W', 100000, 1);   
        z=randsample(100000,v);    
        N(z)=['M'];       
        n=poissrnd(10,1,1000);        
        a1=[];      
        arr_mutP=[];
        for i=1:length(n)
            if n(i)>0                
                a=[];
                for j=1:n(i)           
                x = randi(100000);           
                a=[a N(x)];
                end
                b=sum(a=='M');
                c=sum(a=='W');
                if c>0              
                    groupfrequency=(b+c)*c; 
                else                   
                    groupfrequency=(b+c);           
                end    
                MutFreq=(b/(b+c))*groupfrequency;
                WildFreq=(c/(b+c))*groupfrequency;             
                if groupfrequency==1               
                    MutP=groupfrequency*0.5*0.3;  %0.3 is survival probability of spore               
                    WildP=groupfrequency*1*0.3;            
                else                   
                    if MutFreq>0 && WildFreq>0
                    MutP=MutFreq*0.9;  %0.9 is survival probability of spore                   
                    WildP=WildFreq*0.7*0.9;            
                    elseif MutFreq>0 && WildFreq==0                    
                    MutP=MutFreq*0.5*0.9;           
                    elseif MutFreq==0 && WildFreq>0                    
                    WildP=WildFreq*0.9;              
                    end                               
                end                               
                mutantproportion=MutP/(MutP+WildP);          
                a1=[a1 a];                
            end
            arr_mutP=[arr_mutP mutantproportion];
        end
        mutantpool=mean(arr_mutP); 
        disp(mutantpool)
        v=ceil(mutantpool*100000); 
        gens=[gens;generations];
        p3=[p3 mutantpool];   
    end 
    p4(runs, 1:generations)=p3;
    csvwrite('GroupSel.csv',p4);        
end