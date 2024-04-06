




clc; % clear the command window
clear all; 
close all;% clear the workspace
% close all

disp   ('       ');

disp  (' ***** WELCOME TO IMAGE HIDER *****');

disp   ('       ');

disp   (' ******* Enter ur choice **********');


task =input('****---Encode :- 1 \n****---Decode :- 2\n Enter your task:');

% select task
if isempty  (task)
task=  1;
end
if task ==   1
% reads two image files

[filename1,pathname]=uigetfile('*.jpg','select cover the image'); 
x=imread(num2str(filename1))


[filename1,pathname]=uigetfile('*.jpg','select hiding the image'); 
y=imread(num2str(filename1))

%checkcompatibility
sx =   size  (x);
sy =   size  (y);

x= imresize  (x, [2*sy(1),2*sy(2)]);

%
% Applying shifting
x1 =   bitand (x,uint8(252));
y1 =   bitshift  (y,-4);
y1_=   bitand   (y1,12);
y1_=   bitshift (y1_,-2); 
y1 =   bitand  (y1,3); 
y_lsb1 =   bitshift (bitand(y,12),-2);
y_lsb2 =  bitand  (y,3);
z= x1;
for j=1:sy(2) 
for i=1:sy(1) 
for k=1:3

z (i ,j ,k) = bitor (x1(i,j,k), y1_(i,j,k));
z (i+sy(1) ,j+sy(2),k) = bitor (x1(i+sy(1) ,j+sy(2),k), y1(i,j,k));
z (i+sy(1) ,j,k) = bitor (x1(i+sy(1),j ,k), y_lsb1(i,j,k));
z (i,j+sy(2) ,k) = bitor (x1(i,j+sy(2) ,k), y_lsb2(i,j,k));
end
end
end
z=z
%  the first image
figure(1)
image (x);
xlabel(' Ist Image ');
%  IInd image
figure(2);
image (y);
xlabel(' IInd Image ');
%  encoded image
figure(3);
image (z);
xlabel(' Encoded Image ');
% saving image file
sav= input('Do you want to save the file y/n [y] ','s');
if isempty(sav)
sav='y';
end
if sav == 'y'
name= input('Enter a name for the encoded image: ','s');
if isempty (sav)
name= 'encoded_temp';
end
name=[name,'.bmp']; % concatination
imwrite (z, name,'bmp');
end
else
% Decoding encoded image
clear;
[filename1,pathname]= uigetfile('*.bmp','select cover the image'); 
z=imread (num2str(filename1));
sy = size(z)/2; % take the size of input file

% shifting 
xo= bitand (z,uint8(252));
xo= imresize (xo,[sy(1),sy(2)]) % reduce the resolution to half so

%that it becoms the original image's resolution
for j=1:sy(2) % y variation
    
for i=1:sy(1) % x variation
    
for k=1:3
 zout1(i,j,k) =  bitshift (bitand(z(i,j,k),uint8(3)),2);
 
 zout2(i,j,k) =  bitand (z(i+sy(1),j+sy(2),k), uint8(3));
 
 zout3(i,j,k) =  bitshift (bitand(z(i+sy(1),j,k),uint8(3)),2);
 
 zout4(i,j,k) =  bitand  (z(i,j+sy(2),k),uint8(3));
 
end
end
end
 zout =  bitshift ((zout1+zout2),4)+zout3+zout4;
 
 yo =  zout;
 
 % display Ist & IInd image from encoded image
 
 figure(4);
 
 image(xo);
 
 xlabel ('Ist Decoded Image ');
 
 figure (5);
 
image (yo);

 xlabel ('IInd Decoded Image');
 
% saving file
 sav= input ('Do you want to save the file y/n [y] ','s');
 
 if isempty ( sav)
     
 sav='y';
 end
if sav == 'y'
name1 = input('Enter a name for the first image: ','s');

name2 = input('Enter a name for the second image: ','s');

 if isempty(name1)
     
 name1 = 'Ist_temp';
 
 end
 if isempty(name2)
     
 name2 = 'IInd_temp';
 end
 name1 = [name1, '.bmp']
 
 name2 = [name2, '.bmp']
 
 imwrite(xo,name1, 'bmp')
 
 imwrite(yo,name2, 'bmp')
 
end
end
 






