function output = createParameterStruct()
        %do not change. Default values.
        output.preDelay              = 0;
        output.wetDry                = 0.5;
        
        %Early reflections parameters
        output.ERMasterGain          = 1.0;
        output.ERLFGain              = 1.0;
        output.ERMidsGain            = 1.0;
        output.ERHFGain              = 1.0;
        output.isEROn                = true;
        output.roomSize              = 30;
        output.latestER              = 80;
        output.numberERs             = 10; %must be integer
        output.absorptionCoefficient = 0.7;
        
        %Late reflections parameters
        output.LRMasterGain          = 1.0;
        output.LRLFGain              = 1.0;
        output.LRMidsGain            = 1.0;
        output.LRHFGain              = 1.0;
        output.HFDamping             = 0.2;
        output.LROffset              = 0;
        output.reverbTime            = 40;
        output.spread                = 0.7;
        
        %Delay parameters
        output.tempo                 = 120;
        output.delayLineGain         = 0.0;
        output.delayLineFeedback     = 0.5;
        output.division              = 2;
        output.isDotted              = false;
        output.isTripleted           = false;
        output.isDelayFiltered       = true;
        output.delayCutoff           = 12000;
        
        %Chorus parameters
        output.chorusIntensity       = 0.5;
        output.chorusDepth           = 0.6;