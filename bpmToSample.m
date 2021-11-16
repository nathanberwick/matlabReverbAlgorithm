function output = bpmToSample(params, Fs)

wholeNoteValue = 240000;

%% note length
beatValue = wholeNoteValue / params.division;

%% dotted or tripleted
if (params.isDotted == true)
    beatValue = beatValue * 1.5;
end

if (params.isTripleted == true)
    beatValue = beatValue * (2/3);
end

%% convert to ms
ms = beatValue/params.tempo;

%% convert to sample

output = round(ms * (Fs/1000));