#!/usr/bin/env python3
import matplotlib.pyplot as plt
import urllib
import numpy as np
import matplotlib.dates as mdates
'''  
	We are talking about the time conversion, in the python if you import time lib
	and then print time.time(), it gives you the unix tmie, which is less readable and need conversion.
	
	
	Look at this address for XKCD color code
	https://matplotlib.org/users/colors.html
	
	For customizing the numbers on the Y axise we user 
	
	ax1.set_yticks([ , , , ])
	
	Fill the graph with color with 
		ax1.fill_between(, , line, alpha=0.3), 
			line is an integer and we fill upper and lower of that line 
			alpha is a sharpness of the color
	
	For setting the backgrund color we customize the figure 
	
	fig.patch.set_facecolor('xkcd:mint green')
'''

def bytespdate2num(fmt, encoding = 'utf-8'):
	strconverter = mdates.strpdate2num(fmt)
	def bytesconverter(b):
		s = b.decode(encoding)
		return strconverter(s)
	return bytesconverter


def graph_date(stock):
	fig = plt.figure()
	fig.patch.set_facecolor('xkcd:mint green') # set background color of the figure
	ax1 = plt.subplot2grid((1,1), (0, 0) ) 
	
	lowestp = highestp = 0
		
	stock_price_url = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/5y?format=csv'
	source_code = urllib.request.urlopen(stock_price_url).read().decode()
	stock_data = []
	split_source = source_code.split('\n')
	
	for line in split_source:
		split_line = line.split(',')
		stock_data.append(line)		
	date, openp, highp, lowp, closep, volume = np.loadtxt(stock_data, 
														delimiter = ',', 
														unpack=True,
														skiprows=1,
														usecols=(0,1,2,3,4,5),
														converters={0:bytespdate2num('%Y-%m-%d')})
	
	print(np.amax(closep))
	print(np.amin(closep))
	ax1.plot_date(date, closep, '-', label='Price', color='xkcd:maroon')
	
	#let modify the date on the axis of the graph
	for label in ax1.xaxis.get_ticklabels():
		#rotate the label 45 degree
		label.set_rotation(45)
	
	#This grid help to put web like texture underline the graph
	ax1.grid(True) #, linestyle = ':', color='blue', linewidth=0.08)
	ax1.xaxis.label.set_color('r')
	ax1.yaxis.label.set_color('r')
	
	max_closep = np.amax(closep)//10*10
	min_closep = np.amin(closep)//10*10
	
	sorted_Yaxise_list = np.arange(min_closep, min_closep, (max_closep - min_closep)/10) #generate the Y axise number with 25 gap in between each number
	print(sorted_Yaxise_list)
	sorted_Yaxise_list = np.insert(sorted_Yaxise_list, 0, min_closep) # add the minimum number
	sorted_Yaxise_list = np.insert(sorted_Yaxise_list, 0, max_closep) # add the maximum number
	print("Final Y numbers range {}", sorted_Yaxise_list)
	ax1.set_yticks(sorted_Yaxise_list) # set the portion on the Y axise
	#ax1.fill_between(date, closep, 0, alpha = 0.3)  # fill the graph
	#ax1.fill_between(date, closep, ((max_closep + min_closep)//2), where=(closep > closep[850]), alpha = 0.3) # so we put an average price line and fill any price more than average line

	ax1.fill_between(date, closep, closep[850], where=(closep > closep[850]), facecolor = 'g', alpha = 0.3) # we make happy day, win day
	ax1.fill_between(date, closep, closep[850], where=(closep < closep[850]), facecolor = 'r', alpha = 0.3) # we show the sad day, lost day
	
	plt.xlabel('Date')
	plt.ylabel('Price(USD)')
	plt.title('Ebay Stock Price, 5 years')
	plt.legend(title = 'Ebay', borderaxespad=0.8, loc=2)
	
	#now the problem is that the label goes off the screen, we need to modify the margin
	plt.subplots_adjust(top=0.88, right=0.900, bottom=0.165, left=0.165, wspace = 0.2, hspace=0.2)
	plt.show()

graph_date('EBAY')

