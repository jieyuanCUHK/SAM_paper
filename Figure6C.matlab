%code for Figure 6C: calculate the mean non-zero pixel intensity in the red channel

clear all
%read in images:
for i=0:8
    if i<9
    %only using the red c blue channel  
       filenamer= strcat('Image 46_z00', int2str(i+1),'_c001'); 
       filenameb= strcat('Image 46_z00', int2str(i+1),'_c002');
    else
       filenamer= strcat('Image 43_z0', int2str(i+1),'_c001');
       filenameb= strcat('Image 43_z0', int2str(i+1),'_c002');
    end

    %only read in the red and blue channel  
    filename2r=strcat(filenamer,'.jpg');
    filename2b=strcat(filenameb,'.jpg');
    ar=imread(filename2r)
    ab=imread(filename2b)
    ar2=rgb2gray(ar)
    ab2=rgb2gray(ab)
    
    [height,width]=size(ar2)
    
    %store the image
    imageStackr(i+1,:,:) = ar2
    imageStackb(i+1,:,:) = ab2


end



%conduct maximum projection
mipr=max(imageStackr, [], 1)
mipb=max(imageStackb, [], 1)
    
a22r=reshape(mipr,height,width)
a22b=reshape(mipb,height,width)

%then do quantification on the red channel
tmp=a22r(:)
tmp(tmp==0)=[]
quantification=mean(tmp)

rgb=zeros(height,width,3); 
rgb(:,:,1)=a22r;
rgb(:,:,3)=a22b;
finalimage=uint8(rgb); 

%conduct image adjustment for output
finalimage(:,:,1)=imadjust(finalimage(:,:,1))
finalimage(:,:,2)=imadjust(finalimage(:,:,2))
finalimage(:,:,3)=imadjust(finalimage(:,:,3))

imwrite(finalimage,strcat(num2str(quantification),'_.jpg'))
