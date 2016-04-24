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
            if n(i)==1               
                MutP=b*0.5;  %0.3 is survival probability of spore                  
                WildP=c*1;                               
            else               
                if b>0 && c>0                    
                    MutP=b;  %0.9 is survival probability of spore                   
                    WildP=c*0.7;                
                elseif b>0 && c==0                    
                    MutP=b*0.5;                
                elseif b==0 && c>0                    
                    WildP=c;                     
                end               
            end            
            if c>0                  
                groupfrequency=(MutP+WildP)*c;              
            else                
                groupfrequency=(MutP+WildP);              
            end                       
            mutantproportion=MutP/groupfrequency;               
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
                if n(i)==1               
                    MutP=b*0.5;  %0.3 is survival probability of spore               
                    WildP=c*1;            
                else                  
                    if b>0 && c>0                   
                        MutP=b;  %0.9 is survival probability of spore                 
                        WildP=c*0.7;                
                    elseif b>0 && c==0                    
                        MutP=b*0.5;                
                    elseif b==0 && c>0                  
                        WildP=c;                
                    end                    
                end              
                if c>0              
                    groupfrequency=(MutP+WildP)*c;          
                else                   
                    groupfrequency=(MutP+WildP);           
                end               
                mutantproportion=MutP/groupfrequency;          
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
               