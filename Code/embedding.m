% Image Steganography - Hide a Message with Length in an Image (User 
Input) 
% Prompt the user for input 
coverImageFile = input('Enter the filename of the cover image: ', 's'); 
message = input('Enter the message to hide: ', 's'); 
% Read the cover image 
coverImage = imread(coverImageFile); 
[rows, cols, channels] = size(coverImage); 
% Convert the message to binary (ASCII) 
binaryMessage = reshape(dec2bin(message, 8).', 1, []); % Convert message to 
binary 
messageLength = length(binaryMessage); 
% Convert message length to binary (store length in 32 bits) 
binaryMessageLength = dec2bin(messageLength, 32); 
% Combine the length and the message in binary 
binaryData = [binaryMessageLength, binaryMessage]; 
% Ensure the image has enough capacity (considering just the first channel) 
if length(binaryData) > rows * cols 
 error('Message is too large to fit in the cover image'); 
end 
% Flatten the first channel into a 1D array 
imageData = coverImage(:,:,1); 
imageData = imageData(:); 
% Embed the binary message and its length in the least significant bit of the 
image 
for i = 1:length(binaryData) 
 imageData(i) = bitset(imageData(i), 1, str2double(binaryData(i))); 
end 
% Reshape and replace the modified channel back into the image 
stegoImage = coverImage; 
stegoImage(:,:,1) = reshape(imageData, rows, cols); 
% Save the stego image 
stegoImageFile = input('Enter the filename to save the stego image 
(with extension): ', 's'); 
imwrite(stegoImage, stegoImageFile); 
disp('Message and length embedded successfully!');
