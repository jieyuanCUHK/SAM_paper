%quantification code for Figure 6E and Suppl Fig 6D: count green signal, i.e. the average intensity of each filtered dot.
clear all

for i = 0:11
        if i<9
          filename= strcat('sh-1.10_z0', int2str(i+1),'c2');
        else
          filename= strcat('sh-1.10_z', int2str(i+1),'c2');
        end
        filename2=strcat(filename,'.jpg');
        a = imread(filename2)
        a2=rgb2gray(a)
        [height,width]=size(a2)
        imageStack(i+1,:,:) = double(a2)     
end
%conduct maximum projection
mip=max(imageStack, [], 1)

A22 = reshape(mip,height,width)

%noise removal on the green channel
A33=A22>0.2*max(max(A22))
A22=A33.*A22

L2= bwlabeln(A22,8)
img_statsfinal = regionprops(L2, 'area', 'boundingbox','centroid');

k=length(img_statsfinal)
area2=[]
centers2=[]
count=1
for areas=1:k
  if img_statsfinal(areas).Area >5
    area2(count)=img_statsfinal(areas).Area
    centers2(count).center=img_statsfinal(areas).Centroid
    count=count+1
  end
end

%calculate the final radius using the mean size of the green dots
finalradius2=ceil(sqrt(mean(area2)/pi))

%generate masks using the final radius
area3=[]
maskindex=length(centers2)
for masking=1:maskindex
  mask=zeros(height,width)
  x0=centers2(masking).center(2)
  y0=centers2(masking).center(1)
  for x=1:height
    for y=1:width
      if (x-x0)^2+(y-y0)^2<=finalradius2^2
        mask(x,y)=255;
      end
    end
  end
%for each selected dot: count the green signal average intensity inside
  mask3=mask>0
  prefinal=double(A22).*mask3
  prefinal=prefinal(:)
  prefinal(prefinal==0)=[]
  quantification_andred=mean(prefinal)
  area3(masking)=quantification_andred     
end

%finally record the values in area3 variable
