#!/usr/bin/env python
import matplotlib.pyplot as plt
import csv 
import numpy as np

''' 
	We are talking about loading data from file
	it depends on the type of the file, the file size.
	We are using numpy for this demonstration. and pull up from numpy. for installing numpy,
	I am using pip --> pip install numpy. At this time, 26 Aug 2018, pip version 18.0 and numpy version 1.15.0 is released.
	
'''
'''
#Part 1
x = []
y = []
with open('csv_example_video_07.txt') as csvfile:
	plot = csv.reader(csvfile, delimiter = ",")
	for row in plot:
		x.append(int(row[0]))
		y.append(int(row[1]))
'''
#Part 2
#numpy can load the file with the text on it.
x, y = np.loadtxt('csv_example_video_07.txt', delimiter = ",", unpack = True)

plt.plot(x, y, label="loaded from file")
plt.title('Pie chart')
plt.legend()
plt.show()
