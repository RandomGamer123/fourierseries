# fourierseries
Turns a series of points (extractable from a svg file, by using a tool such as https://github.com/Shinao/PathToPoints) to a fourier series using python and visualises it with processing.

What the files do:

coefficientscalc.py -> Computes the coefficients needed for the Processing file and stores it in a json file. 
Input format: JSON file [[x value of point 1, y value of point 1],[x value of point 2, y value of point 2], etc.]
Output format: JSON file [[freq,real part of coeff 0 (start pos x), imag part of coeff 0 (start pos y)],[freq,length of coeff 1,angle of coeff 1],[freq,length of coeff -1,angle of coeff -1],[freq,length of coeff 2,angle of coeff 2],[freq,length of coeff -2,angle of coeff -2],[freq,length of coeff 3,angle of coeff 3]etc.]
Configs needed to set by editing the file:
dx = 1/913 #the difference in input between each point (ie. 1/(total number of points-1))
coefficientrange = [-500,500] #the range of coefficients to compute (inclusive)

fouriervisualiser.pde -> Takes the coefficients from coefficientscalc.py and visualises them by saving them into a file for each frame, which can be made into a video using FFMPEG.
Input format: JSON file [[freq,real part of coeff 0 (start pos x), imag part of coeff 0 (start pos y)],[freq,length of coeff 1,angle of coeff 1],[freq,length of coeff -1,angle of coeff -1],[freq,length of coeff 2,angle of coeff 2],[freq,length of coeff -2,angle of coeff -2],[freq,length of coeff 3,angle of coeff 3]etc.]
Output format: Multiple .png files, each representing a frame.
Configs needed to be set by editing the file:
int[] midadj = {800,450}; //represents an offset to the center
Pointer[] pointerarr = new Pointer[1000]; //edit this to be equal to the number of pointers
float scale = 5.8;  //represents the amount you want to scale the visualisation up by
float baseangleincrement = 0.01; //represents the speed
float[] pointsx = new float[700]; //edit this to be larger than TAU/baseangleincrement
float[] pointsy = new float[700];

pointstojson.py -> Converts a .txt file with each point on a new line into the JSON file format needed for coefficientcalc.py.
Input format: .txt file x1,y1 \n x2,y2 \n (etc.)
Output format: JSON file [[x value of point 1, y value of point 1],[x value of point 2, y value of point 2], etc.]
