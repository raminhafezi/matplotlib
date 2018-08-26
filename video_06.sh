#!/usr/bin/env python
import matplotlib.pyplot as plt

''' 
	We are talking about Pie_Chart
	startangel = 90 -> means to rotate the chart in clockwise
	explode = (0, 0.1, 0, 0) is a way to gain focus on the second pie section which is Eating at this pie chart
	autopct is write the percentage of each section and the %1.1f%% is a code to write percentage. for example 29.2 becomes 29.2%.
	The usage of the pie chart is that matplotlib calculate the percentage and the size of each secction in the pie chart automatically.
	 
'''
slices = [7,2,5,9]
Labels = ["Sleeping", "Eating", "Playing", "Working"]

Colors = ["cyan", "blue", "grey", "green"]

plt.pie(
		slices, 
		colors = Colors , 
		labels = Labels, 
		startangle = 90, 
		explode = (0, 0.04, 0, 0),
		shadow = True,
		autopct = "%1.1f%%" )

plt.title('Pie chart')
plt.legend()
plt.show()
