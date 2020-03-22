%Visuazliation code for Figure 6E and Suppl Fig 6D:

clear all
%read in images:
for i=0:12
    if i<9
       filenamer= strcat('sh-1.9_z0', int2str(i+1),'c1'); %a=imread('ko-1,0.jpg')
       filenameg= strcat('sh-1.9_z0', int2str(i+1),'c2'); %a=imread('ko-1,0.jpg')
       filenameb= strcat('sh-1.9_z0', int2str(i+1),'c3');
    else
       filenamer= strcat('sh-1.9_z', int2str(i+1),'c1');
       filenameg= strcat('sh-1.9_z', int2str(i+1),'c2');
       filenameb= strcat('sh-1.9_z', int2str(i+1),'c3');
    end

    filename2r=strcat(filenamer,'.jpg');
    filename2g=strcat(filenameg,'.jpg');
    filename2b=strcat(filenameb,'.jpg');
    ar=imread(filename2r)
    ag=imread(filename2g)
    ab=imread(filename2b)
    ar2=rgb2gray(ar)
    ag2=rgb2gray(ag)
    ab2=rgb2gray(ab)
    
    [height,width]=size(ar2)
    
    %Store the images
    imageStackr(i+1,:,:) = ar2
    imageStackg(i+1,:,:) = ag2
    imageStackb(i+1,:,:) = ab2


end

%do maximum projection
mipr=max(imageStackr, [], 1)
mipg=max(imageStackg, [], 1)
mipb=max(imageStackb, [], 1)
    
a22r=reshape(mipr,height,width)
a22g=reshape(mipg,height,width)
a22b=reshape(mipb,height,width)


rgb=zeros(height,width,3); 
rgb(:,:,1)=a22r;

rgb2=zeros(height,width,3); 
rgb2(:,:,2)=a22g;

rgb3=zeros(height,width,3); 
rgb3(:,:,3)=a22b;

%image adjustment for final output:
finalimage=uint8(rgb); 
finalimage(:,:,1)=imadjust(finalimage(:,:,1))

finalimage2=uint8(rgb2); 
finalimage2(:,:,2)=imadjust(finalimage2(:,:,2))

finalimage3=uint8(rgb3); 
finalimage3(:,:,3)=imadjust(finalimage3(:,:,3))

imwrite(finalimage,'red_.jpg')
imwrite(finalimage2,'green_.jpg')
imwrite(finalimage3,'blue_.jpg')
