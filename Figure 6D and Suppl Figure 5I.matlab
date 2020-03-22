%code for Figure 6d and Suppl Fig 5i: quantify the green color inside the blue color (nucleus);
clear all

parfor i=0:11        
    if i<9
    %c_001 image: green channel
    %c_002 image: blue channel
       filenamer= strcat('wt7_z00', int2str(i+1),'_c001');
       filenameb= strcat('wt7_z00', int2str(i+1),'_c002');
    
    else
       filenamer= strcat('wt7_z0', int2str(i+1),'_c001');
       filenameb= strcat('wt7_z0', int2str(i+1),'_c002');
    end
    
    filename2r=strcat(filenamer,'.jpg');
    filename2b=strcat(filenameb,'.jpg');
    
    ar=imread(filename2r)
    ab=imread(filename2b)
    ar2=rgb2gray(ar)
    ab2=rgb2gray(ab)

    %store the image
    imageStackr(i+1,:,:) = ar2
    imageStackb(i+1,:,:) = ab2

end

[dim,height,width]=size(imageStackr)

%do maximum projection
mipr=max(imageStackr, [], 1)
mipb=max(imageStackb, [], 1)    
a22r=reshape(mipr,height,width)
a22b=reshape(mipb,height,width)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%then conduct quantification

%Only quantify the green color inside the nucleus
a22bforvisual=a22b
a22b=a22b>=max(mean(a22b))

%a22b: is the image of nucleus region before filtering

%just leave the largest area on a22b for nucleus region, which will be used in future calculation:
L = bwlabeln(a22b, 8);
S = regionprops(L, 'Area');

areablue=[]
for areas=1:length(S)
    areablue(areas)=S(areas).Area 
end

%the largest area (nucleus) is stored in a22b:
bw2 = ismember(L, find([S.Area]==max(areablue)));
a22b=bw2

%then for these green color, first check whether they have dots with size>=7*7, only eligible images will be counted the intensity
%green channel mask to reduce the noise
a22r_mask=a22r>=max(mean(a22r))

L2 = bwlabeln(a22r_mask, 8);
img_stats = regionprops(L2, 'area', 'boundingbox','centroid');
k=length(img_stats)
area=[]
for areas=1:k
    area(areas)=img_stats(areas).Area
end

if sum(area>=49)>=1 
  stringinside='has'
else
  stringinside='not'
end

%then count the mean non-zero pixel intensity in the green channel
tmp_b_and_r=(a22r.*uint8(a22r_mask)).*uint8(a22b)
tmp_b_and_r=tmp_b_and_r(:)
quantification_andred=mean(tmp_b_and_r)


rgb=zeros(height,width,3); 
rgb(:,:,2)=a22r
rgb(:,:,3)=a22bforvisual;
finalimage=zeros(height,width,3);
finalimage=uint8(rgb); 
%image adjustment
finalimage(:,:,2)=imadjust(finalimage(:,:,2))
finalimage(:,:,3)=imadjust(finalimage(:,:,3))

imwrite(finalimage,strcat(num2str(quantification_andred),'_',stringinside,'_.jpg'))
