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
		We are trying to show the Ebay average stock price on the ax3 
		and also we will show some data on ax1 since ax2 showing the live stockprice
		In statistics, a moving average is a calculation to analyze data points by creating 
		series of averages of different subsets of the full data set. It is also called a 
		moving mean or rolling mean and is a type of finite impulse response filter. 
		Variations include: simple, and cumulative, or weighted forms	
		
		and also check this website
		https://www.investopedia.com/terms/m/movingaverage.asp
		
		How to Use Moving Averages
		Moving averages lag current price action because they are based on past prices; 
		the longer the time period for the moving average, the greater the lag. 
		Thus, a 200-day MA will have a much greater degree of lag than a 20-day MA because it 
		contains prices for the past 200 days. The length of the moving average to use depends 
		on the trading objectives, with shorter moving averages used for short-term trading 
		and longer-term moving averages more suited for long-term investors. 
		The 50-day and 200-day MAs are widely followed by investors and traders, 
		with breaks above and below this moving average considered to be important trading signals.
		
'''


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
	ax2 = plt.subplot2grid((6, 1), (1, 0), rowspan = 4, colspan = 1)
	plt.xlabel('Date')
	plt.ylabel('Price(USD)')
	ax3 = plt.subplot2grid((6, 1), (5, 0), rowspan = 1, colspan = 1)
	
	stock_price_url = 'https://api.iextrading.com/1.0/stock/'+stock+'/chart/1m?format=csv'
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
	
	candlestick_ohlc(ax2, ohlc, width = 0.15, colorup='#096d09', colordown='#9b287c') #color from http://www.color-hex.coms
	
	for label in ax2.xaxis.get_ticklabels():
		label.set_rotation(35)
	
	ax2.xaxis.set_major_formatter(mdates.DateFormatter('%Y/ %m/ %d'))
	
	bbox_props = dict(boxstyle="round4, pad=0.4", 
					fc="#edef7c", # Face color 
					ec="#000000", #edge color
					lw=0.5) #line width
	ax2.annotate(
				str(closep[-1]), #string format of the annotation text
				(date[-1], closep[-1]),  # the place the annotation pointing to
				xytext = (date[-1]+3 , closep[-1]), # the (x, y) location of the annotation, +3 guarantee the annotation will be off the graph on right side
				bbox = bbox_props) # the property of the box around the annotation.



	#plt.legend(title = 'Ebay', borderaxespad=0.8, loc=2)
	
	#now the problem is that the label goes off the screen, we need to modify the margin
	plt.subplots_adjust(top=0.88, right=0.650, bottom=0.265, left=0.365, wspace = 0.2, hspace=0.2)
	plt.show()

graph_data('EBAY')



