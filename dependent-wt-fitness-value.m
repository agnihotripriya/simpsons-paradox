p4=[];
for runs=1   
    N = repmat('W', 100000, 1);
    z=randsample(100000,5000);
    N(z)=['M'];
    n=poissrnd(10,1,1000);
    p1=[]; 
    a1=[];
    d1=[];
    b1=[];
    for i=1:length(n)
        if n(i)>0
            a=[];
            for j=1:n(i)        
                x = randi(100000);
                a=[a N(x)];
            end               
                b=sum(a=='M');
                c=sum(a=='W');
                if b>0 && c>0
                    d=(c*0.7)+b;                
                elseif b>0 && c==0
                    d=b;
                elseif b==0 && c>0
                    d=c;        
                end
                p=b/d;
                p1=[p1 p];                        
                a1=[a1 a];              
                d1=[d1 d];
                b1=[b1 b];
        end
        b2=sum(b1);
        d2=sum(d1);
        p2=mean(p1);
    end    
    v=ceil((b2/d2)*100000);    
    gens=[];    
    p1=[]; 
    p3=[];
    for generations=1:500       
        N = repmat('W', 100000, 1);   
        z=randsample(100000,v);    
        N(z)=['M'];       
        n=poissrnd(1,1,10000);
        p1=[];
        a1=[];
        d1=[];
        b1=[];
        for i=1:length(n)
            if n(i)>0 
                a=[];
                for j=1:n(i)           
                x = randi(100000);           
                a=[a N(x)];
                end
                b=sum(a=='M');
                c=sum(a=='W');               
                if b>0 && c>0
                    d=(c*0.7)+b;
                elseif b>0 && c==0
                    d=b;
                elseif b==0 && c>0
                    d=c;
                end 
                p=b/d;
                p1=[p1 p];                           
                a1=[a1 a];              
                d1=[d1 d];
                b1=[b1 b];  
            end           
            b2=sum(b1);
            d2=sum(d1);
            p2=mean(p1);            
        end 
        proportion=b2/d2;
        disp(proportion)
        v=ceil((b2/d2)*100000);   
        gens=[gens;generations];
        p3=[p3 proportion];
    end
    p4(runs, 1:generations)=p3;
    csvwrite('WildWithinFitness.csv',p4);   
end    
    
               
    