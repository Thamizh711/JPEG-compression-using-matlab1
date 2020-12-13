close all;
x=imread('house2.jpg'); 
[r,c] = size(x);
DF=zeros(r,c);
DFF=DF;
IDF=DF;
IDFF=DF;
depth=3;
N=8;

for i=1:N:r
    for j=1:N:c
        f=x(i:i+N-1,j:j+N-1);
        df=dct2(f);
        DF(i:i+N-1,j:j+N-1)=df;%DCT of the blocks
        dff=idct2(df);
        DFF(i:i+N-1,j:j+N-1)=dff;%inv DCT of the blocks
        
        df(N:-1:depth+1,:)=0;
        df(:,N:-1:depth+1)=0;
        IDF(i:i+N-1,j:j+N-1)=df; %DCT of block with depth considered
        dff=idct2(df);
        IDFF(i:i+N-1,j:j+N-1)=dff;%inv DCT of the blocks  with depth considered
    end
end

figure,imshow(DF/255);
title('DCT image ');
figure,imshow(IDF/255);
title('DCT quantized image');
A=DFF/255;
figure,imshow(A);
imwrite(A,'abc1.jpeg');
title('original image');
B=IDFF/255;
imwrite(B,'abc2.jpeg');

figure,imshow(B);
title('compressed image');

N=imnoise(B,'salt & pepper',0.1);
figure,imshow(N);
title('noise image');
error=immse(N , B);
psnr=10*log(320*320/error);
file=B;
new_file=strrep(file,'.jpeg','.png');
imwrite(new_file,'im.png');
figure,imshow(new_file);
title('png image');

