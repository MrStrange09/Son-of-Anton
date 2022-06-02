function [display] = UndoRedo(store,ind)
 
 temp = store(ind+1:ind+2);
 
 switch temp
     case 're'
         display = 'redImg.jpg';
     case 'bl'
         display = 'blueImg.jpg';
     case 'gr'
         display = 'GreenImg.jpg';
     case 'cy'
         display = 'CyanImg.jpg';
     case 'pi'
         display = 'PinkImg.jpg';
     case 'ye'
         display = 'YellImg.jpg';
     case 'pn'
         display = 'PeriodicNImg.jpg';
     case 'sn'
         display = 'SnPNoiseImg.jpg';
     case 'gn'
         display = 'GnoiseImg.jpg';
     case 'rg'
         display = 'GrayImg.jpg';
     case 'rb'
         display = 'RGB2bwImg.jpg';
     case 'sh'
         display = 'SharpenImage.jpg';
     case 'gf'
         display = 'GFilterImg.jpg';
     case 'mn'
         display = 'mfiltimg.jpg';
     case 'md'
         display = 'MedFilterImg.jpg';
     case 'br'
         display = 'brightImg.jpg';
     case 'co'
         display = 'contrastImg.jpg';
     case 'vi'
         display = 'vigneImg.jpg';
     case 'hi'
         display = 'HistEqImg.jpg';
     case 'vh'
         display = 'ViewHist.jpg';
     case 'ro'
         display = 'RotateImg.jpg';
     case 'fl'
         display = 'FlipImg.jpg';
     case 'pt'
         display = 'powerTransformImg.jpg';
     case 'lt'
         display = 'logTransformImg.jpg';
     case 'ft'
         display = 'fourierTransform.jpg';
     case 'se'
         display = 'SobelImg.jpg';
     case 'ce'
         display = 'CannyEdge.jpg';
     case 'bw'
         display = 'OrgImg.jpg';
     otherwise 
         display = 'itallends.jpg'; 
 end
 
end