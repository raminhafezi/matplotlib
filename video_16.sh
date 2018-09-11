#!/usr/bin/env python3
import matplotlib.pyplot as plt
import matplotlib.animation as animate 
from matplotlib import style

'''  
	we are talking about the live graph
	
	we use
	-->ax1.clear()
	
	function every time, to wipe out our figure before adding new things to figure.
	if we remove the clear() function, the figure will be updated by adding elements on top of each element.
	if we have to delete element and then redraw, they might have a new data or not, 
	
	
	interval = 1000, mean update every 1 second.
	
	
'''


style.use('fivethirtyeight')


fig = plt.figure()
ax1 = fig.add_subplot(1,1,1)


def animation(i):
	graph_data = open('csv_example_video_07.txt', 'r').read()
	lines = graph_data.split('\n')
	xs = []
	ys = []
	for line in lines:
		if len(line) > 1:
			x, y = line.split(',')
			xs.append(x)
			ys.append(y)
	
	ax1.clear() # bec
	ax1.plot(xs, ys)
	
ani = animate.FuncAnimation(fig, animation, interval = 1000)
plt.show()
