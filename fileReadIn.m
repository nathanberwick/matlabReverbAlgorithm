function output = fileReadIn(inputLine, key)

	index = strfind(inputLine, key); %find this variable
    inputLine(strfind(inputLine, '=')) = []; %remove =
    output = sscanf(inputLine(index(1) + length(key):end), '%g', 1);
    