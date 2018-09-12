#!/usr/bin/env python3
import random
import matplotlib.pyplot as plt
from matplotlib import style

style.use('ggplot')
'''
		We are talking about the subplot, we ahve two methods to make subplot.
		
		Method #1 --->subplot
		
		we make subplot by adding subplot to the figure and then appointing the number to the subplot.
		
		----> fig.add_subplot(111)
		the first 1 is the hight
		the second 1 i the with
		the third 1 is the plot number
		
		have a look at this address to learn more about the matpolotlib.pyplot.subolot
		https://matplotlib.org/api/_as_gen/matplotlib.pyplot.subplot.html
		
		subplot(nrows, ncols, index, **kwargs)
		so subplot(2,2,1) means
			we have 2 rows
			we have 2 columns
			and this is the plot number 1 in the figure so, 
			
			and this graph take row number 1, and columns number 1 so on the top left corner,
			
		  subplot(2,2,2)
		   this means this plot takes row number 2 
		   and column number 2
		   and this is the second graph on the this row 
		   
		   so this plot will be placed on the top right corner of the figure
		   
		   
		   subplot(2,1,2)
		    this means this we have two rows
		    and 1 column and 
		    this is the second graph, because subplot(2,2,1) is on the top left,
		    this plot will be on the whole botton
		    
		    221 ----- 222
		    <----212 --->
			
		Method #2 subplot.2grid
		
		plt.subplot2grid( (, ) here is the your whole grid , you have to specify total number of rows and columns,
						  (, ) here is the starting point of your subplot, 
						  rowspan = #,
						  colspan = #
						  )
		
		here is an example of 6 rows, 2 columns grid that the first subplot start from top left (0,0) and consume the whole first two rows
		plt.subplot2grid((6, 1), (0, 0), rowspan=2, colspan=1)
		
		
		
'''
fig = plt.figure()

def create_plot():
	xs = []
	ys = []
	
	for i in range(10):
		x = i
		y = random.randrange(10)
		
		xs.append(x)
		ys.append(y)
	print("xs : {}, \nys : {}\n".format(xs, ys))
	return xs, ys


#Method #1
		
#ax1 = fig.add_subplot(3,3,1)
#ax2 = fig.add_subplot(3,3,3)
#ax3 = fig.add_subplot(3,1,3)

#method #2
ax1 = plt.subplot2grid((6, 4), (0, 0), rowspan=2, colspan=2 )
ax2 = plt.subplot2grid((6, 4), (0, 2), rowspan=2, colspan=2 )
ax3 = plt.subplot2grid((6, 1), (3, 0), rowspan=3, colspan=1 )


x, y = create_plot()
ax1.plot(x, y)

x, y = create_plot()
ax2.plot(x, y)

x, y = create_plot()
ax3.plot(x, y)


plt.show()
