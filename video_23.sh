#!/usr/bin/env python3
import random
import urllib
import numpy as np
from matplotlib import style
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from mpl_finance import candlestick_ohlc


style.use('ggplot')
'''
		We are trying to fill the ax3 in a case that the fill color is green when the blue chart is above the red chart,
		and we fill with red when red chart is above the blue chart.
		
		Simple and easy. delicious maybe.
		
		have a look at this url:
		https://matplotlib.org/2.1.1/gallery/lines_bars_and_markers/fill_between_demo.html
		
'''
MA1 = 5
MA2 = 50


def moving_average(values, window):
	weights = np.repeat(1.0, window) / window
	smas = np.convolve(values, weights, 'valid')
	return smas

def high_minus_low(highs, lows):
	return highs-lows
	
# ~ h_l = list(map(high_minus_low, highs, lows)) #This is a quick way to apply the function into each corresponding elements of two list, otherwise we can use the for-loop
# ~ print(h_l)

def bytespdate2num(fmt, encoding = 'utf-8'):
	strconverter = mdates.strpdate2num(fmt)
	def bytesconverter(b):
		s = b.decode(encoding)
		return strconverter(s)
	return bytesconverter

def graph_data(stock):
	fig = plt.figure()
	fig.patch.set_facecolor('#ccdef9') # set background color of the figure
	
	ax1 = plt.subplot2grid((6, 1), (0, 0), rowspan = 1, colspan = 1)
	plt.title(stock)
	plt.ylabel('H-L')
	ax2 = plt.subplot2grid((6, 1), (1, 0), rowspan = 4, colspan = 1)
	plt.ylabel('Price(USD)')
	ax3 = plt.subplot2grid((6, 1), (5, 0), rowspan = 1, colspan = 1)
	plt.ylabel('MAvgs')
	
	stock_price_url = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/1y?format=csv'
	source_code = urllib.request.urlopen(stock_price_url).read().decode()
	stock_data = []
	split_source = source_code.split('\n')
	
	for line in split_source:
		split_line = line.split(',')
		stock_data.append(line)		
	date, openp, highp, lowp, closep, volumep = np.loadtxt(stock_data, 
														delimiter = ',', 
														unpack=True,
														skiprows=1,
														usecols=(0,1,2,3,4,5),
														converters={0:bytespdate2num('%Y-%m-%d')})
	
	x = 0
	y = len(date)
	ohlc = []
	while x < y:
		append_me = date[x], openp[x],highp[x], lowp[x], closep[x], volumep[x]
		ohlc.append(append_me)
		x+=1
	
	ma1 = moving_average(closep , MA1)
	ma2 = moving_average(closep , MA2)
	start = len(date[MA2-1:])
	
	h_l = list(map(high_minus_low, highp, lowp))
	ax1.plot_date(date, h_l, '-')
	
	candlestick_ohlc(ax2, ohlc, width = 0.15, colorup='#096d09', colordown='#9b287c') #color from http://www.color-hex.coms
	
	for label in ax2.xaxis.get_ticklabels():
		label.set_rotation(35)
	
	
	bbox_props = dict(boxstyle="round4, pad=0.4", 
					fc="#edef7c", # Face color 
					ec="#000000", #edge color
					lw=0.5) #line width
	ax2.annotate(
				str(closep[-1]), #string format of the annotation text
				(date[-1], closep[-1]),  # the place the annotation pointing to
				xytext = (date[-1]+3 , closep[-1]), # the (x, y) location of the annotation, +3 guarantee the annotation will be off the graph on right side
				bbox = bbox_props) # the property of the box around the annotation.

	SlowSMV = ax3.plot(date[-start:], ma1[-start:], linewidth = 1, label = 'Slow')
	FastSMV = ax3.plot(date[-start:], ma2[-start:], linewidth = 1, label = 'Fast')
	ax3.legend()
	
	ax3.fill_between(date[-start:], ma2[-start:], ma1[-start:], where=(ma1[-start:] < ma2[-start:]), 
					facecolor= '#096d09', edgecolor = 'r', alpha = 0.55)
	ax3.fill_between(date[-start:], ma2[-start:], ma1[-start:], where=(ma1[-start:] > ma2[-start:]), 
					facecolor= '#9b287c', edgecolor = 'r', alpha = 0.55)
	
	ax3.xaxis.set_major_formatter(mdates.DateFormatter('%Y/ %m/ %d'))
	for label in ax3.xaxis.get_ticklabels():
		label.set_rotation(35)

	# ~ plt.legend(title = 'Ebay', borderaxespad=0.8, loc=2)
	
	plt.setp(ax1.get_xticklabels(), visible=False)
	plt.setp(ax2.get_xticklabels(), visible=False)
	
	#now the problem is that the label goes off the screen, we need to modify the margin
	plt.subplots_adjust(top=0.88, right=0.850, bottom=0.165, left=0.14, wspace = 0.2, hspace=0.2)
	plt.show()

graph_data('EBAY')






