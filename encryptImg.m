function [ImageOut] = encryptImg(ImageIn,key)


[m n k] = size(ImageIn);
for i = 1 : n    
    p = (1+(i-1)*m);
    q = (((i-1)*m)+m);
    FullKey(:,i) = key( p : q );
   
end

for i = 1 : k
    Img = ImageIn(:,:,i);
for x = 1 : m
    for y = 1 : n     
        Image(x,y) = bitxor(Img(x,y),FullKey(x,y));        
    end
end
ImageOut(:,:,i) = Image(:,:,1);
end

return;