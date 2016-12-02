clc; clear;
im = imread('salt-pep.png');

W = 3:21:101;
d = 3:21:101;
t = 1;

for  N = 3 : 21 : 101
    
    %Pad the boundary of image 
    pad_size = floor(N/2);
    pad_img = padarray(im, [pad_size pad_size]);
    filtered_img=zeros(size(im));
   
    tic;
    for i = 1:size(pad_img,1) - N + 1
        for j = 1:size(pad_img,2) - N + 1
            window = zeros(N^2,1); 
            inc = 1;
            
            for x = 1 : N
                for y = 1 : N
                    window(inc) = pad_img(i+x-1, j+y-1);
                    inc = inc+1;
                end
            end
            
            win_median = sort(window);
            filtered_img(i,j) = win_median(floor(size(window,1)/2));
            
        end
    end
    
    filtered_img = uint8(filtered_img);
    d(t)=toc;
%     figure, imshow(filtered_img);
    t = t+1;
end
plot(W, d, '-ro')