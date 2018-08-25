#!/usr/bin/env python
import matplotlib.pyplot as plt

''' 
	We are talking about Pie_Chart
	startangel = 90 -> means to rotate the chart in clockwise
	explode = (0, 0.1, 0, 0) is a way to gain focus on the second pie section which is Eating at this pie chart
	autopct is write the percentage of each section and the %1.1f%% is a code to write percentage
	
	 
'''
days = ["Saturday", "Sunday", "Monday", "Tuesday","Wednesday", "Thursday", "Friday"]
sleeping = [10, 9, 7, 8, 9, 8, 9 ]
eating = [4, 4, 3, 2, 1, 2, 4]
playing = [8, 10, 4, 1, 6, 5, 3]
working = [2, 1, 10, 13, 8, 9, 8]

clices = [7,2,2,13]
Colors = ["cyan", "blue", "grey", "green"]
Labels = ["Sleeping", "Eating", "Playing", "Working"]

plt.pie(clices, 
		colors = Colors , 
		labels = Labels, 
		startangle = 45, 
		explode = (0, 0.1, 0, 0),
		autopct = "%1.1f%%" )

plt.title('Pie chart\n Check it out')

plt.legend()
plt.show()
