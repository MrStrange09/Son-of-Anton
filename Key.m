function [key] = Key(n,pass)
n = n*8;
temp = zeros(n,1,'uint8');
p =  pass * 0.000001;
t = 0;

for i = 2 : n
    t = 1 - 2* p* p;    
     if (t > 0.0)
        temp(i-1) = 1;
    end 
     p =  t;
     
end

key = zeros(n/8,1,'uint8');
for i = 1 : n/8
    
    for j = 1 : 8
    key(i) = key(i) + temp(j*i)* 2^ (8-j) ;
    end
      
end