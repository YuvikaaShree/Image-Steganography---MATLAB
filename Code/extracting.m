% Image Steganography - Extract a Message from an Image (User Input) 
% Prompt the user for input 
stegoImageFile = input('Enter the filename of the stego image : ', 's'); 
% Read the stego image 
stegoImage = imread(stegoImageFile); 
% Flatten the first channel into a 1D array 
stegoData = stegoImage(:,:,1); 
stegoData = stegoData(:); 
% Extract the first 32 bits (message length) 
extractedLengthBits = mod(stegoData(1:32), 2); % Get the LSBs 
extractedMessageLength = bin2dec(num2str(extractedLengthBits.')); 
% Prompt user to input the expected number of characters in the message 
userSpecifiedMessageLength = input('Enter the number of characters you 
expect in the hidden message: '); 
% If the user-specified length does not match the extracted length, show an 
error 
if userSpecifiedMessageLength * 8 ~= extractedMessageLength 
 error('The number of characters you specified does not match the hidden 
message length.'); 
end 
% Extract the actual message bits (based on the extracted message length) 
binaryMessageLength = extractedMessageLength; 
extractedBits = mod(stegoData(33:32 + binaryMessageLength), 2); % Get the 
LSBs 
% Group bits into 8-bit chunks (as a string of '0' and '1') 
extractedBinaryMessage = reshape(extractedBits, 8, []).'; % Reshape to 8-bit 
groups 
% Convert the 8-bit binary values to characters (avoid num2str issue) 
extractedMessage = char(bin2dec(num2str(extractedBinaryMessage)))'; 
% Display the extracted message 
disp(['Extracted Message: ', extractedMessage]);
