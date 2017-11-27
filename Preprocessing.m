% ������ͼ��������Ӧ�á��γ̴���ҵԤ�������������ȡ����
% Writer:  Wu Chengpeng
% Time: 2017/11/20
% Input:
%       1. nii_path, nii�ļ�·��
clear;clc;close all
%% ====================Loading Data==================================
nii_path = 'Brats17_2013_2_1';
t1_struct = load_nii(strcat(nii_path,'\',nii_path,'_t1.nii'));
t2_struct = load_nii(strcat(nii_path,'\',nii_path,'_t2.nii'));
t1ce_struct = load_nii(strcat(nii_path,'\',nii_path,'_t1ce.nii'));
flair_struct = load_nii(strcat(nii_path,'\',nii_path,'_flair.nii'));
[img_w,img_h,img_d] = size(t1_struct.img);          % ��ά���ݴ�С

%% ====================Part 1: Smooth and Normalized=================
% ��˹ƽ��
sigma = 1.5;                                            % ��׼��
window = double(uint8(3*sigma)*2+1);                  % ���ڴ�Сһ��Ϊ3*sigma??
H = fspecial('gaussian',window,sigma);                % �����˲�ģ��??
% img_gauss = imfilter(img,H,'replicate');
t1_smooth = t1_struct;
for dd = 1:img_d
    img = t1_struct.img(:,:,dd);
    t1_smooth.img(:,:,dd) = imfilter(img,H,'replicate');    
end

t1ce_smooth = t1ce_struct;
for dd = 1:img_d
    img = t1ce_struct.img(:,:,dd);
    t1ce_smooth.img(:,:,dd) = imfilter(img,H,'replicate');    
end

t2_smooth = t2_struct;
for dd = 1:img_d
    img = t2_struct.img(:,:,dd);
    t2_smooth.img(:,:,dd) = imfilter(img,H,'replicate');    
end

flair_smooth = flair_struct;
for dd = 1:img_d
    img = flair_struct.img(:,:,dd);
    flair_smooth.img(:,:,dd) = imfilter(img,H,'replicate');    
end
% ��һ��
t1_min = min(min(min(t1_smooth.img)));
t1_max = max(max(max(t1_smooth.img)));

%% ====================Part 2: Extract Features======================

