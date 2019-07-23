# theMatlabPlanimeter

  Planimeter written in MATLAB as the final assignment for the Numerical Analysis (Cálculo Numérico) course at the Federal University of São Paulo, under Prof. Leduíno Salles Neto, Ph.D.


It takes an image as argument, through a file selection box. The user then has to draw a contour on the given image, which will be the area the planimeter will try to find. As a final step, the user has to draw a line on the image and then state how many meters the given line represents on a real world scale. The approximate result will be given on a dialog box.


We tested two approximation methods, one of them (ProgramaCompletoMetododosPixels.m) binarizing the image and then counting the number of relevant pixels (pixels inside the drawn contour) and then finally using the given scale to achieve a final approximation, while the other one makes an irregular polygon out of the drawn contour and then uses the Gauss' area formula (a.k.a. the shoelace formula) to find the area of the countour, to yet again use the given scale to achieve the final result.


It's been developed and tested on MATLAB 2018B.
