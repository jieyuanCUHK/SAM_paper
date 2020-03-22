%code for Figure 6C: calculate the mean non-zero pixel intensity in the red channel

clear all
%read in images:
for i=0:7
    if i<9
       filenamer= strcat('sh-10czi_z00', int2str(i+1),'_c001'); %a=imread('ko-1,0.jpg')
       filenameg= strcat('sh-10czi_z00', int2str(i+1),'_c002'); %a=imread('ko-1,0.jpg')
       filenameb= strcat('sh-10czi_z00', int2str(i+1),'_c003');
    else
       filenamer= strcat('sh-5czi_z0', int2str(i+1),'_c001');
       filenameg= strcat('sh-5czi_z0', int2str(i+1),'_c002');
       filenameb= strcat('sh-5czi_z0', int2str(i+1),'_c003');
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
    
    %store the image
    imageStackr(i+1,:,:) = ar2
    imageStackg(i+1,:,:) = ag2
    imageStackb(i+1,:,:) = ab2


end



%conduct maximum projection
mipr=max(imageStackr, [], 1)
mipg=max(imageStackg, [], 1)
mipb=max(imageStackb, [], 1)
    
a22r=reshape(mipr,height,width)
a22g=reshape(mipg,height,width)
a22b=reshape(mipb,height,width)

%then do quantification on the red channel
tmp=a22r(:)
tmp(tmp==0)=[]
quantification=mean(tmp)

rgb=zeros(height,width,3); 
rgb(:,:,1)=a22r;
rgb(:,:,3)=a22b;
rgb(:,:,2)=a22g;
finalimage=uint8(rgb); 

%conduct image adjustment for output
finalimage(:,:,1)=imadjust(finalimage(:,:,1))
finalimage(:,:,2)=imadjust(finalimage(:,:,2))
finalimage(:,:,3)=imadjust(finalimage(:,:,3))

imwrite(finalimage,strcat(num2str(quantification),'_.jpg'))
