% name of packages to load
pkg load statistics

p2=[];
d=[];
e=[];
d=[5000,15000,50000,90000];
    for i=1:length(d)      
        e=[1,3,10,30,100]        
        for j=1:length(e)        
            if e(j)>9            
                samples=1000;        
            else                
                samples=10000;
            end           
            for runs=1:100    
                N = repmat('W', 100000, 1);       
                z=randsample(100000,d(i));        
                N(z)=['M'];        
                a=[];                
                n=poissrnd(e(j),1,samples);           
                for k=1:sum(n)                
                    x = randi(100000);                
                    a=[a N(x)];           
                end                
                b=sum(a == 'M');            
                c=(numel(a)-b)*0.7;           
                p=(b/(c+b));           
                disp(p)           
                v=ceil(p*100000);           
                gens=[];            
                p1=[];            
                for generations=1:1000                
                    N = repmat('W', 100000, 1);               
                    z=randsample(100000,v);               
                    N(z)=['M'];                
                    a=[];                
                    n=poissrnd(e(j),1,samples);                                 
                    for l=1:sum(n)                  
                        x = randi(100000);                    
                        a=[a N(x)];             
                    end                   
                    b=sum(a == 'M');               
                    c=(numel(a)-b)*0.7;               
                    p=(b/(c+b));              
                    disp(p)                
                    v=ceil(p*100000);               
                    gens=[gens;generations];              
                    p1=[p1;p];            
                end                
                p2(runs, 1:generations)=p1;            
                filename=sprintf('%s_%d_%d%s','WildFitness',i,j,'.csv');             
                csvwrite(filename,p2);        
            end            
        end        
    end
