% name of packages to load
pkg load statistics

array_poisson_means = [];
array_proportion_mutants = [5000,15000,50000,90000];
total_population_size = 100000;

    for i=1:length(array_proportion_mutants)      
        array_poisson_means = [1,3,10,30,100]        
        % for loop to 
        for j=1:length(array_poisson_means) 
            % if loop to check to make sure that number of samples is not greater than total population size
            if array_poisson_means(j)>9
                samples=1000;        
            else                
                samples=10000;
            end           
            for runs=1:100    
                N = repmat('W', total_population_size, 1);       
                z=randsample(total_population_size,array_proportion_mutants(i));        
                N(z)=['M'];        
                a=[];                
                n=poissrnd(array_poisson_means(j),1,samples);           
                for k=1:sum(n)                
                    x = randi(total_population_size);                
                    a=[a N(x)];           
                end                
                b=sum(a == 'M');            
                c=numel(a);           
                p=(b/c);           
                disp(p)           
                v=ceil(p*total_population_size);           
                gens=[];            
                p1=[];            
                for generations=1:1000                
                    N = repmat('W', total_population_size, 1);               
                    z=randsample(total_population_size,v);               
                    N(z)=['M'];                
                    a=[];                
                    n=poissrnd(e(j),1,samples);                                 
                    for l=1:sum(n)                  
                        x = randi(total_population_size);                    
                        a=[a N(x)];             
                    end                   
                    b=sum(a == 'M');               
                    c=numel(a);               
                    p=(b/c);              
                    disp(p)                
                    v=ceil(p*total_population_size);               
                    gens=[gens;generations];              
                    p1=[p1;p];            
                end                
                p2(runs, 1:generations)=p1;            
                filename=sprintf('%s_%d_%d%s','NoFitness',i,j,'.csv');             
                csvwrite(filename,p2);        
            end            
        end        
    end
