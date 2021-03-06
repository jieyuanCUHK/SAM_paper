Code for the manuscript "Image processing code for the manuscript "Long noncoding RNA SAM promotes myoblast proliferation through stablizing Sugt1 and facilitating kinetochore assembly"
===
All code here are tested in Matlab R2014b.

## 1. Figure6C.matlab
Code for Figure 6C: calculate the mean non-zero pixel intensity in the red channel and store the output image finally.

## 2. Suppl_Figure_6C.matlab
Code for Suppl Figure 6C: calculate the mean non-zero pixel intensity in the red channel and store the output image finally.

## 3. Figure6D and Suppl 5I.matlab
Code for Figure 6D and Suppl Fig 5I: quantify the mean green channel intensity inside the nucleus (blue color) and store the output image finally.

## 4. Quantification Code-Figure 6E and Suppl Fig 6D.matlab
Code for Figure 6E and Suppl Fig 6D: quantify the mean green channel intensity in each filtered dot, not generating the final output image.

## 5. Visualization code-Fig 6E and Suppl Fig 6D.matlab
Code for Figure 6E and Suppl Fig 6D: store the final output image.

## 6. ImageCount software
<div align=center><img height="300" src="https://github.com/jieyuanCUHK/SAM_paper/raw/master/ImageCount_introduction.png"/></div><br>

Interative software used for easily quantifying Collagen 1 in Dia muscle Collagen staining images and Collagen positive areas in Masson's Trichrome staining on Dia muscles. 
More detailed explanation on the four functions:

<div align=center><img height="500" src="https://github.com/jieyuanCUHK/SAM_paper/raw/master/ImageCount_mainfunctions.png"/></div><br>
<div style="font-color: blue" align=center>Main functions in ImageCount</div>

#### (1) Color image with region to eliminate
Can conduct Collagen 1 quantification in Dia muscle Collagen staining images. Firstly remove the possible very large interstitial regions (black regions) in the image, 
then count the percentage of pixels that brighter than an automatically-defined threshold (decided by graythresh() function) in the green channel. The results will be included in "celldata.txt".
This function is used in Figure 3I in the manuscript.

#### (2) Color image without region to eliminate
Similar with (1), but do not include the interstitial region elimination step.

#### (3) Images with region to eliminate
Can conduct Collagen positive area quantification in Dia muscle Masson's Trichrome staining images. Firstly remove the possible very large interstitial regions (white regions) in the image, 
then count the percentage of pixels that brighter than an automatically-defined threshold (decided by graythresh() function) in the blue channel. The results will be included in "celldata.txt".
This function is used in Figure 3J in the manuscript.

#### (4) Images without regions to eliminate
Similar with (3), but do not include the interstitial region elimination step.

### Please notice that you need to install the MATLAB Compiler Runtime (MCR) online using "MyAppInstaller_web.exe" if you do not have it deposited in your computer.
