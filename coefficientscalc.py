import json
import numpy
import math
import cmath
def euler(exponent): #calculates e^(exponent*i) using euler's formula
    return complex(math.cos(exponent),math.sin(exponent))
with open("svgpoints2.json","r") as pointsjson:
    points = json.load(pointsjson)
dx = 1/913 #the difference in input between each point (ie. 1/(total number of points-1))
coefficientrange = [-500,500] #the range of coefficients to compute (inclusive)
complexpoints = []
for point in points:
    complexpoints.append(complex(float(point[0]),float(point[1])))
coeffarr = []
coefflist = [] 
for i in range(0,coefficientrange[1]+1):
    coefflist.append(i)
maxcoeff = coefficientrange[0]
for i in range(-1,maxcoeff-1,-1):
    coefflist.insert(abs(i)*2,i)
for coeff in coefflist: #order [0,1,-1,2,-2,3,-3,4,-4 etc.]
    xinput = []
    yinput = []
    pointscounter = 0
    coeffconst = math.pi*-2*coeff #-n*2pi
    for point in complexpoints:
        cpoint = euler(pointscounter*coeffconst)*point
        pointscounter += dx #pointscounter = t
        xinput.append(cpoint.real)
        yinput.append(cpoint.imag)
    xcoeff = numpy.trapz(xinput,dx=dx)
    ycoeff = numpy.trapz(yinput,dx=dx)
    if coeff == 0:
        coeffarr.append([coeff,xcoeff,ycoeff])
    else:
        appendlist = list(cmath.polar(complex(xcoeff,ycoeff)))
        appendlist.insert(0,coeff)
        appendlist[2] = appendlist[2]%(2*math.pi)
        coeffarr.append(appendlist)
with open("coeffs2.json","w") as coeffsjson:
    json.dump(coeffarr,coeffsjson)