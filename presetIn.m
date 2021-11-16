function output = presetIn(filename, input)

if (isfile(filename)) %if file exists, read in values
    load(filename, 'params');
    output = params;
else                  %output the original parameters
    warning('preset file does not exist. retuning to default parameters');
    output = input;
end